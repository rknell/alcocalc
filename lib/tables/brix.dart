import 'dart:math' as math;

import 'package:alcocalc/helpers.dart';

/// Coefficients for the polynomial equation used to convert density to Brix
const c1 = 182.4601;
const c2 = 775.6821;
const c3 = 1262.7794;
const c4 = 669.5622;

/// Utility class for converting between density and Brix measurements.
///
/// Degrees Brix (symbol °Bx) represents the sugar content of an aqueous solution,
/// where one degree Brix equals 1 gram of sucrose in 100 grams of solution.
/// It represents the strength of the solution as percentage by mass (sugar by weight).
class Brix {
  /// Converts specific gravity to degrees Brix.
  ///
  /// Parameters:
  /// - [specificGravity]: The specific gravity of the solution (ratio to water density)
  ///
  /// Returns the sugar content in degrees Brix (°Bx)
  static double densityToBrix(double specificGravity) =>
      (c1 * math.pow(specificGravity, 3)) -
      (c2 * math.pow(specificGravity, 2)) +
      (specificGravity * c3) -
      c4;

  /// Converts degrees Brix to specific gravity.
  ///
  /// Parameters:
  /// - [degreesBrix]: The sugar content in degrees Brix (°Bx)
  ///
  /// Returns the specific gravity of the solution (ratio to water density)
  static double brixToDensity(double degreesBrix) =>
      findRoot((x) => densityToBrix(x) - degreesBrix, -2, 2);
}
