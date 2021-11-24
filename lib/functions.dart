import 'tables/oiml.dart';

class AlcocalcFunctions {
  diluteByWeight({
    required double startingABV,
    required double startingTemperature,
    required double targetABV,
    required double startingWeight,
  }) {
    final correctedStartingABV =
        OIMLTables.tableVIIIb(startingABV, startingTemperature);
    final startingABW = OIMLTables.tableIVb(correctedStartingABV);
    final targetABW = OIMLTables.tableIVb(targetABV);

    final multiplier = startingABW / targetABW;

    final targetWeight = startingWeight * multiplier;
    final additionalWeight = targetWeight - startingWeight;

    return DilutionResult(
      targetWeight: targetWeight,
      additionalWeight: additionalWeight,
    );
  }
}

class DilutionResult {
  final double targetWeight;
  final double additionalWeight;

  DilutionResult({required this.targetWeight, required this.additionalWeight});

  @override
  String toString() => """
  Target weight: ${targetWeight}
  Additional weight: ${additionalWeight}
  """;
}
