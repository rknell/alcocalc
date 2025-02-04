import 'package:flutter/material.dart';

class DilutionResultData {
  final double waterToAdd;
  final double finalWeight;
  final double finalABV;
  final double finalTemperature;

  DilutionResultData({
    required this.waterToAdd,
    required this.finalWeight,
    required this.finalABV,
    required this.finalTemperature,
  });
}

class DilutionResult extends StatelessWidget {
  final DilutionResultData data;

  const DilutionResult({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildResultRow(
              'Water to Add',
              '${data.waterToAdd.toStringAsFixed(1)} g',
            ),
            const SizedBox(height: 8),
            _buildResultRow(
              'Final Weight',
              '${data.finalWeight.toStringAsFixed(1)} g',
            ),
            const SizedBox(height: 8),
            _buildResultRow(
              'Final ABV',
              '${data.finalABV.toStringAsFixed(1)}%',
            ),
            const SizedBox(height: 8),
            _buildResultRow(
              'Final Temperature',
              '${data.finalTemperature.toStringAsFixed(1)}°C',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
