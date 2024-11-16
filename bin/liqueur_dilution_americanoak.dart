import 'package:alcocalc/functions.dart';

const double startingWeight = 41.98;
const startingABV = 0.6777;
const double startingTemperature = 20;

final sugars = <Sugars>[
  Sugars(name: 'Honey', specificGravity: 1.43, percentage: .017), // https://www.foodstandards.gov.au/business/labelling/nutrition-panel-calculator/specific-gravities
  Sugars(name: 'Sugar Syrup', specificGravity: 1.3636, percentage: .025), //target 5.17
];

void main() {
  final alcocalc = AlcocalcFunctions();
  final result = alcocalc.diluteByWeight(
    startingABV: startingABV,
    startingTemperature: startingTemperature,
    targetABV: .37,
    startingWeight: startingWeight,
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
