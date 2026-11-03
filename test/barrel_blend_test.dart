import 'package:alcocalc/alcocalc.dart';
import 'package:test/test.dart';

void main() {
  const additions = [
    BlendAddition(litres: 20, abv: .85),
    BlendAddition(litres: 12, abv: .962),
  ];
  test('80 L example conserves alcohol and mass including contraction', () {
    final result = BarrelBlend.calculate(
        additions: additions, targetUnit: BarrelTargetUnit.litres);
    expect(result.spiritLitres, closeTo(29.32, 1e-8));
    expect(result.finalLitres, closeTo(80, 1e-8));
    expect(result.finalLals, closeTo(52, 1e-8));
    final inputKg = additions.fold(
        0.0, (sum, a) => sum + a.litres * OIMLTables.tableII(a.abv, 20) / 1000);
    expect(inputKg + result.spiritKg + result.waterKg,
        closeTo(result.finalKg, 1e-8));
    expect(result.waterLitres, greaterThan(18.68));
  });
  test('80 kg default and equivalent litre target agree', () {
    final kg = BarrelBlend.calculate(additions: additions);
    final litres = BarrelBlend.calculate(
        additions: additions,
        targetAmount: kg.finalLitres,
        targetUnit: BarrelTargetUnit.litres);
    expect(kg.finalKg, 80);
    expect(kg.finalLitres, greaterThan(80));
    expect(litres.waterKg, closeTo(kg.waterKg, 1e-8));
  });
  test('already at target needs no additions and valid zero is accepted', () {
    final result = BarrelBlend.calculate(additions: const [
      BlendAddition(litres: 80, abv: .65),
      BlendAddition(litres: 0, abv: 0),
    ], targetUnit: BarrelTargetUnit.litres);
    expect(result.spiritLitres, closeTo(0, 1e-8));
    expect(result.waterKg, closeTo(0, 1e-8));
  });
  test('rejects impossible targets and invalid numeric inputs', () {
    for (final value in [double.nan, double.infinity, -1.0, 0.0]) {
      expect(
          () =>
              BarrelBlend.calculate(additions: additions, targetAmount: value),
          throwsArgumentError);
    }
    expect(() => BarrelBlend.calculate(additions: additions, topUpAbv: .1),
        throwsArgumentError);
    expect(() => BarrelBlend.calculate(additions: additions, targetAmount: 10),
        throwsArgumentError);
    expect(() => BarrelBlend.calculate(additions: additions, targetAmount: 110),
        throwsArgumentError);
    for (final value in [double.nan, double.infinity, -1.0, 1.01]) {
      expect(
          () => BarrelBlend.calculate(
              additions: [BlendAddition(litres: 1, abv: value)]),
          throwsArgumentError);
      expect(() => BarrelBlend.calculate(additions: [], targetAbv: value),
          throwsArgumentError);
      expect(() => BarrelBlend.calculate(additions: [], topUpAbv: value),
          throwsArgumentError);
    }
  });
}
