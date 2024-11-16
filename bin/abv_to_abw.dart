import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

main() {
  final density = OIMLTables.tableII(.962, 20);
  print(density);

  print(AlcocalcFunctions().abvToAbw(.40));
}
