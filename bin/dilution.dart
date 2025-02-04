import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

const double startingABV = 0.962;
const double startingTemperature = 20;
const double startingWeight = 24.72;
const targetABV = .37;

main() {
  final alcocalc = AlcocalcFunctions();
  final startingDensity = OIMLTables.tableII(startingABV, startingTemperature);
  final startingVolume = startingWeight / (startingDensity / 1000);
  print('Starting Volume $startingVolume');
  print('LALs: ${(startingVolume * startingABV).toStringAsFixed(2)}');

  final result = dilution(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: startingWeight,
  );

  print(result);
  print('Additional Volume ${result.targetVolume - startingVolume}');
}
