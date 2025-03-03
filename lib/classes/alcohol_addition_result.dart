import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

/// Represents the result of an alcohol addition calculation.
///
/// This class contains both the input parameters, intermediate calculation values,
/// and final results of adding high-proof alcohol to an existing volume to achieve
/// a target ABV (Alcohol By Volume).
class AlcoholAdditionResult {
  /// The weight of the original liquid in kilograms.
  final double currentWeight;

  /// The original ABV of the liquid as a decimal (e.g., 0.40 for 40%).
  final double currentABV;

  /// The desired target ABV as a decimal (e.g., 0.45 for 45%).
  final double targetABV;

  /// The ABV of the alcohol being added as a decimal (e.g., 0.95 for 95%).
  final double additionABV;

  /// The temperature in Celsius at which the calculation is performed.
  final double temperature;

  // Intermediate calculation values

  /// ABV corrected for temperature effects.
  final double correctedCurrentABV;

  /// ABV of the addition corrected for temperature effects.
  final double correctedAdditionABV;

  /// The density of the original liquid in kg/L.
  final double currentDensity;

  /// The density of the alcohol being added in kg/L.
  final double additionDensity;

  /// The density of the resulting mixture in kg/L.
  final double targetDensity;

  /// The volume of the original liquid in liters.
  final double currentVolume;

  /// The volume of pure alcohol in the original liquid in liters.
  final double currentAlcoholVolume;

  /// The volume of alcohol to be added in liters.
  final double additionVolume;

  // Final results

  /// The weight of high-proof alcohol that needs to be added in kilograms.
  final double requiredAlcoholWeight;

  /// The total weight after addition in kilograms.
  final double finalWeight;

  /// The total volume after addition in liters.
  final double finalVolume;

  /// Liters of Absolute Alcohol (LALs) added.
  final double lals;

  /// Creates a new [AlcoholAdditionResult] with the specified parameters.
  AlcoholAdditionResult({
    // Input parameters
    required this.currentWeight,
    required this.currentABV,
    required this.targetABV,
    required this.additionABV,
    required this.temperature,

    // Calculation values
    required this.correctedCurrentABV,
    required this.correctedAdditionABV,
    required this.currentDensity,
    required this.additionDensity,
    required this.targetDensity,
    required this.currentVolume,
    required this.currentAlcoholVolume,
    required this.additionVolume,

    // Results
    required this.requiredAlcoholWeight,
    required this.finalWeight,
    required this.finalVolume,
    required this.lals,
  });

  /// Returns a string representation of the calculation results.
  ///
  /// The returned string includes all input parameters, intermediate values,
  /// and final results formatted for readability.
  @override
  String toString() => """
  Input Parameters:
  - Current weight: ${currentWeight.toStringAsFixed(3)} kg
  - Current ABV: ${(currentABV * 100).toStringAsFixed(2)}%
  - Target ABV: ${(targetABV * 100).toStringAsFixed(2)}%
  - Addition ABV: ${(additionABV * 100).toStringAsFixed(2)}%
  - Temperature: ${temperature.toStringAsFixed(1)}°C
  
  Calculation Values:
  - Corrected Current ABV: ${(correctedCurrentABV * 100).toStringAsFixed(4)}%
  - Corrected Addition ABV: ${(correctedAdditionABV * 100).toStringAsFixed(4)}%
  - Current Density: ${currentDensity.toStringAsFixed(5)} kg/L
  - Addition Density: ${additionDensity.toStringAsFixed(5)} kg/L
  - Target Density: ${targetDensity.toStringAsFixed(5)} kg/L
  - Current Volume: ${currentVolume.toStringAsFixed(3)} L
  - Current Alcohol Volume: ${currentAlcoholVolume.toStringAsFixed(3)} L
  - Addition Volume: ${additionVolume.toStringAsFixed(3)} L
  
  Results:
  - Required high-proof alcohol to add: ${requiredAlcoholWeight.toStringAsFixed(3)} kg
  - Final weight after addition: ${finalWeight.toStringAsFixed(3)} kg
  - Final volume: ${finalVolume.toStringAsFixed(3)} L
  - LALs: ${lals.toStringAsFixed(3)}
  """;
}

/// Calculates the amount of high-proof alcohol needed to reach a target ABV.
///
/// This function uses density tables and volumetric calculations to determine
/// how much alcohol of a given strength needs to be added to reach a target ABV.
/// The calculation accounts for temperature effects on density and ABV.
///
/// The formula used is based on the conservation of alcohol:
/// V1 * C1 + V2 * C2 = (V1 + V2) * Ct
/// Where:
/// - V1 is current volume, C1 is current ABV
/// - V2 is addition volume, C2 is addition ABV
/// - Ct is target ABV
///
/// [currentWeight]: Weight of the original liquid in kilograms.
/// [currentABV]: Current ABV of the liquid as a decimal (e.g., 0.40 for 40%).
/// [targetABV]: Desired ABV as a decimal (e.g., 0.45 for 45%).
/// [additionABV]: ABV of the alcohol being added as a decimal (e.g., 0.95 for 95%).
/// [temperature]: Temperature in Celsius at which the calculation is performed (default: 20.0°C).
///
/// Returns an [AlcoholAdditionResult] containing all calculation details.
///
/// Throws an [AssertionError] if input parameters are invalid.
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

  // Convert ABVs to temperature-corrected values
  final correctedCurrentABV = Alcocalc.correctedABV(currentABV, temperature);
  final correctedAdditionABV = Alcocalc.correctedABV(additionABV, temperature);

  // If current ABV equals target ABV, no addition needed
  if (currentABV == targetABV) {
    final density = OIMLTables.tableII(targetABV, temperature) / 1000;
    final volume = currentWeight / density;
    return AlcoholAdditionResult(
      // Input parameters
      currentWeight: currentWeight,
      currentABV: currentABV,
      targetABV: targetABV,
      additionABV: additionABV,
      temperature: temperature,

      // Calculation values
      correctedCurrentABV: correctedCurrentABV,
      correctedAdditionABV: correctedAdditionABV,
      currentDensity: density,
      additionDensity: 0.0, // Not used in this case
      targetDensity: density,
      currentVolume: volume,
      currentAlcoholVolume: volume * currentABV,
      additionVolume: 0.0,

      // Results
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
    // Input parameters
    currentWeight: currentWeight,
    currentABV: currentABV,
    targetABV: targetABV,
    additionABV: additionABV,
    temperature: temperature,

    // Calculation values
    correctedCurrentABV: correctedCurrentABV,
    correctedAdditionABV: correctedAdditionABV,
    currentDensity: currentDensity,
    additionDensity: additionDensity,
    targetDensity: targetDensity,
    currentVolume: currentVolume,
    currentAlcoholVolume: currentAlcoholVolume,
    additionVolume: additionVolume,

    // Results
    requiredAlcoholWeight: requiredAlcoholWeight,
    finalWeight: finalWeight,
    finalVolume: finalVolume,
    lals: lals,
  );
}
