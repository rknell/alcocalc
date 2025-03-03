import 'package:alcocalc/tables/oiml.dart';

const bottles = 30;

void main() {
  final litres = 30 * .7;
  const multiplier = .4;
  final lals = litres * multiplier;
  print('LALs $lals');
  final litresOfSpiritNeutral = litres * (multiplier / .96);
  print('Spirit Neutral $litresOfSpiritNeutral');
  final weightOfSpiritNeutral =
      (OIMLTables.tableII(.96, 20) * litresOfSpiritNeutral) / 1000;
  print('Weight Spirit Neutral $weightOfSpiritNeutral');
}
