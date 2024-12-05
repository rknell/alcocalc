import 'package:alcocalc/functions.dart';

const tare = 0;

const double startingABV = 0.57;
const double startingTemperature = 25.7;
const double startingWeight = 58.08;

final sugars = <Sugars>[
  Sugars(name: 'Sugar Syrup', specificGravity: 1.51257, percentage: .0064),
];

void main() {
  liqueurDilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .37);
}