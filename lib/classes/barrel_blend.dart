import '../tables/oiml.dart';

/// A spirit addition measured in litres at 20°C. ABV is a fraction, not percent.
class BlendAddition {
  final double litres;
  final double abv;
  const BlendAddition({required this.litres, required this.abv});

  factory BlendAddition.kilograms(
      {required double weightKg, required double abv}) {
    BarrelBlend._range('Addition weight', weightKg, 0, double.maxFinite);
    BarrelBlend._range('Addition ABV', abv, 0, 1);
    return BlendAddition(
        litres: weightKg / (OIMLTables.tableII(abv, 20) / 1000), abv: abv);
  }
}

enum BarrelTargetUnit { kilograms, litres }

/// A mass-balanced ethanol/water blend at 20°C, including volume contraction.
/// This is a planning calculation; dissolved sugar/extract is not modelled.
class BarrelBlend {
  final double spiritLitres;
  final double spiritKg;
  final double waterLitres;
  final double waterKg;
  final double finalLitres;
  final double finalKg;
  final double finalLals;

  const BarrelBlend._({
    required this.spiritLitres,
    required this.spiritKg,
    required this.waterLitres,
    required this.waterKg,
    required this.finalLitres,
    required this.finalKg,
    required this.finalLals,
  });

  static void _range(String field, double value, double min, double max) {
    if (!value.isFinite || value < min || value > max) {
      throw ArgumentError('$field must be finite and between $min and $max.');
    }
  }

  static BarrelBlend calculate({
    required List<BlendAddition> additions,
    double targetAbv = 0.65,
    double targetAmount = 80,
    BarrelTargetUnit targetUnit = BarrelTargetUnit.kilograms,
    double topUpAbv = 0.80,
    double capacityLitres = 100,
  }) {
    _range('Target ABV', targetAbv, 0.000001, 1);
    _range('Top-up ABV', topUpAbv, 0.000001, 1);
    _range('Target amount', targetAmount, 0.000001, double.maxFinite);
    _range('Barrel capacity', capacityLitres, 0.000001, double.maxFinite);
    final density = OIMLTables.tableII(targetAbv, 20) / 1000;
    final finalKg = targetUnit == BarrelTargetUnit.kilograms
        ? targetAmount
        : targetAmount * density;
    final finalLitres = finalKg / density;
    if (!finalKg.isFinite ||
        !finalLitres.isFinite ||
        finalLitres > capacityLitres + 1e-8) {
      throw ArgumentError('Target exceeds the barrel capacity.');
    }
    var inputKg = 0.0;
    var inputLals = 0.0;
    for (var i = 0; i < additions.length; i++) {
      final addition = additions[i];
      _range('Addition ${i + 1} litres', addition.litres, 0, double.maxFinite);
      _range('Addition ${i + 1} ABV', addition.abv, 0, 1);
      inputKg += addition.litres * OIMLTables.tableII(addition.abv, 20) / 1000;
      inputLals += addition.litres * addition.abv;
    }
    final finalLals = finalLitres * targetAbv;
    final spiritLitres = (finalLals - inputLals) / topUpAbv;
    final spiritKg = spiritLitres * OIMLTables.tableII(topUpAbv, 20) / 1000;
    final waterKg = finalKg - inputKg - spiritKg;
    if (!spiritLitres.isFinite || !waterKg.isFinite) {
      throw ArgumentError('Additions are too large to calculate.');
    }
    if (spiritLitres < -1e-8) {
      throw ArgumentError(
          'Existing additions contain more alcohol than the target allows.');
    }
    if (waterKg < -1e-8) {
      throw ArgumentError(
          'Cannot reach this target: reduce additions, increase the target, or use stronger top-up spirit.');
    }
    return BarrelBlend._(
      spiritLitres: spiritLitres.clamp(0, double.maxFinite),
      spiritKg: spiritKg.clamp(0, double.maxFinite),
      waterKg: waterKg.clamp(0, double.maxFinite),
      waterLitres: waterKg.clamp(0, double.maxFinite) /
          (OIMLTables.tableII(0, 20) / 1000),
      finalLitres: finalLitres,
      finalKg: finalKg,
      finalLals: finalLals,
    );
  }
}
