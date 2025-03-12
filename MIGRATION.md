# Migration Guide for Alcocalc Library v2.0

This document outlines the breaking changes introduced in the latest version of Alcocalc and provides guidance on how to update your code to work with the new API.

## Major Changes

The library has been significantly refactored to improve organization, maintainability, and documentation:

1. **Reorganized Class Structure**: Functions have been moved into dedicated classes
2. **Static Methods**: Functions are now static methods on the `Alcocalc` class
3. **Result Objects**: New specialized result classes with more properties
4. **Enhanced Documentation**: Comprehensive API documentation
5. **Improved Type Safety**: More detailed assertions and better type checking

## Breaking Changes and Migration Steps

### 1. Import Changes

**Before:**
```dart
import 'package:alcocalc/functions.dart';
```

After:
```dart
import 'package:alcocalc/alcocalc.dart';

// For specific classes, you can also import directly:
import 'package:alcocalc/classes/alcohol_addition_result.dart';
import 'package:alcocalc/classes/dilution_result.dart';
import 'package:alcocalc/classes/sugar_result.dart';
import 'package:alcocalc/classes/sugars.dart';
```

The main `alcocalc.dart` file exports all necessary classes and functions, so the single import is usually sufficient.

### 2. Function Calls

All main functions have been converted to static methods on the `Alcocalc` class.

Before:
```dart
final result = dilution(
  startingWeight: 10.0,
  startingABV: 0.60,
  startingTemperature: 20,
  targetABV: 0.40,
);
```

After:
```dart
final result = Alcocalc.dilution(
  startingWeight: 10.0,
  startingABV: 0.60,
  startingTemperature: 20,
  targetABV: 0.40,
);
```

The following functions have been moved and are now static methods on `Alcocalc`:

- `dilution` → `Alcocalc.dilution`
- `diluteToVolume` → `Alcocalc.diluteToVolume`
- `diluteToBottles` → `Alcocalc.diluteToBottles`
- `calculateAlcoholAddition` → `Alcocalc.calculateAlcoholAddition`
- `correctedABV` → `Alcocalc.correctedABV`
- `abvToAbw` → `Alcocalc.abvToAbw`

### 3. Utility Methods

Utility methods previously on `AlcocalcFunctions` are now static methods on `Alcocalc`.

Before:
```dart
final alcocalc = AlcocalcFunctions();
final corrected = alcocalc.correctedABV(0.40, 25.0);
final abw = alcocalc.abvToAbw(0.40);
```

After:
```dart
final corrected = Alcocalc.correctedABV(0.40, 25.0);
final abw = Alcocalc.abvToAbw(0.40);
```

### 4. Result Objects

Result objects now have more properties and better documentation:

- `_DiluteByWeightResult` is now `DiluteByWeightResult` with additional properties
- `DilutionResult` has new properties and modified behavior
- New classes: `SugarResult`, `AlcoholAdditionResult`

**DiluteByWeightResult:**
The formerly private class is now public and has additional properties:
```dart
DiluteByWeightResult(
  startingABW: double,
  startingABV: double,
  startingTemperature: double,
  targetABV: double,
  startingWeight: double,
  totalWeightOfAlcohol: double,
  targetABW: double,
  startingVolume: double,
  targetWeight: double,
  additionalWeight: double,
  targetDensity: double,
  targetVolume: double,
  correctedStartingABV: double
)
```

**DilutionResult:**
Now has a new property `targetFinalWeight` and a consistently available `runningWeight` property via `SugarResult` objects.

**AlcoholAdditionResult:**
Now includes all intermediate calculation values:
```dart
AlcoholAdditionResult(
  // Input parameters
  currentWeight, currentABV, targetABV, additionABV, temperature,
  // Calculation values
  correctedCurrentABV, correctedAdditionABV, currentDensity, additionDensity, 
  targetDensity, currentVolume, currentAlcoholVolume, additionVolume,
  // Results
  requiredAlcoholWeight, finalWeight, finalVolume, lals
)
```

### 5. Sugar Handling

The `Sugars` class now has more structured behavior and the sugar results in a dilution calculation are now instances of `SugarResult`.

Before:
```dart
for (var sugar in result.sugarResults) {
  print('${sugar.name}: ${sugar.weight}');
}
```

After:
```dart
for (var sugar in result.sugarResults) {
  print('${sugar.name}: ${sugar.weight}, Running Total: ${sugar.runningWeight}');
}
```

The `SugarResult` class now includes a `runningWeight` property to track cumulative weight:

```dart
SugarResult({
  required String name,
  required double weight, 
  required double runningWeight
})
```

### 6. Additional Method Changes

The `Alcocalc.dilution` method now returns additional information and handles weights more consistently. The returned `DilutionResult` contains:
```dart
DilutionResult({
  required double startingWeight,
  required double correctedStartingABV,
  required double lals,
  required double additionalWaterLitres,
  required double targetWeightAfterWater,
  required double calculatedABV,
  required List<SugarResult> sugarResults,
  required double expectedBottles,
  required double targetVolume,
  required double targetFinalWeight,
})
```

## Conclusion

The new API provides more robust functionality, better type safety, and improved documentation. The reorganized class structure and static methods offer more consistent behavior and a more maintainable codebase.

For detailed information on all available functions and classes, refer to the API.md file which contains comprehensive documentation of the entire public API.

If you encounter any issues during migration, refer to the comprehensive API documentation in API.md or the examples in the README.md file.