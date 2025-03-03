/// A library for calculating alcohol dilutions and proofing spirits.
///
/// This library provides tools for:
/// * Diluting spirits to target ABV
/// * Converting between ABV and ABW
/// * Temperature correction for alcohol measurements
/// * Calculating sugar additions for liqueurs
/// * Adding high-proof alcohol to increase ABV
library alcocalc;

export 'classes/alcohol_addition_result.dart';
export 'classes/dilution_result.dart';
export 'classes/sugar_result.dart';
export 'classes/sugars.dart';
export 'functions.dart';
export 'tables/brix.dart';
export 'tables/oiml.dart';
