/// Represents a sugar type used in brewing or distilling calculations.
///
/// This class stores information about different types of sugars, including their
/// specific gravity, percentage, and weight. It also provides a calculated property
/// for the equivalent water weight.
class Sugars {
  /// The name of the sugar type (e.g., "Dextrose", "Sucrose", "Honey").
  final String name;

  /// The specific gravity of the sugar relative to water.
  ///
  /// This value is used to calculate volume displacement and other physical properties.
  final double specificGravity;

  /// The percentage of the sugar in decimal form (e.g., 0.05 for 5%).
  ///
  /// This value must be less than 1.0 as it represents a fraction of the total.
  final double percentage;

  /// The weight of the sugar in the same unit system as other weights in the calculation.
  ///
  /// This value is typically set after the Sugars object is created.
  double weight = 0;

  /// The equivalent weight of water that would occupy the same volume as this sugar.
  ///
  /// Calculated by dividing the sugar's weight by its specific gravity.
  double get equivalentWaterWeight => weight / specificGravity;

  /// Creates a new [Sugars] instance with the specified parameters.
  ///
  /// [name]: The name of the sugar type.
  /// [specificGravity]: The specific gravity of the sugar relative to water.
  /// [percentage]: The percentage of the sugar as a decimal (must be less than 1.0).
  ///
  /// Throws an [AssertionError] if the percentage is not a decimal (≥ 1.0).
  Sugars(
      {required this.name,
      required this.specificGravity,
      required this.percentage})
      : assert(percentage < 1, "Percentage much be a decimal");
}
