import 'package:alcocalc/functions.dart';

const tare = 4.6203;

const double startingABV = 0.532;
const double startingTemperature = 17.6;
const double startingWeight = 56.7;

final sugars = <Sugars>[
  Sugars(name: 'Distillers caramel', specificGravity: 1.6, percentage: .01),
  Sugars(name: 'Sugar', specificGravity: 1.4, percentage: .012),
];

const double targetABV = .4;

void main() {
  final result = dilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: targetABV);

  print('Liqueur dilution result: $result');
}
