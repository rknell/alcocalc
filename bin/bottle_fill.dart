import 'package:alcocalc/tables/oiml.dart';

const double ABV = .401;
const double volume = .7;

main() {
  final density = OIMLTables.tableII(ABV, 20);
  final targetWeight = (density / 1000) * volume;
  print(targetWeight);
}
