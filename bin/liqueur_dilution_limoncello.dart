import 'package:alcocalc/functions.dart';

const double startingABV = 0.962;
const double startingTemperature = 20;
const double startingWeight = .5236;

final sugars = <Sugars>[
  Sugars(name: '2to1 Simple Sugar', specificGravity: 1.61182, percentage: .29)
];

const double targetABV = .3;

void main() {
  final alcocalc = AlcocalcFunctions();
  final result = alcocalc.diluteByWeight(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: startingWeight,
  );
  print(result);

  final weightOfAlcohol =
      startingWeight * AlcocalcFunctions().abvToAbw(startingABV);
  final targetWeightOfWater = result.targetWeight - weightOfAlcohol;

  final totalSugarPercentage = sugars.fold<double>(
      0.0, (previousValue, element) => previousValue + element.percentage);

  double totalSugarWeight = 0;
  double equivalentWaterWeightUsed = 0;
  for (var sugar in sugars) {
    final sugarWeight =
        result.targetWeight * sugar.specificGravity * sugar.percentage;
    equivalentWaterWeightUsed += result.targetWeight * sugar.percentage;
    totalSugarWeight += sugarWeight;
    print(
        "${sugar.name} - Weight: ${sugarWeight}, Target Weight: ${startingWeight + totalSugarWeight}");
  }

  final waterWeight = result.additionalWeight - equivalentWaterWeightUsed;

  print(
      'Water - Weight: ${waterWeight}, Target Weight: ${startingWeight + totalSugarWeight + waterWeight}');
}

// 13.6

class Sugars {
  final String name;
  final double specificGravity;
  final double percentage;

  Sugars(
      {required this.name,
      required this.specificGravity,
      required this.percentage})
      : assert(percentage < 1, "Percentage much be a decimal");
}
