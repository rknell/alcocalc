import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

const double startingABV = 0.962;
const double startingTemperature = 20;
const double startingWeight = 27;
const targetABV = .65;

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
