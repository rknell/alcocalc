import 'package:alcocalc/functions.dart';

const startingWeight = 1.0;
const startingABV = .854;
const startingTemperature = 20.0;
const targetABV = .4;

main() {
  final alcocalc = AlcocalcFunctions();
  print(alcocalc.diluteByWeight(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: startingWeight,
  ));
}
