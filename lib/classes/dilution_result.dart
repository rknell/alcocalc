import 'package:alcocalc/classes/sugar_result.dart';

/// Represents the result of a dilution calculation for spirits or alcoholic beverages.
///
/// This class stores all the information related to diluting an alcoholic product,
/// including starting parameters, target values, required water additions,
/// sugar additions, and expected production metrics.
class DilutionResult {
  /// The date when the dilution calculation was performed.
  final DateTime date;

  /// The initial weight of the product before dilution in kilograms.
  final double startingWeight;

  /// The ABV corrected to 20°C before dilution as a decimal.
  final double correctedStartingABV;

  /// Liters of Absolute Alcohol (pure alcohol) in the starting product.
  final double lals;

  /// The amount of water in liters that needs to be added for dilution.
  final double additionalWaterLitres;

  /// The expected weight after water addition in kilograms.
  final double targetWeightAfterWater;

  /// The calculated ABV after dilution as a decimal.
  final double calculatedABV;

  /// The lower bound of the acceptable ABV range after dilution.
  ///
  /// Calculated as 99.8% of the calculated ABV.
  double get acceptableABVLow =>
      double.parse((calculatedABV * 0.998).toStringAsFixed(4));

  /// The upper bound of the acceptable ABV range after dilution.
  ///
  /// Calculated as 100.5% of the calculated ABV.
  double get acceptableABVHigh =>
      double.parse((calculatedABV * 1.005).toStringAsFixed(4));

  /// List of sugar additions to be made, with their respective weights.
  final List<SugarResult> sugarResults;

  /// The expected number of bottles that can be filled from the final product.
  final double expectedBottles;

  /// The target volume of the final product in liters.
  final double targetVolume;

  /// The target weight of the final product in kilograms after all additions.
  final double targetFinalWeight;

  /// Creates a new [DilutionResult] with the specified parameters.
  ///
  /// [date]: The date of the calculation.
  /// [startingWeight]: Initial weight of the product in kilograms.
  /// [correctedStartingABV]: ABV corrected to 20°C as a decimal.
  /// [lals]: Liters of Absolute Alcohol in the starting product.
  /// [additionalWaterLitres]: Water to be added in liters.
  /// [targetWeightAfterWater]: Expected weight after water addition.
  /// [calculatedABV]: Calculated ABV after dilution.
  /// [sugarResults]: List of sugar additions to be made.
  /// [expectedBottles]: Expected number of bottles to be filled.
  /// [targetVolume]: Target final volume in liters.
  /// [targetFinalWeight]: Target final weight in kilograms.
  DilutionResult({
    required this.startingWeight,
    required this.correctedStartingABV,
    required this.lals,
    required this.additionalWaterLitres,
    required this.targetWeightAfterWater,
    required this.calculatedABV,
    required this.sugarResults,
    required this.expectedBottles,
    required this.targetVolume,
    required this.targetFinalWeight,
  }) : date = DateTime.now();

  /// Returns a string representation of the dilution calculation results.
  ///
  /// The returned string includes the date, starting parameters, water additions,
  /// calculated values, acceptable ABV range, sugar additions, and expected bottles.
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

    // Use the pre-calculated running weights from the SugarResult objects
    for (var sugar in sugarResults) {
      buffer.writeln(
          'Sugar - ${sugar.name} - Weight: ${sugar.weight.toStringAsFixed(2)}, Target Weight: ${sugar.runningWeight.toStringAsFixed(2)}');
    }

    buffer.writeln("\nChecks:");
    buffer.writeln("Expected bottles: ${expectedBottles.toStringAsFixed(1)}");

    return buffer.toString();
  }
}
