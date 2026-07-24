import 'package:alcocalc/classes/dilution_result.dart';
import 'package:test/test.dart';

void main() {
  test('records the calculation instant in UTC', () {
    final result = DilutionResult(
      startingWeight: 100,
      correctedStartingABV: 0.4,
      lals: 40,
      additionalWaterLitres: 10,
      targetWeightAfterWater: 110,
      calculatedABV: 0.36,
      sugarResults: const [],
      expectedBottles: 150,
      targetVolume: 105,
      targetFinalWeight: 110,
    );

    expect(result.date.isUtc, isTrue);
  });
}
