import 'package:alcocalc/functions.dart';

const tare = 0;

const double startingABV = 0.6276;
const double startingTemperature = 20;
const double startingWeight = 25.62;

final sugars = <Sugars>[
  // Sugars(name: 'Distillers caramel', specificGravity: 1.3, percentage: .01),
  Sugars(name: 'Sugar', specificGravity: 1.3553, percentage: .02),
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
