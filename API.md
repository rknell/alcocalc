# Alcocalc Library API Documentation

This document provides details about the public API of the Alcocalc library, which offers various functions for alcohol calculations, dilution, and conversion between different measurements.

## Alcocalc Class

The main class that provides static utility methods for alcohol calculations.

### diluteByWeight

```dart
static DiluteByWeightResult diluteByWeight({
  required double startingABV,
  required double startingTemperature,
  required double targetABV,
  required double startingWeight,
})
```

Calculates dilution by weight using OIML tables.

**Parameters:**
- `startingABV`: The initial alcohol by volume as a decimal (e.g., 0.40 for 40%)
- `startingTemperature`: The temperature in Celsius
- `targetABV`: The desired final alcohol by volume as a decimal
- `startingWeight`: The initial weight in kilograms

**Returns:**
- A `DiluteByWeightResult` containing the calculated values

### correctedABV

```dart
static double correctedABV(double percentABV, double temperature)
```

Corrects ABV for temperature using OIML tables.

**Parameters:**
- `percentABV`: The alcohol by volume as a decimal
- `temperature`: The temperature in Celsius

**Returns:**
- The temperature-corrected ABV as a decimal

### abvToAbw

```dart
static double abvToAbw(double abv)
```

Converts ABV (Alcohol By Volume) to ABW (Alcohol By Weight) using OIML tables.

**Parameters:**
- `abv`: The alcohol by volume as a decimal

**Returns:**
- The alcohol by weight as a decimal

### litresOfAlcoholCalculation

```dart
static double litresOfAlcoholCalculation({
  required double weight,
  required double abv,
  double temperature = 20.0,
})
```

Calculates the total litres of pure alcohol (LALs) from a given weight, ABV, and temperature using OIML tables for accurate conversion.

**Parameters:**
- `weight`: The weight of the liquid in kilograms
- `abv`: The alcohol by volume as a decimal (e.g., 0.40 for 40%)
- `temperature`: The temperature in Celsius (defaults to 20°C)

**Returns:**
- The litres of pure alcohol (LALs)

### densityToBrix

```dart
static double densityToBrix(double specificGravity)
```

Converts specific gravity to degrees Brix (°Bx), which represents the sugar content of an aqueous solution.

**Parameters:**
- `specificGravity`: The specific gravity of the solution (ratio to water density)

**Returns:**
- The sugar content in degrees Brix (°Bx)

### brixToDensity

```dart
static double brixToDensity(double degreesBrix)
```

Converts degrees Brix to specific gravity.

**Parameters:**
- `degreesBrix`: The sugar content in degrees Brix (°Bx)

**Returns:**
- The specific gravity of the solution (ratio to water density)

## Classes

### DiluteByWeightResult

Contains all calculated values from a dilution by weight operation.

**Properties:**
- `targetWeight`: The calculated target weight after dilution
- `additionalWeight`: The weight of water to add
- `totalWeightOfAlcohol`: The total weight of alcohol in the solution
- `targetVolume`: The final volume after dilution
- `targetABV`: The target alcohol by volume
- `startingVolume`: The initial volume before dilution
- `correctedStartingABV`: The temperature-corrected initial ABV
- `lals`: The litres of pure alcohol (calculated as targetVolume * targetABV)
- `acceptableABVHigh`: Upper acceptable ABV limit (targetABV * 1.005)
- `acceptableABVLow`: Lower acceptable ABV limit (targetABV * 0.998)

### DilutionResult

Represents the complete result of a dilution operation, including sugar additions.

**Properties:**
- `date`: The date when the calculation was performed
- `startingWeight`: The initial weight in kilograms
- `correctedStartingABV`: The temperature-corrected initial ABV
- `lals`: The litres of pure alcohol
- `additionalWaterLitres`: The amount of water to add in litres
- `targetWeightAfterWater`: The target weight after adding water
- `calculatedABV`: The calculated final ABV
- `acceptableABVLow`: Lower acceptable ABV limit
- `acceptableABVHigh`: Upper acceptable ABV limit
- `sugarResults`: List of sugar additions
- `expectedBottles`: Expected number of bottles
- `targetVolume`: Target volume after dilution

### SugarResult

Represents a sugar addition in a dilution operation.

**Properties:**
- `name`: The name of the sugar
- `weight`: The weight of sugar to add in kilograms

### Sugars

Defines a type of sugar to be used in dilution calculations.

**Properties:**
- `name`: The name of the sugar
- `specificGravity`: The specific gravity of the sugar
- `percentage`: The percentage of the sugar in the solution (as a decimal)
- `weight`: The calculated weight of sugar to add
- `equivalentWaterWeight`: The equivalent weight of water (weight / specificGravity)

### AlcoholAdditionResult

Contains the results of an alcohol addition calculation.

**Properties:**
- `requiredAlcoholWeight`: The weight of high-proof alcohol to add
- `finalWeight`: The final weight after addition
- `finalVolume`: The final volume after addition
- `lals`: The litres of pure alcohol added

## Functions

### dilution

```dart
DilutionResult dilution({
  required double startingWeight,
  required double startingABV,
  required double startingTemperature,
  List<Sugars> sugars = const <Sugars>[],
  required double targetABV
})
```

Calculates a dilution with optional sugar additions.

**Parameters:**
- `startingWeight`: The initial weight in kilograms
- `startingABV`: The initial alcohol by volume as a decimal
- `startingTemperature`: The temperature in Celsius
- `sugars`: Optional list of sugars to add
- `targetABV`: The desired final alcohol by volume as a decimal

**Returns:**
- A `DilutionResult` containing the calculated values

### diluteToVolume

```dart
DilutionResult diluteToVolume({
  required double startingABV,
  required double startingTemperature,
  required List<Sugars> sugars,
  required double targetABV,
  required double targetVolume,
})
```

Calculates a dilution to achieve a specific target volume.

**Parameters:**
- `startingABV`: The initial alcohol by volume as a decimal
- `startingTemperature`: The temperature in Celsius
- `sugars`: List of sugars to add
- `targetABV`: The desired final alcohol by volume as a decimal
- `targetVolume`: The desired final volume in litres

**Returns:**
- A `DilutionResult` containing the calculated values

### diluteToBottles

```dart
DilutionResult diluteToBottles({
  required double startingABV,
  required double startingTemperature,
  required List<Sugars> sugars,
  required double targetABV,
  required double targetBottles,
  double bottleSize = 0.7,
})
```

Calculates a dilution to produce a specific number of bottles.

**Parameters:**
- `startingABV`: The initial alcohol by volume as a decimal
- `startingTemperature`: The temperature in Celsius
- `sugars`: List of sugars to add
- `targetABV`: The desired final alcohol by volume as a decimal
- `targetBottles`: The number of bottles to produce
- `bottleSize`: The size of each bottle in litres (defaults to 0.7L)

**Returns:**
- A `DilutionResult` containing the calculated values

### calculateAlcoholAddition

```dart
AlcoholAdditionResult calculateAlcoholAddition({
  required double currentWeight,
  required double currentABV,
  required double targetABV,
  required double additionABV,
  double temperature = 20.0,
})
```

Calculates how much high-proof alcohol to add to reach a target ABV.

**Parameters:**
- `currentWeight`: The current weight of the solution in kilograms
- `currentABV`: The current alcohol by volume as a decimal
- `targetABV`: The desired final alcohol by volume as a decimal
- `additionABV`: The ABV of the alcohol being added as a decimal
- `temperature`: The temperature in Celsius (defaults to 20°C)

**Returns:**
- An `AlcoholAdditionResult` containing the calculated values

## Usage Examples

### Basic Dilution

```dart
final result = Alcocalc.diluteByWeight(
  startingABV: 0.60,      // 60% ABV
  startingTemperature: 20, // 20°C
  targetABV: 0.40,        // 40% ABV
  startingWeight: 10.0,    // 10kg
);

print('Target weight: ${result.targetWeight}kg');
print('Water to add: ${result.additionalWeight}kg');
```

### Dilution with Sugar

```dart
final sugars = [
  Sugars(name: 'Simple syrup', specificGravity: 1.33, percentage: 0.05),
];

final result = dilution(
  startingWeight: 10.0,    // 10kg
  startingABV: 0.60,       // 60% ABV
  startingTemperature: 20, // 20°C
  sugars: sugars,
  targetABV: 0.40,         // 40% ABV
);

print(result.toString());
```

### Adding High-Proof Alcohol

```dart
final result = calculateAlcoholAddition(
  currentWeight: 20.0,    // 20kg
  currentABV: 0.35,       // 35% ABV
  targetABV: 0.40,        // 40% ABV
  additionABV: 0.962,     // 96.2% ABV
  temperature: 20.0,      // 20°C
);

print('Alcohol to add: ${result.requiredAlcoholWeight}kg');
``` 