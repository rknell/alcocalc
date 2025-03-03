import 'package:alcocalc/functions.dart';

void main() {
  var result = Alcocalc.calculateAlcoholAddition(
      currentWeight: 63.88,
      currentABV: .3626,
      targetABV: .37,
      additionABV: .962);

  print(result);
}
