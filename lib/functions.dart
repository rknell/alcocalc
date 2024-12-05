import 'tables/oiml.dart';

class AlcocalcFunctions {
  DilutionResult diluteByWeight({
    required double startingABV,
    required double startingTemperature,
    required double targetABV,
    required double startingWeight,
  }) {
    final correctedStartingABV =
        OIMLTables.tableVIIIb(startingABV, startingTemperature);
    final startingABW = OIMLTables.tableIVb(correctedStartingABV);

    final totalWeightOfAlcohol = startingWeight * startingABW;

    final targetABW = OIMLTables.tableIVb(targetABV);

    var densityOfAlcohol = OIMLTables.tableIIIa(1.0)/1000;
    final LALs = totalWeightOfAlcohol / densityOfAlcohol;
    final startingVolume = startingWeight / (OIMLTables.tableII(startingABV, 20) /1000);
    final multiplier = startingABW / targetABW;

    final targetWeight = startingWeight * multiplier;
    final additionalWeight = targetWeight - startingWeight;

    final targetDensity = OIMLTables.tableII(targetABV, 20) / 1000;

    final targetVolume = targetWeight / targetDensity;

    // print('Corrected starting abv: ${correctedStartingABV.toStringAsFixed(4)}');

    return DilutionResult(
        targetWeight: targetWeight,
        additionalWeight: additionalWeight,
        totalWeightOfAlcohol: totalWeightOfAlcohol,
        targetVolume: targetVolume, targetABV: targetABV, startingVolume: startingVolume, correctedStartingABV: correctedStartingABV);
  }

  double correctedABV(double percentABV, double temperature) =>
      OIMLTables.tableVIIIb(percentABV, temperature);

  double abvToAbw(abv) => OIMLTables.tableIVb(abv);
}

class DilutionResult {
  double targetWeight;
  final double additionalWeight;
  final double totalWeightOfAlcohol;
  final double targetVolume;
  double get acceptableABVHigh => double.parse((targetABV * 1.005).toStringAsFixed(4));
  double get acceptableABVLow => double.parse((targetABV * .998).toStringAsFixed(4));
  final double targetABV;
  final double startingVolume;
  final double correctedStartingABV;

  double get lals => targetVolume * targetABV;

  DilutionResult(
      {required this.targetWeight,
      required this.additionalWeight,
      required this.totalWeightOfAlcohol,
      required this.targetVolume, required this.targetABV, required this.startingVolume, required this.correctedStartingABV});

  @override
  String toString() => """
  LALs: ${lals.toStringAsFixed(2)}
  Target weight: ${targetWeight.toStringAsFixed(2)}
  Additional weight: ${additionalWeight.toStringAsFixed(2)}
  Total weight of alcohol: ${totalWeightOfAlcohol.toStringAsFixed(2)}
  Total Target Volume: ${targetVolume.toStringAsFixed(2)}
  Total Target Bottles: ${(targetVolume / .7).toStringAsFixed(1)}
  Target ABV range: $acceptableABVLow - $acceptableABVHigh
  """;
}

void liqueurDilution({required double startingWeight, required double startingABV, required double startingTemperature, required List<Sugars> sugars, required double targetABV}) {
  var date = DateTime.now();
  print("Date: ${date.day}/${date.month}/${date.year}");
  print("Starting weight ${startingWeight.toStringAsFixed(2)}");

  final alcocalc = AlcocalcFunctions();
  final result = alcocalc.diluteByWeight(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: startingWeight,
  );

  print("ABV @ 20deg: ${result.correctedStartingABV.toStringAsFixed(4)}");
  print("LALs: ${result.lals.toStringAsFixed(2)}");

  for (var sugar in sugars) {
    sugar.weight =
        result.targetWeight * sugar.specificGravity * sugar.percentage;
  }

  final equivalentWaterWeightUsed = sugars.fold<double>(
      0.0,
          (previousValue, element) =>
      element.equivalentWaterWeight + previousValue);

  final waterWeight = result.additionalWeight - equivalentWaterWeightUsed;

  // print('Water - Weight: ${waterWeight.toStringAsFixed(2)}, Target Weight: ${(startingWeight + waterWeight).toStringAsFixed(2)}');

  print("Additional litres of water: ${waterWeight.toStringAsFixed(2)}");
  print("Calculated target weight after water: ${(startingWeight + waterWeight).toStringAsFixed(2)}");


  var weightOfAlcohol = result.totalWeightOfAlcohol;
  var totalWeight = startingWeight + waterWeight;
  var abw = weightOfAlcohol/totalWeight;
  var abvAfterWater = OIMLTables.tableIIIb(abw);

  var acceptableABVHigh = double.parse((abvAfterWater * 1.005).toStringAsFixed(4));
  var acceptableABVLow = double.parse((abvAfterWater * .998).toStringAsFixed(4));

  print("Calculated ABV: ${abvAfterWater.toStringAsFixed(4)}");
  print("Measured ABV must be between: $acceptableABVLow and $acceptableABVHigh");

  var runningSugarWeight = 0.0;
  for (var sugar in sugars) {
    runningSugarWeight += sugar.weight;
    print(
        'Sugar - ${sugar.name} - Weight: ${sugar.weight.toStringAsFixed(2)}, Target Weight: ${(startingWeight + waterWeight + runningSugarWeight).toStringAsFixed(2)}');
  }
  print("\nChecks:");
  print("Expected bottles: ${(result.targetVolume / .7).toStringAsFixed(1)}");
}

class Sugars {
  final String name;
  final double specificGravity;
  final double percentage;
  double weight = 0;
  double get equivalentWaterWeight => weight / specificGravity;

  Sugars(
      {required this.name,
        required this.specificGravity,
        required this.percentage})
      : assert(percentage < 1, "Percentage much be a decimal");
}
