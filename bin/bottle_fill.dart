import 'package:alcocalc/tables/oiml.dart';

const double abv = .401;
const double volume = .7;

void main() {
  final density = OIMLTables.tableII(abv, 20);
  final targetWeight = (density / 1000) * volume;
  print(targetWeight);
}
