import 'package:alcocalc/functions.dart';

void main(List<String> args) {
  var result = diluteToBottles(
      startingABV: 0.962,
      startingTemperature: 20,
      sugars: [],
      targetABV: 0.65,
      targetBottles: 110);

  print(result);
}
