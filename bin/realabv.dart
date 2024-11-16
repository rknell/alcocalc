import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

//9560.0	25.2	65.00%

const double weight = 9560;
const double temperature = 20;
const percentABV = 0.30;

main() {
  final alcocalc = AlcocalcFunctions();
  final correctedABV = alcocalc.correctedABV(percentABV, temperature);
  final abw = alcocalc.abvToAbw(correctedABV);
  final density = OIMLTables.tableI(abw, 20) / 1000;
  final volume = weight / density;
  final weightOfAlcohol = weight * abw;
  final LALs = (weightOfAlcohol / 1000) / .78924;
  print("""
  ABV = $correctedABV
  LALs = $LALs
  Volume = $volume
  Bottles = ${(volume / 1000) / .4 / .7}
  
  $correctedABV	$LALs
  """);
}
