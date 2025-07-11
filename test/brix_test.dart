import 'package:alcocalc/helpers.dart';
import 'package:alcocalc/tables/brix.dart';
import 'package:test/test.dart';

void main() {
  test('it should calculate brix', () {
    expect(Brix.densityToBrix(1.17874).roundTo2Places(), 40.00);
    expect(Brix.brixToDensity(40.00).roundToXPlaces(5), 1.17874);
  });
}
