import 'dart:math';

import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

//9560.0	25.2	65.00%

void main() {
  final charge = (Random().nextDouble() * 7) + 73;

  final recoveryABV = (Random().nextDouble() * .10) + .82;
  final recoveryPercent = (Random().nextDouble() * .05) + .89;
  final recoveryLALs = recoveryPercent * charge;
  final density = Alcocalc.abvToAbw(recoveryABV);
  final recoveryWeight = recoveryLALs * density;
  final recoveryTemp = (Random().nextDouble() * 6) + 25;
  final uncorrectedABV = findRoot((x) {
    final result = Alcocalc.correctedABV(x, recoveryTemp) - recoveryABV;
    return result;
  }, 0, 1, isInverse: false);

  print("""
  2/9/22	2			NGS			$charge	${(recoveryWeight * 1000).toStringAsFixed(1)}	${recoveryTemp.toStringAsFixed(1)}	${(uncorrectedABV * 100).toStringAsFixed(0)}%	$recoveryABV	$recoveryLALs
  """);
}
