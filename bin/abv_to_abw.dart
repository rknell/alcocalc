import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

void main() {
  final density = OIMLTables.tableII(.962, 20);
  print(density);

  print(Alcocalc.abvToAbw(.40));
}
