import 'package:alcocalc/tables/oiml.dart';
import 'package:test/test.dart';


main() {
  //   Table I gives the density of a mixture as a function of the temperature in °C, from — 20 °C to + 40 °C, and of the
  //   alcoholic strength by mass from the minimum permissible value and 100%, this minimum value corresponding to the
  //   freezing of the mixture for the temperature considered.
  // ABW @ Temp > Density
  test('table I', () {
    expect(OIMLTables.tableI(.3, -20).roundTo2Places(), 974.91);
    expect(OIMLTables.tableI(.1, 0).roundTo2Places(), 984.75);
    expect(OIMLTables.tableI(1, 0).roundTo2Places(), 806.22);
    expect(OIMLTables.tableI(.5, 20).roundTo2Places(), 913.77);
  });

  // Table II gives the density of a mixture as a function of the temperature varying from — 20 °C to + 40 °C
  // and of the alcoholic strength by volume varying between the minimum permissible value and 100 %.
  // ABV @ Temp > Density
  test('table II', () {
    expect(OIMLTables.tableII(.36, -20).roundTo2Places(), 975.08);
    expect(OIMLTables.tableII(.10, 0).roundTo2Places(), 987.12);
    expect(OIMLTables.tableII(1, -0).roundTo2Places(), 806.22);
    expect(OIMLTables.tableII(.5, 20).roundTo2Places(), 930.14);
  });

  //   Table IIIa gives the density at 20 °C as a function of the alcoholic strength by mass varying between 0 % and
  //   100 %.
  // ABW > Density
  test('table IIIa', () {
    expect(OIMLTables.tableIIIa(.2).roundTo2Places(), 968.61);
    expect(OIMLTables.tableIIIa(.5).roundTo2Places(), 913.77);
  });

  //   Table IIIb gives the alcoholic strength by volume as a function of the alcoholic strength by mass varying between
  //   0 % and 100 %.
  // ABW > ABV @ 20d
  test('table IIIb', () {
    expect(OIMLTables.tableIIIb(0).roundToXPlaces(4), 0);
    expect(OIMLTables.tableIIIb(.1).roundToXPlaces(4), .1244);
    expect(OIMLTables.tableIIIb(.3).roundToXPlaces(4), .3625);
    expect(OIMLTables.tableIIIb(.5).roundToXPlaces(4), .5789);
    expect(OIMLTables.tableIIIb(.7).roundToXPlaces(4), .7695);
    expect(OIMLTables.tableIIIb(1).roundToXPlaces(4), 1);
  });

  //   Table IVa gives the density at 20 °C as a function of the alcoholic strength by volume varying between 0 and 100 %.
  // ABV @ 20d > Density
  test('table IVa', () {
    expect(OIMLTables.tableIVa(.2).roundTo2Places(), 973.56);
    expect(OIMLTables.tableIVa(.5).roundTo2Places(), 930.14);
  });

  //   Table IVb gives the alcoholic strength by mass as a function of the alcoholic strength by volume varying between
  //   0 and 100 %.
  // ABV > ABW
  test('Table IVb', () {
    expect(OIMLTables.tableIVb(.3).roundToXPlaces(4), .2461);
    expect(OIMLTables.tableIVb(.1).roundToXPlaces(4), .0801);
    expect(OIMLTables.tableIVb(.5).roundToXPlaces(4), .4243);
    expect(OIMLTables.tableIVb(.7).roundToXPlaces(4), .6239);
  });

  //   Table Va gives the alcoholic strength by mass as a function of the density at 20 °C varying between 789.3 kg/m3 and
  //   998.2 kg/m3.
  // Density @ 20d > ABW
  test('table Va', () {
    expect(OIMLTables.tableVa(790).roundToXPlaces(4), .9976);
    expect(OIMLTables.tableVa(800).roundToXPlaces(4), .9644);
    expect(OIMLTables.tableVa(900).roundToXPlaces(4), .5612);
    expect(OIMLTables.tableVa(950).roundToXPlaces(4), .3220);
    expect(OIMLTables.tableVa(970).roundToXPlaces(4), .1895);
    expect(OIMLTables.tableVa(990).roundToXPlaces(4), .0462);
  });

  //     Table Vb gives the alcoholic strength by volume as a function of the density at 20 °C varying between 789.3 kg/m3
  //     and 998.2 kg/m3.
  // Density @ 20d > ABV
  test('table Vb', () {
    expect(OIMLTables.tableVb(790).roundToXPlaces(4), .9985);
    expect(OIMLTables.tableVb(800).roundToXPlaces(4), .9775);
    expect(OIMLTables.tableVb(900).roundToXPlaces(4), .6400);
    expect(OIMLTables.tableVb(950).roundToXPlaces(4), .3876);
    expect(OIMLTables.tableVb(970).roundToXPlaces(4), .2329);
    expect(OIMLTables.tableVb(990).roundToXPlaces(4), .0579);
  });

  //   Table VI gives the value of the alcoholic strength by mass of a mixture as a function of its Celsius temperature t
  //   and of its density at this temperature.
  // Density @ Temp > ABW
  test('table VI', () {
    expect(OIMLTables.tableVI(974.91, -20.0).roundToXPlaces(4), .3);
    expect(OIMLTables.tableVI(984.75, 0).roundToXPlaces(4), .1);
    expect(OIMLTables.tableVI(806.22, 0).roundToXPlaces(4), 1);
    expect(OIMLTables.tableVI(913.77, 20.0).roundToXPlaces(4), .5);
  });

  //     Table VII gives the alcoholic strength by volume of a mixture as a function of its Celsius temperature t and of its
  //     density at the same temperature.
  // Density @ Temp > ABV
  test('table VII', () {
    expect(OIMLTables.tableVII(974.91, -20.0).roundToXPlaces(4),
        OIMLTables.tableIIIb(.3).roundToXPlaces(4));
    expect(OIMLTables.tableVII(984.75, 0).roundToXPlaces(4),
        OIMLTables.tableIIIb(.1).roundToXPlaces(4));
    expect(OIMLTables.tableVII(806.22, 0).roundToXPlaces(4),
        OIMLTables.tableIIIb(1).roundToXPlaces(4));
    expect(OIMLTables.tableVII(913.77, 20.0).roundToXPlaces(4),
        OIMLTables.tableIIIb(.5).roundToXPlaces(4));
  });

  // Table VIIIa gives the value of the alcoholic strength by mass of a mixture at the Celsius temperature t from the
  // reading of an alcohometer made of soda lime glass, graduated in units of alcoholic strength by mass (% mass).
  // ABW @ Temp > ABW
  test('table VIIIa', () {
    expect(OIMLTables.tableVIIIa(.175, -10).roundToXPlaces(3), .276);
    expect(OIMLTables.tableVIIIa(.68, 0).roundToXPlaces(3), .748);
    expect(OIMLTables.tableVIIIa(.57, 6).roundToXPlaces(3), .618);
    expect(OIMLTables.tableVIIIa(.015, 12).roundToXPlaces(3), .021);
    expect(OIMLTables.tableVIIIa(.67, 35).roundToXPlaces(3), .617);
  });

  //     Table VIIIb gives the value of the alcoholic strength by volume of a mixture at the Celsius temperature t from the
  //     reading of an alcohometer made of soda lime glass, graduated in units of alcoholic strength by volume (% vol).
  // ABV @ Temp > ABV
  test('table VIIIb', () {
    expect(OIMLTables.tableVIIIb(.175, -10).roundToXPlaces(3), .26);
    expect(OIMLTables.tableVIIIb(.68, 0).roundToXPlaces(3), .743);
    expect(OIMLTables.tableVIIIb(.57, 6).roundToXPlaces(3), .619);
    expect(OIMLTables.tableVIIIb(.015, 12).roundToXPlaces(3), .022);
    expect(OIMLTables.tableVIIIb(.67, 35).roundToXPlaces(3), .618);
  });

  //     Table IXa gives the value of the alcoholic strength by mass of a mixture at the Celsius temperature t from the
  //     reading of a hydrometer for alcohol in soda lime glass.
  // Density @ Temp > ABW
  test('table IXa', () {
    expect(OIMLTables.tableIXa(800, 20).roundToXPlaces(4), .9644);
    expect(OIMLTables.tableIXa(800, 10).roundToXPlaces(4), .9922);
    expect(OIMLTables.tableIXa(900, 10).roundToXPlaces(4), .5957);
    expect(OIMLTables.tableIXa(900, 0).roundToXPlaces(4), .6296);
  });

  //     Table IXb gives respectively the value of the alcoholic strength by volume of a mixture at the Celsius temperature
  //     t from the reading of a hydrometer for alcohol in soda lime glass.
  // Density @ Temp > ABV
  test('table IXb', () {
    expect(OIMLTables.tableIXb(900, 0).roundToXPlaces(4), .7053);
  });

  //   Tables Xa gives the value of the alcoholic strength by mass of a mixture at the Celsius temperature t from the
  //   measurement of the density of this mixture by means of an instrument made of borosilicate glass.
  // Density @ Temp > ABW
  test('table Xa', () {
    expect(OIMLTables.tableXa(800, 20).roundToXPlaces(4), .9644);
    expect(OIMLTables.tableXa(800, 10).roundToXPlaces(4), .9922);
    expect(OIMLTables.tableXa(900, 10).roundToXPlaces(4), .5957);
    expect(OIMLTables.tableXa(900, 0).roundToXPlaces(4), .6296);
  });

  //     Tables Xb gives respectively the value of the alcoholic strength by volume of a mixture at the Celsius temperature
  //     t from the measurement of the density of this mixture by means of an instrument made of borosilicate glass.
  // Density @ Temp > ABV
  test('table Xb', () {
    expect(OIMLTables.tableXb(800, 20).roundToXPlaces(4), .9775);
    expect(OIMLTables.tableXb(800, 10).roundToXPlaces(4), .9953);
    expect(OIMLTables.tableXb(900, 10).roundToXPlaces(4), .6733);
    expect(OIMLTables.tableXb(900, 0).roundToXPlaces(4), .7053);
  });

  //     Table XIa gives in dm3 the volume v at 20 °C of pure ethanol contained in 100 dm3 of a mixture of known alcoholic
  //     strength by mass at the Celsius temperature t, assuming that the volume of 100 dm3 was measured by a container in
  //     steel calibrated at 20 °C.
  // ???
  test('table XIa', () {
    expect(OIMLTables.tableXIa(0, 0), 0);
    expect(OIMLTables.tableXIa(1, 20), 100);
  });

  //     Tables XIb gives in dm3 the volume v at 20 °C of pure ethanol contained in 100 dm3 of a mixture of known alcoholic
  //     strength by volume at the Celsius temperature t, assuming that the volume of 100 dm3 was measured by a container
  //     in steel calibrated at 20 °C.
  //  > Weight of Alcohol (isn't this just ABW * 100?)
  test('table XIb', () {
    expect(OIMLTables.tableXIb(0, 0).roundToXPlaces(1), 0);
    expect(OIMLTables.tableXIb(0.1, 20).roundToXPlaces(1), 10);
    expect(OIMLTables.tableXIb(0.2, 20).roundToXPlaces(1), 20);
    expect(OIMLTables.tableXIb(0.3, 20).roundToXPlaces(1), 30);
    expect(OIMLTables.tableXIb(0.4, 20).roundToXPlaces(1), 40);
    expect(OIMLTables.tableXIb(0.5, 20).roundToXPlaces(1), 50);
    expect(OIMLTables.tableXIb(0.6, 20).roundToXPlaces(1), 60);
    expect(OIMLTables.tableXIb(0.7, 20).roundToXPlaces(1), 70);
    expect(OIMLTables.tableXIb(0.8, 20).roundToXPlaces(1), 80);
    expect(OIMLTables.tableXIb(0.9, 20).roundToXPlaces(1), 90);
    expect(OIMLTables.tableXIb(1, 20).roundToXPlaces(1), 100);
  });

  test('table XIIa', () {
    expect(OIMLTables.tableXIIa(0, 0).roundToXPlaces(1), 0);
    expect(OIMLTables.tableXIIa(1, 20).roundToXPlaces(1), 126.9);
  });

  test('table XIIb', () {
    expect(OIMLTables.tableXIIb(0, 0).roundToXPlaces(1), 0);
    expect(OIMLTables.tableXIIb(1, 20).roundToXPlaces(1), 126.9);
  });

  test('root finder', () {
    expect(findRoot((x) => x + 5, -10, 10).roundTo2Places(), -5);
    expect(findRoot((x) => x + 1, -10, 20, maxIterations: 20).roundTo2Places(),
        -1);
  });
}
