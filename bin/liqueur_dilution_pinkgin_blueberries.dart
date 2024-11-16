import 'package:alcocalc/functions.dart';

const tare = 4.443;

const double startingABV = 0.505;
const double startingTemperature = 20;
final double startingWeight = 61.08 - tare;

final sugars = <Sugars>[
  Sugars(name: 'Granulated Sugar', specificGravity: 1.59, percentage: .105),
];

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

  for (var sugar in sugars) {
    sugar.weight =
        result.targetWeight * sugar.specificGravity * sugar.percentage;
  }

  final equivalentWaterWeightUsed = sugars.fold<double>(
      0.0,
      (previousValue, element) =>
          element.equivalentWaterWeight + previousValue);

  final waterWeight = result.additionalWeight - equivalentWaterWeightUsed;

  print(
      'Water - Weight: ${waterWeight}, Target Weight: ${startingWeight + waterWeight + tare}');

  var runningSugarWeight = 0.0;
  for (var sugar in sugars) {
    runningSugarWeight += sugar.weight;
    print(
        'Sugar - ${sugar.name} - Weight: ${sugar.weight}, Target Weight: ${startingWeight + waterWeight + runningSugarWeight + tare}');
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
