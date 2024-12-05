import 'package:alcocalc/functions.dart';

const tare = 0;

const double startingABV = 0.962;
const double startingTemperature = 20;
const double startingWeight = 4;

final sugars = <Sugars>[
  Sugars(
      name:
          'Sugar - Sunsweet 70 Brix',
      specificGravity: 1.3636,
      percentage: .1879),
  Sugars(
      name:
      'Lemon Juice',
      specificGravity: 1.04,
      percentage: .246),
];

void main() {
  liqueurDilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .12);
}