import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';

const input = '35440.0000	20.0000	0.875961669';

main() {
  final data = input.split('	');
  late double percentABV;
  if (data[2].contains('%')) {
    percentABV = double.parse(data[2].replaceAll('%', '')) / 100;
  } else {
    percentABV = double.parse(data[2]);
  }
  final temperature = double.parse(data[1]);
  final weight = double.parse(data[0]);
  print('$weight $temperature $percentABV');

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
  
  $correctedABV	$LALs
  """);
}
