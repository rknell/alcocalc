import 'package:alcocalc/tables/oiml.dart';

const ABV = 0.91;
const weight = 9.54;

//9.94

main() {
  final density = OIMLTables.tableII(ABV, 20);
  final volume = weight / (density / 1000);
  print(volume);

  print("Bottles: ${(volume / 700).floor()}");
  print("Bottles @ 40%: ${(volume * (ABV / .4) / 700)}");
}
