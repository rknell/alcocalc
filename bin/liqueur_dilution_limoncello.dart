import 'package:alcocalc/functions.dart';

const double startingABV = 0.962;
const double startingTemperature = 20;
const double startingWeight = .5236;

final sugars = <Sugars>[
  Sugars(name: '2to1 Simple Sugar', specificGravity: 1.61182, percentage: .29)
];

void main() {
  liqueurDilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .3);
}