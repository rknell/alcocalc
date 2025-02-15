/// A library for calculating alcohol dilutions and proofing spirits.
///
/// This library provides tools for:
/// * Diluting spirits to target ABV
/// * Converting between ABV and ABW
/// * Temperature correction for alcohol measurements
/// * Calculating sugar additions for liqueurs
/// * Adding high-proof alcohol to increase ABV
library alcocalc;

export 'functions.dart'
    show
        AlcocalcFunctions,
        DilutionResult,
        Sugars,
        AlcoholAdditionResult,
        dilution,
        diluteToVolume,
        diluteToBottles,
        calculateAlcoholAddition;
