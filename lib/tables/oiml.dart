import 'dart:math' as math;

import '../helpers.dart';

export '../helpers.dart';

const alpha = 25E-6;

class OIMLTables {
  // """
  //   Table I gives the density of a mixture as a function of the temperature in °C, from — 20 °C to + 40 °C, and of the
  //   alcoholic strength by mass from the minimum permissible value and 100%, this minimum value corresponding to the
  //   freezing of the mixture for the temperature considered.
  //   :param p: alcoholic strength by mass in %
  //   :type p: float
  //   :param t: temperature in °C, from — 20 °C to + 40 °C
  //   :type t: float
  //   :return: density of a mixture of water and ethanol in kg/m3
  //   :rtype: float
  //   """
  // rho_p_t
  static double tableI(double p, double t) {
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
      a += ak[k] * (math.pow(p, k));
    }

    for (var k = 0; k < bk.length; k++) {
      b += bk[k] * math.pow(t - 20, k + 1);
    }

    for (var k = 0; k < c1k.length; k++) {
      c += c1k[k] * math.pow(p, k + 1) * (math.pow(t - 20, 1));
    }

    for (var k = 0; k < c2k.length; k++) {
      d += c2k[k] * math.pow(p, k + 1) * (math.pow(t - 20, 2));
    }

    for (var k = 0; k < c3k.length; k++) {
      e += c3k[k] * math.pow(p, k + 1) * (math.pow(t - 20, 3));
    }

    for (var k = 0; k < c4k.length; k++) {
      f += c4k[k] * math.pow(p, k + 1) * (math.pow(t - 20, 4));
    }

    for (var k = 0; k < c5k.length; k++) {
      g += c5k[k] * math.pow(p, k + 1) * (math.pow(t - 20, 5));
    }

    final output = a + b + c + d + e + f + g;

    return output;
  }

  // """
  // Table II gives the density of a mixture as a function of the temperature varying from — 20 °C to + 40 °C
  // and of the alcoholic strength by volume varying between the minimum permissible value and 100 %.
  // :param q: alcoholic strength by volume in %
  // :type q: float
  // :param t: temperature in °C, from — 20 °C to + 40 °C
  // :type t: float
  // :return: density of a mixture of water and ethanol in kg/m3
  // :rtype: float
  // """
  // rho_q_t
  static double tableII(double abvPercentage, double temperature) {
    return tableI(tableIVb(abvPercentage), temperature);
  }

  // """
  //   Table IIIa gives the density at 20 °C as a function of the alcoholic strength by mass varying between 0 % and
  //   100 %.
  //   :param p: alcoholic strength by mass in %
  //   :type p: float
  //   :return: density of a mixture of water and ethanol in kg/m3 at 20 °C
  //   :rtype: float
  //   """
  // rho20_p
  static double tableIIIa(p) => tableI(p, 20);

  // """
  //   Table IVb gives the alcoholic strength by mass as a function of the alcoholic strength by volume varying between
  //   0 and 100 %.
  //   :param q: alcoholic strength by volume in %
  //   :type q: float
  //   :return: alcoholic strength by mass in %
  //   :rtype: float
  //   """
  // p_q
  static double tableIVb(double q) {
    if (q > 1) {
      throw MustBeDecimalPercentageException();
    }
    return findRoot((x) => tableIIIb(x) - q, 0, 1, precision: 0.000000000001);
  }

  // """
  //   Table IIIb gives the alcoholic strength by volume as a function of the alcoholic strength by mass varying between
  //   0 % and 100 %.
  //   :param p: alcoholic strength by mass in %
  //   :type p: float
  //   :return: alcoholic strength by volume in %
  //   :rtype: float
  //   """
  // q_p
  static double tableIIIb(double p) => p * tableI(p, 20) / tableI(1, 20);

  // """
  //   Table IVa gives the density at 20 °C as a function of the alcoholic strength by volume varying between 0 and 100 %.
  //   :param q: alcoholic strength by volume in %
  //   :type q: float
  //   :return: density of a mixture of water and ethanol in kg/m3 at 20 °C
  //   :rtype: float
  //   """
  // rho20_q
  static double tableIVa(double q) => tableII(q, 20);

  // # type: (float) -> float
  // """
  //   Table Va gives the alcoholic strength by mass as a function of the density at 20 °C varying between 789.3 kg/m3 and
  //   998.2 kg/m3.
  //   :param rho20: density of a mixture of water and ethanol in kg/m3 at 20 °C
  //   :type rho20: float
  //   :return: alcoholic strength by mass in %
  //   :rtype: float
  //   """
  // p_rho20
  static double tableVa(double d) {
    return findRoot(
      (p) => tableIIIa(p) - d,
      0,
      1,
    );
  }

  //     # type: (float, float) -> float
  //     """
  //     Table Vb gives the alcoholic strength by volume as a function of the density at 20 °C varying between 789.3 kg/m3
  //     and 998.2 kg/m3.
  //     :param rho20: density of a mixture of water and ethanol in kg/m3 at 20 °C
  //     :type rho20: float
  //     :return: alcoholic strength by volume in %
  //     :rtype: float
  //     """
  static double tableVb(double density) {
    return findRoot((p) => tableIVa(p) - density, 0, 1,
        maxIterations: 50, precision: 0.00001);
  }

  // # type: (float, float) -> float
  // """
  //   Table VI gives the value of the alcoholic strength by mass of a mixture as a function of its Celsius temperature t
  //   and of its density at this temperature.
  //   :param rho: density of a mixture of water and ethanol in kg/m3
  //   :type rho: float
  //   :param t: temperature in °C, from — 20 °C to + 40 °C
  //   :type t: float
  //   :return: alcoholic strength by mass in %
  //   :rtype: float
  //   """
  static double tableVI(double density, double temperature) {
    return findRoot(
      (percentage) => tableI(percentage, temperature) - density,
      0,
      1,
    );
  }

  //     # type: (float, float) -> float
  //     """
  //     Table VII gives the alcoholic strength by volume of a mixture as a function of its Celsius temperature t and of its
  //     density at the same temperature.
  //     :param rho: density of a mixture of water and ethanol in kg/m3
  //     :type rho: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: alcoholic strength by volume in %
  //     :rtype: float
  //     """
  static double tableVII(double density, double temperature) {
    return tableIIIb(tableVI(density, temperature));
  }

  // # type: (float, float) -> float
  // """
  // Table VIIIa gives the value of the alcoholic strength by mass of a mixture at the Celsius temperature t from the
  // reading of an alcohometer made of soda lime glass, graduated in units of alcoholic strength by mass (% mass).
  // :param p: reading of an alcohometer made of soda lime glass, graduated in units of alcoholic strength by mass
  // :type p: float
  // :param t: temperature in °C, from — 20 °C to + 40 °C
  // :type t: float
  // :return: alcoholic strength by mass in %
  // :rtype: float
  // """
  static double tableVIIIa(double p, double t) {
    return tableIXa(tableIIIa(p), t);
  }

  //     # type: (float, float) -> float
  //     """
  //     Table VIIIb gives the value of the alcoholic strength by volume of a mixture at the Celsius temperature t from the
  //     reading of an alcohometer made of soda lime glass, graduated in units of alcoholic strength by volume (% vol).
  //     :param q: reading of an alcohometer made of soda lime glass, graduated in units of alcoholic strength by volume
  //     :type q: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: alcoholic strength by volume in %
  //     :rtype: float
  //     """
  static double tableVIIIb(double p, double t) {
    return tableIXb(tableIVa(p), t);
  }

  //      # type: (float, float) -> float
  //     """
  //     Table IXa gives the value of the alcoholic strength by mass of a mixture at the Celsius temperature t from the
  //     reading of a hydrometer for alcohol in soda lime glass.
  //     :param rho20prime: reading of a hydrometer for alcohol in soda lime glass
  //     :type rho20prime: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: alcoholic strength by mass in %
  //     :rtype: float
  //     """
  // p_rho20prime_t
  static double tableIXa(double p, double t) {
    final rho_t = p * (1 - alpha * (t - 20.0));
    return tableVI(rho_t, t);
  }

  //  """
  //     Table IXb gives respectively the value of the alcoholic strength by volume of a mixture at the Celsius temperature
  //     t from the reading of a hydrometer for alcohol in soda lime glass.
  //     :param rho20prime: reading of a hydrometer for alcohol in soda lime glass
  //     :type rho20prime: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: alcoholic strength by volume in %
  //     :rtype: float
  //     """
  static double tableIXb(double p, double t) {
    final rho_t = p * (1 - alpha * (t - 20.0));
    return tableVII(rho_t, t);
  }

  // # type: (float, float) -> float
  // """
  //   Tables Xa gives the value of the alcoholic strength by mass of a mixture at the Celsius temperature t from the
  //   measurement of the density of this mixture by means of an instrument made of borosilicate glass.
  //   :param rho20prime: measurement of the density of this mixture by means of an instrument made of borosilicate glass
  //   :type rho20prime: float
  //   :param t: temperature in °C, from — 20 °C to + 40 °C
  //   :type t: float
  //   :return: alcoholic strength by mass in %
  //   :rtype: float
  //   """
  static double tableXa(double p, double t) {
    final rho_t = p * (1 - alpha * (t - 20.0));
    return tableVI(rho_t, t);
  }

  //# type: (float, float) -> float
  //     """
  //     Tables Xb gives respectively the value of the alcoholic strength by volume of a mixture at the Celsius temperature
  //     t from the measurement of the density of this mixture by means of an instrument made of borosilicate glass.
  //     :param rho20prime: measurement of the density of this mixture by means of an instrument made of borosilicate glass
  //     :type rho20prime: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: alcoholic strength by volume in %
  //     :rtype: float
  //     """
  static double tableXb(double p, double t) {
    final rho_t = p * (1 - alpha * (t - 20.0));
    return tableVII(rho_t, t);
  }

  //# type: (float, float) -> float
  //     """
  //     Table XIa gives in dm3 the volume v at 20 °C of pure ethanol contained in 100 dm3 of a mixture of known alcoholic
  //     strength by mass at the Celsius temperature t, assuming that the volume of 100 dm3 was measured by a container in
  //     steel calibrated at 20 °C.
  //     :param p: alcoholic strength by mass in % measured by a container in steel calibrated at 20 °C
  //     :type p: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: volume v at 20 °C of pure ethanol contained in 100 dm3 of a mixture, in dm3
  //     :rtype:
  static double tableXIa(double p, double t) {
    const beta = 36E-6;
    return p * (tableI(p, t) / tableIIIa(1.0)) * (1 + beta * (t - 20.0)) * 100;
  }

  //# type: (float, float) -> float
  //     """
  //     Tables XIb gives in dm3 the volume v at 20 °C of pure ethanol contained in 100 dm3 of a mixture of known alcoholic
  //     strength by volume at the Celsius temperature t, assuming that the volume of 100 dm3 was measured by a container
  //     in steel calibrated at 20 °C.
  //     :param q: alcoholic strength by volume in % measured by a container in steel calibrated at 20 °C
  //     :type q: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: volume v at 20 °C of pure ethanol contained in 100 dm3 of a mixture, in dm3
  //     :rtype: float
  //     """
  static double tableXIb(double q, double t) {
    return tableXIa(tableIVb(q), t);
  }

  //# type: (float, float) -> float
  //     """
  //     Table XIIa gives in dm3 the volume v at 20 °C of pure ethanol contained in 100 kg of a mixture of known alcoholic
  //     strength by mass at the Celsius temperature t. It is assumed that the weighing took place in air whose density was
  //     1.2 kg/m3, by means of weights characterized by the conventional value of the result of their weighing in air.
  //     :param p: alcoholic strength by mass in %
  //     :type p: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: volume v at 20 °C of pure ethanol contained in 100 kg of a mixture, in dm3
  //     :rtype: float
  //     """
  static double tableXIIa(double p, double t) {
    return p *
        (1E3 / tableIIIa(1.0)) *
        (1 - 1.2 * ((1.0 / 8000) - (1 / tableI(p, t)))) *
        100;
  }

  //  # type: (float, float) -> float
  //     """
  //     Table XIIb gives in dm3 the volume v at 20 °C of pure ethanol contained in 100 kg of a mixture of known alcoholic
  //     strength by volume at the Celsius temperature t. It is assumed that the weighing took place in air whose density
  //     was 1.2 kg/m3, by means of weights characterized by the conventional value of the result of their weighing in air.
  //     :param q: alcoholic strength by volume in %
  //     :type q: float
  //     :param t: temperature in °C, from — 20 °C to + 40 °C
  //     :type t: float
  //     :return: volume v at 20 °C of pure ethanol contained in 100 kg of a mixture, in dm3
  //     :rtype: float
  //     """
  static double tableXIIb(double q, double t) {
    return tableXIIa(tableIVb(q), t);
  }
}

class MustBeDecimalPercentageException implements Exception {}
