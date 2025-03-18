import 'package:alcocalc/alcocalc.dart';

const double startingABV = 0.4877;
const double startingTemperature = 20;
const double startingWeight = 58.84;

final sugars = <Sugars>[
  Sugars(name: 'Sugar Syrup', specificGravity: 1.51257, percentage: .01),
];

void main() {
  final result = Alcocalc.dilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .37);

  print('Liqueur dilution result: $result');
}
