import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

//9560.0	25.2	65.00%

const double weight = 9560;
const double temperature = 20;
const percentABV = 0.30;

void main() {
  final correctedABV = Alcocalc.correctedABV(percentABV, temperature);
  final abw = Alcocalc.abvToAbw(correctedABV);
  final density = OIMLTables.tableI(abw, 20) / 1000;
  final volume = weight / density;
  final weightOfAlcohol = weight * abw;
  final lals = (weightOfAlcohol / 1000) / .78924;
  print("""
  ABV = $correctedABV
  LALs = $lals
  Volume = $volume
  Bottles = ${(volume / 1000) / .4 / .7}
  
  $correctedABV	$lals
  """);
}
