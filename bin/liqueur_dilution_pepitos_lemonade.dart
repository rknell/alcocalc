import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/brix.dart';

const tare = 0;

const double startingABV = 0.962;
const double startingTemperature = 20;
const double startingWeight = 4.06;

final sugars = <Sugars>[
  Sugars(
      name: 'Sugar - Sunsweet 70 Brix',
      specificGravity: Brix.brixToDensity(70),
      percentage: .1879),
  Sugars(name: 'Lemon Juice', specificGravity: 1.04, percentage: .246),
];

void main() {
  final result = dilution(
      startingWeight: startingWeight,
      startingABV: startingABV,
      startingTemperature: startingTemperature,
      sugars: sugars,
      targetABV: .12);

  print(result);
}
