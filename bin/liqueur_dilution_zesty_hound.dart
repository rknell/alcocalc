import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/brix.dart';

const tare = 0;

const double startingABV = 0.7416;
const double startingTemperature = 25.7;
const double startingWeight = 23.94;

final sugars = <Sugars>[
  Sugars(name: 'Sugar Syrup', specificGravity: Brix.brixToDensity(70), percentage: .0064),
];

void main() {
  liqueurDilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .37);
}