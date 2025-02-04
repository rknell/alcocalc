import 'package:alcocalc/functions.dart';

const double startingABV = 0.4221;
const double startingTemperature = 20;
const double startingWeight = 47.14;

final sugars = <Sugars>[
  Sugars(name: 'Sugar Syrup', specificGravity: 1.3553, percentage: .12),
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
