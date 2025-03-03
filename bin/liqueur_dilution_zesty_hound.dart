import 'package:alcocalc/alcocalc.dart';

const tare = 0;

const double startingABV = 0.7416;
const double startingTemperature = 25.7;
const double startingWeight = 23.94;

final sugars = <Sugars>[
  Sugars(
      name: 'Sugar Syrup',
      specificGravity: Brix.brixToDensity(70),
      percentage: .0064),
];

void main() {
  final result = Alcocalc.dilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .37);

  print(result);
}
