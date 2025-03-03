import 'package:alcocalc/alcocalc.dart';

const tare = 0;

const double startingABV = 0.8066;
const double startingTemperature = 20;
const double startingWeight = 33.62;

final sugars = <Sugars>[
  Sugars(
      name: 'Sugar Syrup (Sunsweet)',
      specificGravity: Brix.brixToDensity(70),
      percentage: .04),
];

void main() {
  final result = Alcocalc.dilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .4);

  print(result);
}
