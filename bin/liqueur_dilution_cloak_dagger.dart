import 'package:alcocalc/alcocalc.dart';

const tare = 0;

const double startingABV = 0.3908;
const double startingTemperature = 20;
const double startingWeight = 58.68;

final sugars = <Sugars>[
  // Sugars(name: 'Distillers caramel', specificGravity: 1.3, percentage: .01),
  Sugars(name: 'Sugar', specificGravity: 1.3553, percentage: .02),
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
