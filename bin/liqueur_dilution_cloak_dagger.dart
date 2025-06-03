import 'package:alcocalc/alcocalc.dart';

const tare = 0;

const double startingABV = 0.6869;
const double startingTemperature = 20;
const double startingWeight = 1.91;

final sugars = <Sugars>[
  Sugars(name: 'Sunsweet', specificGravity: 1.3553, percentage: .02),
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
