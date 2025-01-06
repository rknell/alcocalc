import 'package:alcocalc/functions.dart';

const double startingWeight = 41.04;
const startingABV = 0.7699;
const double startingTemperature = 20;

final sugars = <Sugars>[
  Sugars(
      name: 'Honey',
      specificGravity: 1.43,
      percentage:
          .017), // https://www.foodstandards.gov.au/business/labelling/nutrition-panel-calculator/specific-gravities
  Sugars(
      name: 'Sugar Syrup',
      specificGravity: 1.3636,
      percentage: .025), //target 5.17
];

void main() {
  liqueurDilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .37);
}
