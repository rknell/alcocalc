import 'dart:math' as math;

import 'package:alcocalc/helpers.dart';

const C1 = 182.4601;
const C2 = 775.6821;
const C3 = 1262.7794;
const C4 = 669.5622;

class Brix {
  // Degrees Brix (symbol °Bx) is the sugar content of an aqueous solution. One
  // degree Brix is 1 gram of sucrose in 100 grams of solution and represents
  // the strength of the solution as percentage by mass.
  // ie. Sugar by Weight
  static double densityToBrix(double sg) =>
      (C1 * math.pow(sg, 3)) - (C2 * math.pow(sg, 2)) + (sg * C3) - C4;

  static double brixToDensity(double brix) =>
      findRoot((x) => densityToBrix(x) - brix, -10, 10);
}
