import 'package:alcocalc/tables/oiml.dart';

const abv = 0.744;
const weight = 39.44;

//9.94

void main() {
  final density = OIMLTables.tableII(abv, 20);
  final volume = weight / (density / 1000);
  print(volume);
  print("LALs: ${volume * abv}");

  print("Bottles: ${(volume / 700).floor()}");
  print("Bottles @ 40%: ${volume * (abv / .4) / 700}");
}
