# AlcoCalc

A Dart library for precise alcohol dilution calculations, specifically designed for distillers and liqueur makers. This library provides accurate calculations for diluting spirits and creating liqueurs, taking into account temperature corrections and sugar content.

## Features

- Calculate dilutions from a starting ABV to a target ABV
- Temperature correction for accurate measurements
- Support for sugar content in liqueur calculations
- Three main calculation modes:
  - Standard dilution (by weight)
  - Dilution to specific volume
  - Dilution to number of bottles
- Calculate alcohol additions to increase ABV
- Maintains LALs (Litres of Absolute Alcohol) through calculations
- Provides acceptable ABV ranges for quality control
- Brix calculations for sugar content

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  alcocalc:
    git:
      url: https://github.com/rknell/alcocalc.git
      ref: main  # or specific version tag
```

## API Overview

### Main Functions

| Function | Description |
| --- | --- |
| `dilution` | Core function for alcohol dilution with optional sugar content |
| `diluteToVolume` | Calculate dilution to reach a specific final volume |
| `diluteToBottles` | Calculate dilution to produce a specific number of bottles |
| `calculateAlcoholAddition` | Calculate high-proof alcohol addition to increase ABV |

### Result Classes

| Class | Description |
| --- | --- |
| `DilutionResult` | Contains detailed dilution calculations and recommendations |
| `SugarResult` | Contains sugar-related calculations for liqueurs |
| `AlcoholAdditionResult` | Results for alcohol addition calculations |

### Utility Methods

The `Alcocalc` class provides various utility methods:
- `diluteByWeight`: Core dilution calculation
- `correctedABV`: Temperature correction for ABV
- `abvToAbw`: Convert ABV to ABW (Alcohol By Weight)
- `litresOfAlcoholCalculation`: Calculate LALs (Litres of Absolute Alcohol)
- `densityToBrix`/`brixToDensity`: Convert between density and Brix (sugar content)

## Usage Examples

### Basic Dilution Calculation

```dart
import 'package:alcocalc/alcocalc.dart';

void main() {
  final result = dilution(
    startingWeight: 25.0,      // kg
    startingABV: 0.962,        // 96.2%
    startingTemperature: 20.0, // Celsius
    sugars: [],                // No sugars for basic dilution
    targetABV: 0.65,           // 65%
  );
  
  print(result.toString());
  // Output includes:
  // - Starting weight and ABV
  // - Additional water needed
  // - Target weight after water
  // - Calculated final ABV
  // - Acceptable ABV range
  // - Expected number of bottles
}
```

### Dilution with Sugar Content (For Liqueurs)

```dart
import 'package:alcocalc/alcocalc.dart';

void main() {
  // Define sugars using specific gravity values
  final sugars = <Sugars>[
    Sugars(
      name: 'Sugar Syrup',
      specificGravity: 1.359,  // Specific gravity for 70° Brix sugar syrup
      percentage: 0.0064,      // 0.64% of total volume
    ),
    Sugars(
      name: 'Distillers Caramel',
      specificGravity: 1.6,
      percentage: 0.002,       // 0.2% of total volume
    ),
  ];

  final result = dilution(
    startingWeight: 23.94,
    startingABV: 0.7416,        // 74.16%
    startingTemperature: 25.7,  // Celsius
    sugars: sugars,
    targetABV: 0.37,           // 37%
  );
  
  print(result);
  // Output will include sugar calculations in addition to standard dilution info
}
```

### Dilution to Specific Volume

```dart
import 'package:alcocalc/alcocalc.dart';

void main() {
  final result = diluteToVolume(
    startingABV: 0.962,
    startingTemperature: 20.0,
    sugars: [],
    targetABV: 0.65,
    targetVolume: 50.0, // Litres
  );
  
  // Output includes required starting weight and water addition
  print("Required starting weight: ${result.startingWeight} kg");
  print("Required water addition: ${result.waterAddition} kg");
}
```

### Dilution to Number of Bottles

```dart
import 'package:alcocalc/alcocalc.dart';

void main() {
  final result = diluteToBottles(
    startingABV: 0.962,
    startingTemperature: 20.0,
    sugars: [],
    targetABV: 0.65,
    targetBottles: 100,
    bottleSize: 0.7, // 700ml bottles (default)
  );
  
  // Output includes required starting weight and water addition
  print("Required starting weight: ${result.startingWeight} kg");
  print("Required water addition: ${result.waterAddition} kg");
}
```

### Adding High-Proof Alcohol

```dart
import 'package:alcocalc/alcocalc.dart';

void main() {
  final result = calculateAlcoholAddition(
    currentWeight: 100.0,     // kg
    currentABV: 0.35,         // 35%
    targetABV: 0.40,          // Target 40%
    additionABV: 0.962,       // Using 96.2% alcohol
    temperature: 20.0,        // Celsius
  );
  
  print("Required high-proof alcohol: ${result.additionWeight} kg");
  print("Final weight: ${result.finalWeight} kg");
  print("Final volume: ${result.finalVolume} L");
  print("LALs added: ${result.lalsAdded} L");
}
```

## Working with Sugar Content

Sugar content is represented using the `Sugars` class:

```dart
Sugars(
  name: String,               // Name of the sugar ingredient
  specificGravity: double,    // Specific gravity of the sugar
  percentage: double,         // Percentage as decimal (e.g., 0.01 for 1%)
)
```

You can convert between Brix and density using utility methods:
```dart
// Convert density to Brix
double brix = Alcocalc.densityToBrix(1.359);  // Returns ~70°Brix

// Convert Brix to density
double density = Alcocalc.brixToDensity(70.0); // Returns ~1.359
```

## Important Notes

- All temperatures should be in Celsius
- ABV values should be expressed as decimals (e.g., 0.40 for 40%)
- Weights should be in kilograms
- Volumes should be in litres
- The library uses OIML alcohol tables for accurate density calculations
- Sugar percentages are expressed as decimals (e.g., 0.0064 for 0.64%)
- All calculations include temperature correction for accurate results

## Testing

The library includes comprehensive tests. Run them using:

```bash
dart test
```

To run a specific test file:

```bash
dart test test/brix_test.dart
```

To run a specific test group or individual test:

```bash
dart test test/liqueur_dilution_test.dart -n "should correctly dilute"
```

## License

Proprietary - All rights reserved. This software may be used as a dependency in other projects but may not be modified or redistributed without explicit permission. See the LICENSE file for details.