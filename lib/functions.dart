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
    final multiplier = startingABW / targetABW;

    final targetWeight = startingWeight * multiplier;
    final additionalWeight = targetWeight - startingWeight;

    final targetDensity = OIMLTables.tableII(targetABV, 20) / 1000;

    final targetVolume = targetWeight / targetDensity;

    print('Corrected starting abv: $correctedStartingABV');

    return DilutionResult(
        targetWeight: targetWeight,
        additionalWeight: additionalWeight,
        totalWeightOfAlcohol: totalWeightOfAlcohol,
        targetVolume: targetVolume);
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

  DilutionResult(
      {required this.targetWeight,
      required this.additionalWeight,
      required this.totalWeightOfAlcohol,
      required this.targetVolume});

  @override
  String toString() => """
  Target weight: ${targetWeight}
  Additional weight: ${additionalWeight}
  Total weight of alcohol: ${totalWeightOfAlcohol}
  Total Target Volume: $targetVolume
  Total Target Bottles: ${targetVolume / .7}
  """;
}
