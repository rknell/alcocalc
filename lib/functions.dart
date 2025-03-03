import 'package:alcocalc/alcocalc.dart';

class DiluteByWeightResult {
  final double startingABW;
  final double startingABV;
  final double startingTemperature;
  final double targetABV;
  final double startingWeight;
  final double totalWeightOfAlcohol;
  final double targetABW;
  final double startingVolume;
  final double targetWeight;
  final double additionalWeight;
  final double targetDensity;
  final double targetVolume;
  final double correctedStartingABV;

  DiluteByWeightResult(
      {required this.startingABW,
      required this.startingABV,
      required this.startingTemperature,
      required this.targetABV,
      required this.startingWeight,
      required this.totalWeightOfAlcohol,
      required this.targetABW,
      required this.startingVolume,
      required this.targetWeight,
      required this.additionalWeight,
      required this.targetDensity,
      required this.targetVolume,
      required this.correctedStartingABV});
}

class Alcocalc {
  static DiluteByWeightResult _diluteByWeight({
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

    return DiluteByWeightResult(
        startingABW: startingABW,
        startingABV: startingABV,
        startingTemperature: startingTemperature,
        targetABV: targetABV,
        startingWeight: startingWeight,
        totalWeightOfAlcohol: totalWeightOfAlcohol,
        targetABW: targetABW,
        startingVolume: startingVolume,
        targetWeight: targetWeight,
        additionalWeight: additionalWeight,
        targetDensity: targetDensity,
        correctedStartingABV: correctedStartingABV,
        targetVolume: targetVolume);
  }

  static double correctedABV(double percentABV, double temperature) =>
      OIMLTables.tableVIIIb(percentABV, temperature);

  static double abvToAbw(abv) => OIMLTables.tableIVb(abv);

  /// Calculates the total litres of pure alcohol (LALs) from a given weight, ABV, and temperature
  /// using OIML tables for accurate conversion.
  ///
  /// Parameters:
  /// - weight: The weight of the liquid in kilograms
  /// - abv: The alcohol by volume as a decimal (e.g., 0.40 for 40%)
  /// - temperature: The temperature in Celsius (defaults to 20°C)
  ///
  /// Returns the litres of pure alcohol (LALs)
  static double litresOfAlcoholCalculation({
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
  static double densityToBrix(double specificGravity) =>
      Brix.densityToBrix(specificGravity);

  /// Converts degrees Brix to specific gravity.
  ///
  /// Parameters:
  /// - degreesBrix: The sugar content in degrees Brix (°Bx)
  ///
  /// Returns the specific gravity of the solution (ratio to water density)
  static double brixToDensity(double degreesBrix) =>
      Brix.brixToDensity(degreesBrix);

  static DilutionResult dilution(
      {required double startingWeight,
      required double startingABV,
      required double startingTemperature,
      List<Sugars> sugars = const <Sugars>[],
      required double targetABV,
      double bottleSize = 0.7}) {
    final result = Alcocalc._diluteByWeight(
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

    var runningWeight = totalWeight;

    final sugarResults = sugars.map((sugar) {
      runningWeight += sugar.weight;
      return SugarResult(
          name: sugar.name, weight: sugar.weight, runningWeight: runningWeight);
    }).toList();

    return DilutionResult(
        startingWeight: startingWeight,
        correctedStartingABV: result.correctedStartingABV,
        lals: result.targetVolume * result.targetABV,
        additionalWaterLitres: waterWeight,
        targetWeightAfterWater: targetWeightAfterWater,
        calculatedABV: abvAfterWater,
        sugarResults: sugarResults,
        expectedBottles: result.targetVolume / bottleSize,
        targetVolume: result.targetVolume,
        targetFinalWeight: runningWeight);
  }

  static DilutionResult diluteToVolume({
    required double startingABV,
    required double startingTemperature,
    required List<Sugars> sugars,
    required double targetABV,
    required double targetVolume,
    double bottleSize = 0.7,
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
        bottleSize: bottleSize);
  }

  static DilutionResult diluteToBottles({
    required double startingABV,
    required double startingTemperature,
    required List<Sugars> sugars,
    required double targetABV,
    required double targetBottles,
    double bottleSize = 0.7, // Default bottle size in litres
  }) {
    final targetVolume = targetBottles * bottleSize;

    return diluteToVolume(
        startingABV: startingABV,
        startingTemperature: startingTemperature,
        sugars: sugars,
        targetABV: targetABV,
        targetVolume: targetVolume,
        bottleSize: bottleSize);
  }

  static AlcoholAdditionResult calculateAlcoholAddition({
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

    // Convert ABVs to temperature-corrected values
    final correctedCurrentABV = Alcocalc.correctedABV(currentABV, temperature);
    final correctedAdditionABV =
        Alcocalc.correctedABV(additionABV, temperature);

    // If current ABV equals target ABV, no addition needed
    if (currentABV == targetABV) {
      final density = OIMLTables.tableII(targetABV, temperature) / 1000;
      final volume = currentWeight / density;
      return AlcoholAdditionResult(
          requiredAlcoholWeight: 0.0,
          finalWeight: currentWeight,
          finalVolume: volume,
          lals: 0.0,
          currentWeight: currentWeight,
          currentABV: currentABV,
          targetABV: targetABV,
          additionABV: additionABV,
          temperature: temperature,
          correctedCurrentABV: correctedCurrentABV,
          correctedAdditionABV: correctedAdditionABV,
          currentDensity: density,
          additionDensity: density,
          targetDensity: density,
          currentVolume: volume,
          additionVolume: volume,
          currentAlcoholVolume: volume * currentABV);
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
      currentWeight: currentWeight,
      currentABV: currentABV,
      targetABV: targetABV,
      additionABV: additionABV,
      temperature: temperature,
      correctedCurrentABV: correctedCurrentABV,
      correctedAdditionABV: correctedAdditionABV,
      currentDensity: currentDensity,
      additionDensity: additionDensity,
      targetDensity: targetDensity,
      currentVolume: currentVolume,
      currentAlcoholVolume: currentAlcoholVolume,
      additionVolume: additionVolume,
    );
  }
}
