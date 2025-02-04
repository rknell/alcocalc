import 'dart:math' as math;

import '../helpers.dart';

export '../helpers.dart';

const alpha = 25E-6;

class OIMLTables {
  /// Returns the density of a water-ethanol mixture based on mass percentage and temperature.
  ///
  /// Parameters:
  /// - [massPercentage]: Alcoholic strength by mass (0.0 to 1.0)
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns density in kg/m³
  static double tableI(double massPercentage, double tempCelsius) {
    final ak = [
      9.982012300E2,
      -1.929769495E2,
      3.891238958E2,
      -1.668103923E3,
      1.352215441E4,
      -8.829278388E4,
      3.062874042E5,
      -6.138381234E5,
      7.470172998E5,
      -5.478461354E5,
      2.234460334E5,
      -3.903285426E4,
    ];

    final bk = [
      -2.0618513E-1,
      -5.2682542E-3,
      3.6130013E-5,
      -3.8957702E-7,
      7.1693540E-9,
      -9.9739231E-11,
    ];

    final c1k = [
      1.693443461530087E-1,
      -1.046914743455169E1,
      7.196353469546523E1,
      -7.047478054272792E2,
      3.924090430035045E3,
      -1.210164659068747E4,
      2.248646550400788E4,
      -2.605562982188164E4,
      1.852373922069467E4,
      -7.420201433430137E3,
      1.285617841998974E3,
    ];

    final c2k = [
      -1.193013005057010E-2,
      2.517399633803461E-1,
      -2.170575700536993,
      1.353034988843029E1,
      -5.029988758547014E1,
      1.096355666577570E2,
      -1.422753946421155E2,
      1.080435942856230E2,
      -4.414153236817392E1,
      7.442971530188783,
    ];

    final c3k = [
      -6.802995733503803E-4,
      1.876837790289664E-2,
      -2.002561813734156E-1,
      1.022992966719220,
      -2.895696483903638,
      4.810060584300675,
      -4.672147440794683,
      2.458043105903461,
      -5.411227621436812E-1,
    ];
    final c4k = [
      4.075376675622027E-6,
      -8.763058573471110E-6,
      6.515031360099368E-6,
      -1.515784836987210E-6
    ];
    final c5k = [
      -2.788074354782409E-8,
      1.345612883493354E-8,
    ];

    double a = 0, b = 0, c = 0, d = 0, e = 0, f = 0, g = 0;

    for (var k = 0; k < ak.length; k++) {
      a += ak[k] * (math.pow(massPercentage, k));
    }

    for (var k = 0; k < bk.length; k++) {
      b += bk[k] * math.pow(tempCelsius - 20, k + 1);
    }

    for (var k = 0; k < c1k.length; k++) {
      c += c1k[k] *
          math.pow(massPercentage, k + 1) *
          (math.pow(tempCelsius - 20, 1));
    }

    for (var k = 0; k < c2k.length; k++) {
      d += c2k[k] *
          math.pow(massPercentage, k + 1) *
          (math.pow(tempCelsius - 20, 2));
    }

    for (var k = 0; k < c3k.length; k++) {
      e += c3k[k] *
          math.pow(massPercentage, k + 1) *
          (math.pow(tempCelsius - 20, 3));
    }

    for (var k = 0; k < c4k.length; k++) {
      f += c4k[k] *
          math.pow(massPercentage, k + 1) *
          (math.pow(tempCelsius - 20, 4));
    }

    for (var k = 0; k < c5k.length; k++) {
      g += c5k[k] *
          math.pow(massPercentage, k + 1) *
          (math.pow(tempCelsius - 20, 5));
    }

    return a + b + c + d + e + f + g;
  }

  /// Returns the density of a water-ethanol mixture based on volume percentage and temperature.
  ///
  /// Parameters:
  /// - [volumePercentage]: Alcoholic strength by volume (0.0 to 1.0)
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns density in kg/m³
  static double tableII(double volumePercentage, double tempCelsius) {
    return tableI(tableIVb(volumePercentage), tempCelsius);
  }

  /// Returns the density at 20°C based on mass percentage.
  ///
  /// Parameters:
  /// - [massPercentage]: Alcoholic strength by mass (0.0 to 1.0)
  ///
  /// Returns density in kg/m³ at 20°C
  static double tableIIIa(double massPercentage) => tableI(massPercentage, 20);

  /// Converts volume percentage to mass percentage.
  ///
  /// Parameters:
  /// - [volumePercentage]: Alcoholic strength by volume (0.0 to 1.0)
  ///
  /// Returns alcoholic strength by mass (0.0 to 1.0)
  static double tableIVb(double volumePercentage) {
    if (volumePercentage > 1) {
      throw MustBeDecimalPercentageException();
    }
    return findRoot(
      (x) => tableIIIb(x) - volumePercentage,
      0,
      1,
      precision: 0.000000000001,
    );
  }

  /// Converts mass percentage to volume percentage.
  ///
  /// Parameters:
  /// - [massPercentage]: Alcoholic strength by mass (0.0 to 1.0)
  ///
  /// Returns alcoholic strength by volume (0.0 to 1.0)
  static double tableIIIb(double massPercentage) =>
      massPercentage * tableI(massPercentage, 20) / tableI(1, 20);

  /// Returns the density at 20°C based on volume percentage.
  ///
  /// Parameters:
  /// - [volumePercentage]: Alcoholic strength by volume (0.0 to 1.0)
  ///
  /// Returns density in kg/m³ at 20°C
  static double tableIVa(double volumePercentage) =>
      tableII(volumePercentage, 20);

  /// Converts density at 20°C to mass percentage.
  ///
  /// Parameters:
  /// - [density20C]: Density of mixture in kg/m³ at 20°C (range: 789.3 to 998.2)
  ///
  /// Returns alcoholic strength by mass (0.0 to 1.0)
  static double tableVa(double density20C) {
    return findRoot(
      (massPercentage) => tableIIIa(massPercentage) - density20C,
      0,
      1,
    );
  }

  /// Converts density at 20°C to volume percentage.
  ///
  /// Parameters:
  /// - [density20C]: Density of mixture in kg/m³ at 20°C (range: 789.3 to 998.2)
  ///
  /// Returns alcoholic strength by volume (0.0 to 1.0)
  static double tableVb(double density20C) {
    return findRoot(
      (volumePercentage) => tableIVa(volumePercentage) - density20C,
      0,
      1,
      maxIterations: 50,
      precision: 0.00001,
    );
  }

  /// Converts density at given temperature to mass percentage.
  ///
  /// Parameters:
  /// - [density]: Density of mixture in kg/m³
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns alcoholic strength by mass (0.0 to 1.0)
  static double tableVI(double density, double tempCelsius) {
    return findRoot(
      (massPercentage) => tableI(massPercentage, tempCelsius) - density,
      0,
      1,
    );
  }

  /// Converts density at given temperature to volume percentage.
  ///
  /// Parameters:
  /// - [density]: Density of mixture in kg/m³
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns alcoholic strength by volume (0.0 to 1.0)
  static double tableVII(double density, double tempCelsius) {
    return tableIIIb(tableVI(density, tempCelsius));
  }

  /// Converts alcohometer mass reading to actual mass percentage at given temperature.
  ///
  /// Parameters:
  /// - [alcohometerMassReading]: Reading from soda lime glass alcohometer (mass %)
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns actual alcoholic strength by mass (0.0 to 1.0)
  static double tableVIIIa(double alcohometerMassReading, double tempCelsius) {
    return tableIXa(tableIIIa(alcohometerMassReading), tempCelsius);
  }

  /// Converts alcohometer volume reading to actual volume percentage at given temperature.
  ///
  /// Parameters:
  /// - [alcohometerVolReading]: Reading from soda lime glass alcohometer (volume %)
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns actual alcoholic strength by volume (0.0 to 1.0)
  static double tableVIIIb(double alcohometerVolReading, double tempCelsius) {
    return tableIXb(tableIVa(alcohometerVolReading), tempCelsius);
  }

  /// Converts hydrometer reading to mass percentage at given temperature.
  ///
  /// Parameters:
  /// - [hydrometerReading]: Reading from soda lime glass hydrometer
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns alcoholic strength by mass (0.0 to 1.0)
  static double tableIXa(double hydrometerReading, double tempCelsius) {
    final densityAtTemp =
        hydrometerReading * (1 - alpha * (tempCelsius - 20.0));
    return tableVI(densityAtTemp, tempCelsius);
  }

  /// Converts hydrometer reading to volume percentage at given temperature.
  ///
  /// Parameters:
  /// - [hydrometerReading]: Reading from soda lime glass hydrometer
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns alcoholic strength by volume (0.0 to 1.0)
  static double tableIXb(double hydrometerReading, double tempCelsius) {
    final densityAtTemp =
        hydrometerReading * (1 - alpha * (tempCelsius - 20.0));
    return tableVII(densityAtTemp, tempCelsius);
  }

  /// Converts borosilicate glass measurement to mass percentage at given temperature.
  ///
  /// Parameters:
  /// - [borosilicateReading]: Density measurement from borosilicate glass instrument
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns alcoholic strength by mass (0.0 to 1.0)
  static double tableXa(double borosilicateReading, double tempCelsius) {
    final densityAtTemp =
        borosilicateReading * (1 - alpha * (tempCelsius - 20.0));
    return tableVI(densityAtTemp, tempCelsius);
  }

  /// Converts borosilicate glass measurement to volume percentage at given temperature.
  ///
  /// Parameters:
  /// - [borosilicateReading]: Density measurement from borosilicate glass instrument
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns alcoholic strength by volume (0.0 to 1.0)
  static double tableXb(double borosilicateReading, double tempCelsius) {
    final densityAtTemp =
        borosilicateReading * (1 - alpha * (tempCelsius - 20.0));
    return tableVII(densityAtTemp, tempCelsius);
  }

  /// Calculates pure ethanol volume at 20°C in 100dm³ of mixture from mass percentage.
  ///
  /// Parameters:
  /// - [massPercentage]: Alcoholic strength by mass (0.0 to 1.0)
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns volume of pure ethanol in dm³ per 100dm³ of mixture
  static double tableXIa(double massPercentage, double tempCelsius) {
    const beta = 36E-6;
    return massPercentage *
        (tableI(massPercentage, tempCelsius) / tableIIIa(1.0)) *
        (1 + beta * (tempCelsius - 20.0)) *
        100;
  }

  /// Calculates pure ethanol volume at 20°C in 100dm³ of mixture from volume percentage.
  ///
  /// Parameters:
  /// - [volumePercentage]: Alcoholic strength by volume (0.0 to 1.0)
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns volume of pure ethanol in dm³ per 100dm³ of mixture
  static double tableXIb(double volumePercentage, double tempCelsius) {
    return tableXIa(tableIVb(volumePercentage), tempCelsius);
  }

  /// Calculates pure ethanol volume at 20°C in 100kg of mixture from mass percentage.
  ///
  /// Parameters:
  /// - [massPercentage]: Alcoholic strength by mass (0.0 to 1.0)
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns volume of pure ethanol in dm³ per 100kg of mixture
  static double tableXIIa(double massPercentage, double tempCelsius) {
    return massPercentage *
        (1E3 / tableIIIa(1.0)) *
        (1 - 1.2 * ((1.0 / 8000) - (1 / tableI(massPercentage, tempCelsius)))) *
        100;
  }

  /// Calculates pure ethanol volume at 20°C in 100kg of mixture from volume percentage.
  ///
  /// Parameters:
  /// - [volumePercentage]: Alcoholic strength by volume (0.0 to 1.0)
  /// - [tempCelsius]: Temperature in °C (range: -20°C to +40°C)
  ///
  /// Returns volume of pure ethanol in dm³ per 100kg of mixture
  static double tableXIIb(double volumePercentage, double tempCelsius) {
    return tableXIIa(tableIVb(volumePercentage), tempCelsius);
  }
}

class MustBeDecimalPercentageException implements Exception {}
