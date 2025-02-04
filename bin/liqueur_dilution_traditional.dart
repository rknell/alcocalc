import 'package:alcocalc/functions.dart';

const double startingABV = 0.6752;
const double startingTemperature = 20;
const double startingWeight = 41.06;

final sugars = <Sugars>[
  Sugars(name: 'Sugar Syrup', specificGravity: 1.51257, percentage: .01),
];

void main() {
  final result = dilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .37);

  print('Liqueur dilution result: $result');
}
