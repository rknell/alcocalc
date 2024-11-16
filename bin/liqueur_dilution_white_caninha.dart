import 'package:alcocalc/functions.dart';

const tare = 0;

const double startingABV = 0.74;
const double startingTemperature = 21.9;
const double startingWeight = 35;

final sugars = <Sugars>[
  Sugars(
      name:
          'Sugar Syrup (1.75 sugar to water by weight / 63.3% sugar by weight, top up with water)',
      specificGravity: 1.51257,
      percentage: .02),
];

//54.3 > 55.8

const double targetABV = .4;

void main() {
  final alcocalc = AlcocalcFunctions();
  final result = alcocalc.diluteByWeight(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: targetABV,
    startingWeight: startingWeight - tare,
  );
  print(result);

  // final weightOfAlcohol =
  //     (startingWeight-tare) * AlcocalcFunctions().abvToAbw(startingABV);
  // final targetWeightOfWater = result.targetWeight - weightOfAlcohol;
  //
  // final totalSugarPercentage = sugars.fold<double>(
  //     0.0, (previousValue, element) => previousValue + element.percentage);

  // double totalSugarWeight = 0;
  // double equivalentWaterWeightUsed = 0;
  for (var sugar in sugars) {
    sugar.weight =
        result.targetWeight * sugar.specificGravity * sugar.percentage;
    // equivalentWaterWeightUsed += result.targetWeight * sugar.percentage;
    // totalSugarWeight += sugarWeight;
    // print(
    //     "${sugar.name} - Weight: ${sugarWeight}, Target Weight: ${startingWeight + totalSugarWeight}");
  }

  // final totalSugarWeight = sugars.fold<double>(
  //     0.0, (previousValue, element) => element.weight + previousValue);
  final equivalentWaterWeightUsed = sugars.fold<double>(
      0.0,
      (previousValue, element) =>
          element.equivalentWaterWeight + previousValue);

  final waterWeight = result.additionalWeight - equivalentWaterWeightUsed;

  print(
      'Water - Weight: ${waterWeight}, Target Weight: ${startingWeight + waterWeight}');

  var runningSugarWeight = 0.0;
  for (var sugar in sugars) {
    runningSugarWeight += sugar.weight;
    print(
        'Sugar - ${sugar.name} - Weight: ${sugar.weight}, Target Weight: ${startingWeight + waterWeight + runningSugarWeight}');
  }
}

// 13.6

class Sugars {
  final String name;
  final double specificGravity;
  final double percentage;
  double weight = 0;
  double get equivalentWaterWeight => weight / specificGravity;

  Sugars(
      {required this.name,
      required this.specificGravity,
      required this.percentage})
      : assert(percentage < 1, "Percentage much be a decimal");
}
