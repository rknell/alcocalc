import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

const double startingWeight = 26.14;
const startingABV = 0.962;
const double startingTemperature = 20;
const targetABV = .37;

//4.087 starting weight
//70% abv
// sugar @ 1.6 5.383
// total sugar = 1.26kg
// Diluted goal weight no sugar = 7.56
// Total sugar as percentage = 1.26/7.56 = 16.66%

//4.6
//3.8695 Vodka > 30%

//78.30 first prediction
//78.23 final prediction

main() {
  final alcocalc = AlcocalcFunctions();
  final startingDensity = OIMLTables.tableII(startingABV, startingTemperature);
  final startingVolume = (startingWeight) / (startingDensity / 998.2);
  print('Starting Volume $startingVolume');

  final result = alcocalc.diluteByWeight(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: (startingWeight),
  );

  print(result);
  print('Additional Volume ${result.targetVolume - startingVolume}');
}
