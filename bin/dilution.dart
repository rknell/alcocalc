import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

const double startingABV = 0.744;
const double startingTemperature = 20;
const double startingWeight = 44.92-5.48;
const targetABV = .37;

main() {
  final alcocalc = AlcocalcFunctions();
  final startingDensity = OIMLTables.tableII(startingABV, startingTemperature);
  final startingVolume = (startingWeight) / (startingDensity / 1000);
  print('Starting Volume $startingVolume');
  print('LALs: ${(startingVolume * startingABV).toStringAsFixed(2)}');

  final result = alcocalc.diluteByWeight(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: (startingWeight),
  );

  print(result);
  print('Additional Volume ${result.targetVolume - startingVolume}');
}
