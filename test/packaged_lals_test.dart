import 'package:alcocalc/alcocalc.dart';
import 'package:test/test.dart';

void main() {
  test('calculates packaged litres of alcohol from litres and fractional ABV',
      () {
    expect(
      Alcocalc.packagedLitresOfAlcohol(
        containerSizeLitres: 0.7,
        abv: 0.4,
        quantity: 6,
      ),
      closeTo(1.68, 0.000001),
    );
  });

  test('rejects invalid packaged alcohol inputs', () {
    expect(
      Alcocalc.packagedLitresOfAlcohol(
        containerSizeLitres: 0.7,
        abv: 40,
        quantity: 6,
      ),
      0,
    );
  });
}
