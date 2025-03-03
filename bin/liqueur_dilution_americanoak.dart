import 'package:alcocalc/alcocalc.dart';

const double startingABV = 0.6497;
const double startingTemperature = 20;
const double startingWeight = 43.10;

void main() {
  final result = Alcocalc.dilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: 20,
      sugars: [
        Sugars(
            name: 'Honey',
            specificGravity: 1.43,
            percentage:
                .017), // https://www.foodstandards.gov.au/business/labelling/nutrition-panel-calculator/specific-gravities
        Sugars(
            name: 'Sugar Syrup',
            specificGravity: 1.3636,
            percentage: .025), //target 5.17
      ],
      targetABV: .37);

  print(result);
}
