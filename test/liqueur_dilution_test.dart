import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/oiml.dart';
import 'package:test/test.dart';

void main() {
  group('LiqueurDilution without sugars', () {
    test('should correctly dilute 96.2% ABV to 65% ABV', () {
      final result = Alcocalc.dilution(
        startingWeight: 25.0,
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
      );

      expect(result.startingWeight, equals(25.0));
      expect(result.correctedStartingABV.toStringAsFixed(4), equals('0.9620'));
      expect(result.additionalWaterLitres.toStringAsFixed(2), equals('16.18'));
      expect(result.targetWeightAfterWater.toStringAsFixed(2), equals('41.18'));
      expect(result.calculatedABV.toStringAsFixed(4), equals('0.6500'));
      expect(result.acceptableABVLow.toStringAsFixed(4), equals('0.6487'));
      expect(result.acceptableABVHigh.toStringAsFixed(4), equals('0.6532'));
      expect(result.expectedBottles.toStringAsFixed(1), equals('65.5'));
    });

    test('should correctly dilute 74.16% ABV to 37% ABV', () {
      final result = Alcocalc.dilution(
        startingWeight: 23.94,
        startingABV: 0.7416,
        startingTemperature: 25.7,
        sugars: [],
        targetABV: 0.37,
      );

      expect(result.startingWeight, equals(23.94));
      expect(result.correctedStartingABV.toStringAsFixed(4), equals('0.7234'));
      expect(result.targetWeightAfterWater.toStringAsFixed(2), equals('50.69'));
      expect(result.calculatedABV.toStringAsFixed(4), equals('0.3700'));
      expect(result.acceptableABVLow.toStringAsFixed(4), equals('0.3693'));
      expect(result.acceptableABVHigh.toStringAsFixed(4), equals('0.3719'));
    });

    test('toString should format output consistently', () {
      final result = Alcocalc.dilution(
        startingWeight: 25.0,
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
      );

      final output = result.toString();
      expect(output, contains('Starting weight 25.00'));
      expect(output, contains('ABV @ 20deg: 0.9620'));
      expect(output, contains('Additional litres of water: 16.18'));
      expect(output, contains('Calculated target weight after water: 41.18'));
      expect(output, contains('Calculated ABV: 0.6500'));
      expect(
          output, contains('Measured ABV must be between: 0.6487 and 0.6532'));
      expect(output, contains('Expected bottles: 65.5'));
    });

    test(
        'should maintain LALs (Litres of Absolute Alcohol) through Alcocalc.dilution',
        () {
      final result = Alcocalc.dilution(
        startingWeight: 25.0,
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
      );

      // Calculate LALs from starting conditions
      final startingVolume = result.startingWeight /
          (OIMLTables.tableII(result.correctedStartingABV, 20) / 1000);
      final startingLALs = startingVolume * result.correctedStartingABV;

      // Compare with final LALs
      expect(result.lals.toStringAsFixed(2),
          equals(startingLALs.toStringAsFixed(2)));
    });
  });

  group('LiqueurDilutionToVolume without sugars', () {
    test('should calculate correct starting weight for target volume of 50L',
        () {
      final result = Alcocalc.diluteToVolume(
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
        targetVolume: 50.0,
      );

      expect(result.targetVolume.toStringAsFixed(2), equals('50.00'));
      expect(result.correctedStartingABV.toStringAsFixed(4), equals('0.9620'));
      expect(result.calculatedABV.toStringAsFixed(4), equals('0.6500'));

      // Verify that LALs are maintained
      final startingVolume = result.startingWeight /
          (OIMLTables.tableII(result.correctedStartingABV, 20) / 1000);
      final startingLALs = startingVolume * result.correctedStartingABV;
      expect(result.lals.toStringAsFixed(2),
          equals(startingLALs.toStringAsFixed(2)));
    });

    test('should calculate correct starting weight for 100 bottles', () {
      final result = Alcocalc.diluteToVolume(
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
        targetVolume: 70.0, // 100 bottles at 0.7L each
      );

      expect(result.targetVolume.toStringAsFixed(2), equals('70.00'));
      expect(result.expectedBottles.toStringAsFixed(1), equals('100.0'));
      expect(result.calculatedABV.toStringAsFixed(4), equals('0.6500'));

      // Verify that LALs are maintained
      final startingVolume = result.startingWeight /
          (OIMLTables.tableII(result.correctedStartingABV, 20) / 1000);
      final startingLALs = startingVolume * result.correctedStartingABV;
      expect(result.lals.toStringAsFixed(2),
          equals(startingLALs.toStringAsFixed(2)));
    });

    test(
        'should handle temperature corrections correctly when calculating starting weight',
        () {
      final result = Alcocalc.diluteToVolume(
        startingABV: 0.7416,
        startingTemperature: 25.7,
        sugars: [],
        targetABV: 0.37,
        targetVolume: 45.0,
      );

      expect(result.targetVolume.toStringAsFixed(2), equals('45.00'));
      expect(result.correctedStartingABV.toStringAsFixed(4), equals('0.7234'));
      expect(result.calculatedABV.toStringAsFixed(4), equals('0.3700'));

      // Verify that LALs are maintained
      final startingVolume = result.startingWeight /
          (OIMLTables.tableII(result.correctedStartingABV, 20) / 1000);
      final startingLALs = startingVolume * result.correctedStartingABV;
      expect(result.lals.toStringAsFixed(2),
          equals(startingLALs.toStringAsFixed(2)));
    });

    test('should calculate consistent results with liqueurDilution', () {
      // First calculate using liqueurDilutionToVolume
      final volumeResult = Alcocalc.diluteToVolume(
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
        targetVolume: 50.0,
      );

      // Then use the calculated starting weight with regular liqueurDilution
      final dilutionResult = Alcocalc.dilution(
        startingWeight: volumeResult.startingWeight,
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
      );

      // Results should match
      expect(volumeResult.targetVolume.toStringAsFixed(2),
          equals(dilutionResult.targetVolume.toStringAsFixed(2)));
      expect(volumeResult.calculatedABV.toStringAsFixed(4),
          equals(dilutionResult.calculatedABV.toStringAsFixed(4)));
      expect(volumeResult.lals.toStringAsFixed(2),
          equals(dilutionResult.lals.toStringAsFixed(2)));
    });
  });

  group('LiqueurDilutionToBottles without sugars', () {
    test('should calculate correct starting weight for 100 bottles', () {
      final result = Alcocalc.diluteToBottles(
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
        targetBottles: 100,
      );

      expect(result.expectedBottles.toStringAsFixed(1), equals('100.0'));
      expect(result.targetVolume.toStringAsFixed(2),
          equals('70.00')); // 100 * 0.7L
      expect(result.correctedStartingABV.toStringAsFixed(4), equals('0.9620'));
      expect(result.calculatedABV.toStringAsFixed(4), equals('0.6500'));

      // Verify that LALs are maintained
      final startingVolume = result.startingWeight /
          (OIMLTables.tableII(result.correctedStartingABV, 20) / 1000);
      final startingLALs = startingVolume * result.correctedStartingABV;
      expect(result.lals.toStringAsFixed(2),
          equals(startingLALs.toStringAsFixed(2)));
    });

    test('should handle custom bottle size', () {
      final result = Alcocalc.diluteToBottles(
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
        targetBottles: 100,
        bottleSize: 0.5, // 500ml bottles
      );

      expect(result.expectedBottles.toStringAsFixed(1), equals('100.0'));
      expect(result.targetVolume.toStringAsFixed(2),
          equals('50.00')); // 100 * 0.5L
      expect(result.correctedStartingABV.toStringAsFixed(4), equals('0.9620'));
      expect(result.calculatedABV.toStringAsFixed(4), equals('0.6500'));
    });

    test('should calculate consistent results with liqueurDilutionToVolume',
        () {
      final bottlesResult = Alcocalc.diluteToBottles(
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
        targetBottles: 100,
      );

      final volumeResult = Alcocalc.diluteToVolume(
        startingABV: 0.962,
        startingTemperature: 20.0,
        sugars: [],
        targetABV: 0.65,
        targetVolume: 70.0, // 100 bottles * 0.7L
      );

      // Results should match
      expect(bottlesResult.targetVolume.toStringAsFixed(2),
          equals(volumeResult.targetVolume.toStringAsFixed(2)));
      expect(bottlesResult.startingWeight.toStringAsFixed(2),
          equals(volumeResult.startingWeight.toStringAsFixed(2)));
      expect(bottlesResult.calculatedABV.toStringAsFixed(4),
          equals(volumeResult.calculatedABV.toStringAsFixed(4)));
      expect(bottlesResult.lals.toStringAsFixed(2),
          equals(volumeResult.lals.toStringAsFixed(2)));
    });

    test('should handle temperature corrections correctly', () {
      final result = Alcocalc.diluteToBottles(
        startingABV: 0.7416,
        startingTemperature: 25.7,
        sugars: [],
        targetABV: 0.37,
        targetBottles: 50,
      );

      expect(
          result.targetVolume.toStringAsFixed(2), equals('35.00')); // 50 * 0.7L
      expect(result.expectedBottles.toStringAsFixed(1), equals('50.0'));
      expect(result.correctedStartingABV.toStringAsFixed(4), equals('0.7234'));
      expect(result.calculatedABV.toStringAsFixed(4), equals('0.3700'));
    });
  });
}
