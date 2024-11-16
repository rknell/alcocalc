double findRoot(
  double Function(double x) func,
  double lowBracket,
  double highBracket, {
  int iterations = 0,
  int maxIterations = 50,
  bool isInverse = false,
  double precision = 0.00001,
}) {
  //Determine direction
  if (iterations == 0) {
    final guessOneThird =
        func(highBracket - ((highBracket - lowBracket).abs() * 0.3));
    final guessTwoThird =
        func(highBracket - ((highBracket - lowBracket).abs() * 0.6));
    isInverse = guessOneThird < guessTwoThird;
  }

  final guess = highBracket - ((highBracket - lowBracket).abs() / 2);
  final result = func(guess);
  // print("$guess - $result");
  if (iterations == maxIterations) {
    throw "Did not converge";
  } else if (result <= precision && result > precision * -1) {
    return guess;
  } else if ((isInverse == true && result < 0) ||
      (isInverse == false && result > 0)) {
    return findRoot(
      func,
      lowBracket,
      guess,
      iterations: iterations + 1,
      maxIterations: maxIterations,
      isInverse: isInverse,
      precision: precision,
    );
  } else {
    return findRoot(
      func,
      guess,
      highBracket,
      iterations: iterations + 1,
      maxIterations: maxIterations,
      isInverse: isInverse,
      precision: precision,
    );
  }
}

extension RoundDouble on double {
  double roundTo2Places() {
    return double.parse(this.toStringAsFixed(2));
  }

  double roundToXPlaces(int places) {
    return double.parse(this.toStringAsFixed(places));
  }
}
