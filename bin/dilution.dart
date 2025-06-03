import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

const double startingABV = 0.6869;
const double startingTemperature = 20;
const double startingWeight = 1.91;
const targetABV = .37;

void main() {
  final startingDensity = OIMLTables.tableII(startingABV, startingTemperature);
  final startingVolume = startingWeight / (startingDensity / 1000);
  print('Starting Volume $startingVolume');
  print('LALs: ${(startingVolume * startingABV).toStringAsFixed(2)}');

  final result = Alcocalc.dilution(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: startingWeight,
  );

  print(result);
  print('Additional Volume ${result.targetVolume - startingVolume}');
}
