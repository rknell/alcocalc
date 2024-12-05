import 'package:alcocalc/functions.dart';

const tare = 0;

const double startingABV = 0.74;
const double startingTemperature = 21.9;
const double startingWeight = 35;

final sugars = <Sugars>[
  Sugars(
      name:
          'Sugar Syrup (1.75 sugar to water by weight / 63.3% sugar by weight, top up with water)',
      specificGravity: 1.51257,
      percentage: .02),
];

//54.3 > 55.8

const double targetABV = .4;

void main() {
  liqueurDilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: targetABV);
}