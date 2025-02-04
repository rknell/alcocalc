double findRoot(
  double Function(double x) func,
  double lowBracket,
  double highBracket, {
  int iterations = 0,
  int maxIterations = 50,
  bool isInverse = false,
  double precision = 0.00001,
}) {
  // Determine direction on first iteration only
  if (iterations == 0) {
    final guessOneThird =
        func(highBracket - ((highBracket - lowBracket).abs() * 0.3));
    final guessTwoThird =
        func(highBracket - ((highBracket - lowBracket).abs() * 0.6));
    isInverse = guessOneThird < guessTwoThird;
  }

  // Calculate midpoint
  final guess = lowBracket + ((highBracket - lowBracket) / 2);
  final result = func(guess);

  // Check for convergence or max iterations
  if (iterations == maxIterations) {
    throw "Did not converge";
  } else if (result.abs() <= precision) {
    return guess;
  }

  // Determine which half to recurse on based on result and isInverse
  if ((isInverse && result < 0) || (!isInverse && result > 0)) {
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
    return double.parse(toStringAsFixed(2));
  }

  double roundToXPlaces(int places) {
    return double.parse(toStringAsFixed(places));
  }
}
