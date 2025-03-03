/// Represents the result of a sugar calculation.
///
/// This class stores information about a sugar addition or modification,
/// including its name, individual weight, and the running total weight
/// after this sugar is added to the mix.
class SugarResult {
  /// The name of the sugar type.
  final String name;

  /// The weight of this specific sugar in the recipe.
  final double weight;

  /// The cumulative weight including this sugar and all previous sugars.
  ///
  /// This running total helps track the progressive weight changes
  /// as different sugars are added to a mixture.
  final double runningWeight;

  /// Creates a new [SugarResult] with the specified parameters.
  ///
  /// [name]: The name of the sugar type.
  /// [weight]: The weight of this specific sugar.
  /// [runningWeight]: The running total weight after adding this sugar.
  SugarResult(
      {required this.name, required this.weight, required this.runningWeight});
}
