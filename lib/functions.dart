import 'tables/brix.dart';
import 'tables/oiml.dart';

class AlcocalcFunctions {
  _DiluteByWeightResult _diluteByWeight({
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

    // var densityOfAlcohol = OIMLTables.tableIIIa(1.0)/1000;
    // final LALs = totalWeightOfAlcohol / densityOfAlcohol;
    final startingVolume =
        startingWeight / (OIMLTables.tableII(startingABV, 20) / 1000);
    final multiplier = startingABW / targetABW;

    final targetWeight = startingWeight * multiplier;
    final additionalWeight = targetWeight - startingWeight;

    final targetDensity = OIMLTables.tableII(targetABV, 20) / 1000;

    final targetVolume = targetWeight / targetDensity;

    // print('Corrected starting abv: ${correctedStartingABV.toStringAsFixed(4)}');

    return _DiluteByWeightResult(
        targetWeight: targetWeight,
        additionalWeight: additionalWeight,
        totalWeightOfAlcohol: totalWeightOfAlcohol,
        targetVolume: targetVolume,
        targetABV: targetABV,
        startingVolume: startingVolume,
        correctedStartingABV: correctedStartingABV);
  }

  double correctedABV(double percentABV, double temperature) =>
      OIMLTables.tableVIIIb(percentABV, temperature);

  double abvToAbw(abv) => OIMLTables.tableIVb(abv);

  /// Calculates the total litres of pure alcohol (LALs) from a given weight, ABV, and temperature
  /// using OIML tables for accurate conversion.
  ///
  /// Parameters:
  /// - weight: The weight of the liquid in kilograms
  /// - abv: The alcohol by volume as a decimal (e.g., 0.40 for 40%)
  /// - temperature: The temperature in Celsius (defaults to 20°C)
  ///
  /// Returns the litres of pure alcohol (LALs)
  double litresOfAlcoholCalculation({
    required double weight,
    required double abv,
    double temperature = 20.0,
  }) {
    final correctedABV = OIMLTables.tableVIIIb(abv, temperature);
    final density = OIMLTables.tableII(abv, temperature) / 1000;
    final volume = weight / density;
    return volume * correctedABV;
  }

  /// Converts specific gravity to degrees Brix (°Bx).
  ///
  /// Degrees Brix represents the sugar content of an aqueous solution,
  /// where one degree Brix equals 1 gram of sucrose in 100 grams of solution.
  ///
  /// Parameters:
  /// - specificGravity: The specific gravity of the solution (ratio to water density)
  ///
  /// Returns the sugar content in degrees Brix (°Bx)
  double densityToBrix(double specificGravity) =>
      Brix.densityToBrix(specificGravity);

  /// Converts degrees Brix to specific gravity.
  ///
  /// Parameters:
  /// - degreesBrix: The sugar content in degrees Brix (°Bx)
  ///
  /// Returns the specific gravity of the solution (ratio to water density)
  double brixToDensity(double degreesBrix) => Brix.brixToDensity(degreesBrix);
}

class _DiluteByWeightResult {
  double targetWeight;
  final double additionalWeight;
  final double totalWeightOfAlcohol;
  final double targetVolume;
  double get acceptableABVHigh =>
      double.parse((targetABV * 1.005).toStringAsFixed(4));
  double get acceptableABVLow =>
      double.parse((targetABV * .998).toStringAsFixed(4));
  final double targetABV;
  final double startingVolume;
  final double correctedStartingABV;

  double get lals => targetVolume * targetABV;

  _DiluteByWeightResult(
      {required this.targetWeight,
      required this.additionalWeight,
      required this.totalWeightOfAlcohol,
      required this.targetVolume,
      required this.targetABV,
      required this.startingVolume,
      required this.correctedStartingABV});

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

class DilutionResult {
  final DateTime date;
  final double startingWeight;
  final double correctedStartingABV;
  final double lals;
  final double additionalWaterLitres;
  final double targetWeightAfterWater;
  final double calculatedABV;
  final double acceptableABVLow;
  final double acceptableABVHigh;
  final List<SugarResult> sugarResults;
  final double expectedBottles;
  final double targetVolume;

  DilutionResult({
    required this.date,
    required this.startingWeight,
    required this.correctedStartingABV,
    required this.lals,
    required this.additionalWaterLitres,
    required this.targetWeightAfterWater,
    required this.calculatedABV,
    required this.acceptableABVLow,
    required this.acceptableABVHigh,
    required this.sugarResults,
    required this.expectedBottles,
    required this.targetVolume,
  });

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln("Date: ${date.day}/${date.month}/${date.year}");
    buffer.writeln("Starting weight ${startingWeight.toStringAsFixed(2)}");
    buffer.writeln("ABV @ 20deg: ${correctedStartingABV.toStringAsFixed(4)}");
    buffer.writeln("LALs: ${lals.toStringAsFixed(2)}");
    buffer.writeln(
        "Additional litres of water: ${additionalWaterLitres.toStringAsFixed(2)}");
    buffer.writeln(
        "Calculated target weight after water: ${targetWeightAfterWater.toStringAsFixed(2)}");
    buffer.writeln("Calculated ABV: ${calculatedABV.toStringAsFixed(4)}");
    buffer.writeln(
        "Measured ABV must be between: $acceptableABVLow and $acceptableABVHigh");

    var runningWeight = targetWeightAfterWater;
    for (var sugar in sugarResults) {
      runningWeight += sugar.weight;
      buffer.writeln(
          'Sugar - ${sugar.name} - Weight: ${sugar.weight.toStringAsFixed(2)}, Target Weight: ${runningWeight.toStringAsFixed(2)}');
    }

    buffer.writeln("\nChecks:");
    buffer.writeln("Expected bottles: ${expectedBottles.toStringAsFixed(1)}");

    return buffer.toString();
  }
}

class SugarResult {
  final String name;
  final double weight;

  SugarResult({required this.name, required this.weight});
}

DilutionResult dilution(
    {required double startingWeight,
    required double startingABV,
    required double startingTemperature,
    List<Sugars> sugars = const <Sugars>[],
    required double targetABV}) {
  var date = DateTime.now();

  final alcocalc = AlcocalcFunctions();
  final result = alcocalc._diluteByWeight(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: startingWeight,
  );

  for (var sugar in sugars) {
    sugar.weight =
        result.targetWeight * sugar.specificGravity * sugar.percentage;
  }

  final equivalentWaterWeightUsed = sugars.fold<double>(
      0.0,
      (previousValue, element) =>
          element.equivalentWaterWeight + previousValue);

  final waterWeight = result.additionalWeight - equivalentWaterWeightUsed;
  final targetWeightAfterWater = startingWeight + waterWeight;

  var weightOfAlcohol = result.totalWeightOfAlcohol;
  var totalWeight = startingWeight + waterWeight;
  var abw = weightOfAlcohol / totalWeight;
  var abvAfterWater = OIMLTables.tableIIIb(abw);

  var acceptableABVHigh =
      double.parse((abvAfterWater * 1.005).toStringAsFixed(4));
  var acceptableABVLow =
      double.parse((abvAfterWater * .998).toStringAsFixed(4));

  final sugarResults = sugars
      .map((sugar) => SugarResult(name: sugar.name, weight: sugar.weight))
      .toList();

  return DilutionResult(
    date: date,
    startingWeight: startingWeight,
    correctedStartingABV: result.correctedStartingABV,
    lals: result.lals,
    additionalWaterLitres: waterWeight,
    targetWeightAfterWater: targetWeightAfterWater,
    calculatedABV: abvAfterWater,
    acceptableABVLow: acceptableABVLow,
    acceptableABVHigh: acceptableABVHigh,
    sugarResults: sugarResults,
    expectedBottles: result.targetVolume / .7,
    targetVolume: result.targetVolume,
  );
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

DilutionResult diluteToVolume({
  required double startingABV,
  required double startingTemperature,
  required List<Sugars> sugars,
  required double targetABV,
  required double targetVolume,
}) {
  // We need to find the starting weight that will give us our desired volume
  // Create a function that returns the difference between our target volume and the actual volume
  double volumeDifference(double testStartingWeight) {
    final result = dilution(
      startingWeight: testStartingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: targetABV,
    );
    return result.targetVolume - targetVolume;
  }

  // Find the starting weight that gives us our target volume
  // We know the starting weight must be positive and less than the target volume
  // (since we're diluting, the starting weight must be less than final volume)
  final startingWeight = findRoot(
    volumeDifference,
    0.0001, // Avoid division by zero by not starting at exactly 0
    targetVolume, // Upper bound - starting weight must be less than final volume
  );

  return dilution(
    startingWeight: startingWeight,
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    sugars: sugars,
    targetABV: targetABV,
  );
}

DilutionResult diluteToBottles({
  required double startingABV,
  required double startingTemperature,
  required List<Sugars> sugars,
  required double targetABV,
  required double targetBottles,
  double bottleSize = 0.7, // Default bottle size in litres
}) {
  final targetVolume = targetBottles * bottleSize;

  final result = diluteToVolume(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    sugars: sugars,
    targetABV: targetABV,
    targetVolume: targetVolume,
  );

  // Create a new result with the correct bottle count based on the provided bottle size
  return DilutionResult(
    date: result.date,
    startingWeight: result.startingWeight,
    correctedStartingABV: result.correctedStartingABV,
    lals: result.lals,
    additionalWaterLitres: result.additionalWaterLitres,
    targetWeightAfterWater: result.targetWeightAfterWater,
    calculatedABV: result.calculatedABV,
    acceptableABVLow: result.acceptableABVLow,
    acceptableABVHigh: result.acceptableABVHigh,
    sugarResults: result.sugarResults,
    expectedBottles: result.targetVolume / bottleSize,
    targetVolume: result.targetVolume,
  );
}

class AlcoholAdditionResult {
  final double requiredAlcoholWeight;
  final double finalWeight;
  final double finalVolume;
  final double lals;

  AlcoholAdditionResult({
    required this.requiredAlcoholWeight,
    required this.finalWeight,
    required this.finalVolume,
    required this.lals,
  });

  @override
  String toString() => """
  Required high-proof alcohol to add: \\${requiredAlcoholWeight.toStringAsFixed(3)} kg
  Final weight after addition: \\${finalWeight.toStringAsFixed(3)} kg
  Final volume: \\${finalVolume.toStringAsFixed(3)} L
  LALs: \\${lals.toStringAsFixed(3)}
  """;
}

AlcoholAdditionResult calculateAlcoholAddition({
  required double currentWeight,
  required double currentABV,
  required double targetABV,
  required double additionABV,
  double temperature = 20.0,
}) {
  // Input validation
  assert(currentWeight > 0, 'Current weight must be positive');
  assert(currentABV >= 0 && currentABV <= 1,
      'Current ABV must be between 0 and 1 (e.g., 0.37 for 37%)');
  assert(targetABV >= 0 && targetABV <= 1,
      'Target ABV must be between 0 and 1 (e.g., 0.37 for 37%)');
  assert(additionABV >= 0 && additionABV <= 1,
      'Addition ABV must be between 0 and 1 (e.g., 0.962 for 96.2%)');
  assert(
      additionABV > targetABV, 'Addition ABV must be higher than target ABV');
  assert(temperature >= -20 && temperature <= 40,
      'Temperature must be between -20°C and 40°C');

  final alcocalc = AlcocalcFunctions();

  // Convert ABVs to temperature-corrected values
  final correctedCurrentABV = alcocalc.correctedABV(currentABV, temperature);
  final correctedAdditionABV = alcocalc.correctedABV(additionABV, temperature);

  // If current ABV equals target ABV, no addition needed
  if (currentABV == targetABV) {
    final density = OIMLTables.tableII(targetABV, temperature) / 1000;
    final volume = currentWeight / density;
    return AlcoholAdditionResult(
      requiredAlcoholWeight: 0.0,
      finalWeight: currentWeight,
      finalVolume: volume,
      lals: 0.0,
    );
  }

  // Get densities for volume calculations
  final currentDensity = OIMLTables.tableII(currentABV, temperature) / 1000;
  final additionDensity = OIMLTables.tableII(additionABV, temperature) / 1000;
  final targetDensity = OIMLTables.tableII(targetABV, temperature) / 1000;

  // Calculate current volume and alcohol content
  final currentVolume = currentWeight / currentDensity;
  final currentAlcoholVolume = currentVolume * currentABV;

  // Calculate target total volume based on target ABV
  // V1 * C1 + V2 * C2 = (V1 + V2) * Ct
  // Where V1 is current volume, C1 is current ABV
  // V2 is addition volume, C2 is addition ABV
  // Ct is target ABV
  final additionVolume =
      (currentVolume * (targetABV - currentABV)) / (additionABV - targetABV);

  // Calculate weights from volumes
  final requiredAlcoholWeight = additionVolume * additionDensity;
  final finalWeight = currentWeight + requiredAlcoholWeight;
  final finalVolume = currentVolume + additionVolume;

  // Calculate LALs for the added alcohol
  final lals = additionVolume * additionABV;

  return AlcoholAdditionResult(
    requiredAlcoholWeight: requiredAlcoholWeight,
    finalWeight: finalWeight,
    finalVolume: finalVolume,
    lals: lals,
  );
}
