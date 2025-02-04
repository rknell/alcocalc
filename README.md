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
- Maintains LALs (Litres of Absolute Alcohol) through calculations
- Provides acceptable ABV ranges for quality control
- Brix calculations for sugar content

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  alcocalc:
    git:
      url: git@bitbucket.org:rebellion-rum/alcocalc.git
      ref: main
```

## Usage

### Basic Dilution Calculation

```dart
import 'package:alcocalc/functions.dart';

void main() {
  final result = dilution(
    startingWeight: 25.0,      // kg
    startingABV: 0.962,        // 96.2%
    startingTemperature: 20.0, // Celsius
    sugars: [],                // No sugars for basic dilution
    targetABV: 0.65,          // 65%
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

### Dilution with Sugar Content (Using Brix)

```dart
import 'package:alcocalc/functions.dart';
import 'package:alcocalc/tables/brix.dart';

void main() {
  // Define sugars using Brix values
  final sugars = <Sugars>[
    Sugars(
      name: 'Sugar Syrup',
      specificGravity: Brix.brixToDensity(70), // 70° Brix sugar syrup
      percentage: 0.0064,                      // 0.64% of total volume
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
final result = diluteToVolume(
  startingABV: 0.962,
  startingTemperature: 20.0,
  sugars: [],
  targetABV: 0.65,
  targetVolume: 50.0, // Litres
);
```

### Dilution to Number of Bottles

```dart
final result = diluteToBottles(
  startingABV: 0.962,
  startingTemperature: 20.0,
  sugars: [],
  targetABV: 0.65,
  targetBottles: 100,
  bottleSize: 0.7, // 700ml bottles (default)
);
```

## Important Notes

- All temperatures should be in Celsius
- ABV values should be expressed as decimals (e.g., 0.40 for 40%)
- Weights should be in kilograms
- Volumes should be in litres
- The library uses OIML alcohol tables for accurate density calculations
- Brix values are used for sugar content calculations
- Sugar percentages are expressed as decimals (e.g., 0.0064 for 0.64%)

## Testing

The library includes comprehensive tests. Run them using:

```bash
dart test
```

## License

Private - All Rights Reserved 