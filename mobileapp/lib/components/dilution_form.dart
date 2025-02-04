import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/sugar.dart';
import 'sugar_selector.dart';

class DilutionFormData {
  final double startingABV;
  final double startingTemperature;
  final double startingWeight;
  final double targetABV;
  final List<Sugar> selectedSugars;

  DilutionFormData({
    required this.startingABV,
    required this.startingTemperature,
    required this.startingWeight,
    required this.targetABV,
    required this.selectedSugars,
  });
}

class DilutionForm extends StatefulWidget {
  final List<Sugar> availableSugars;
  final DilutionFormData? initialData;
  final void Function(DilutionFormData) onSubmit;

  const DilutionForm({
    super.key,
    required this.availableSugars,
    required this.onSubmit,
    this.initialData,
  });

  @override
  State<DilutionForm> createState() => _DilutionFormState();
}

class _DilutionFormState extends State<DilutionForm> {
  final _formKey = GlobalKey<FormState>();
  final _startingABVController = TextEditingController();
  final _startingTemperatureController = TextEditingController();
  final _startingWeightController = TextEditingController();
  final _targetABVController = TextEditingController();
  List<Sugar> _selectedSugars = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _startingABVController.text = widget.initialData!.startingABV.toString();
      _startingTemperatureController.text =
          widget.initialData!.startingTemperature.toString();
      _startingWeightController.text =
          widget.initialData!.startingWeight.toString();
      _targetABVController.text = widget.initialData!.targetABV.toString();
      _selectedSugars = List.from(widget.initialData!.selectedSugars);
    }
  }

  @override
  void dispose() {
    _startingABVController.dispose();
    _startingTemperatureController.dispose();
    _startingWeightController.dispose();
    _targetABVController.dispose();
    super.dispose();
  }

  void _selectSugars() async {
    final result = await showSugarSelector(
      context: context,
      availableSugars: widget.availableSugars,
      selectedSugars: _selectedSugars,
    );

    if (result != null) {
      setState(() {
        _selectedSugars = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _startingABVController,
            decoration: const InputDecoration(
              labelText: 'Starting ABV (%)',
              border: OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter starting ABV';
              }
              final abv = double.tryParse(value);
              if (abv == null || abv <= 0 || abv >= 100) {
                return 'Please enter a valid ABV between 0 and 100';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _startingTemperatureController,
            decoration: const InputDecoration(
              labelText: 'Starting Temperature (°C)',
              border: OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter starting temperature';
              }
              final temp = double.tryParse(value);
              if (temp == null || temp < -50 || temp > 100) {
                return 'Please enter a valid temperature between -50 and 100';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _startingWeightController,
            decoration: const InputDecoration(
              labelText: 'Starting Weight (g)',
              border: OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter starting weight';
              }
              final weight = double.tryParse(value);
              if (weight == null || weight <= 0) {
                return 'Please enter a valid weight greater than 0';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _targetABVController,
            decoration: const InputDecoration(
              labelText: 'Target ABV (%)',
              border: OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter target ABV';
              }
              final abv = double.tryParse(value);
              if (abv == null || abv <= 0 || abv >= 100) {
                return 'Please enter a valid ABV between 0 and 100';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _selectSugars,
            icon: const Icon(Icons.add),
            label: const Text('Select Sugars'),
          ),
          if (_selectedSugars.isNotEmpty) ...[
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Sugars:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(
                      _selectedSugars.length,
                      (index) => ListTile(
                        dense: true,
                        title: Text(_selectedSugars[index].name),
                        subtitle: Text(
                          'SG: ${_selectedSugars[index].specificGravity.toStringAsFixed(3)}, '
                          'Percentage: ${(_selectedSugars[index].percentage * 100).toStringAsFixed(1)}%',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              _selectedSugars.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_selectedSugars.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one sugar'),
                    ),
                  );
                  return;
                }

                widget.onSubmit(
                  DilutionFormData(
                    startingABV: double.parse(_startingABVController.text),
                    startingTemperature:
                        double.parse(_startingTemperatureController.text),
                    startingWeight:
                        double.parse(_startingWeightController.text),
                    targetABV: double.parse(_targetABVController.text),
                    selectedSugars: _selectedSugars,
                  ),
                );
              }
            },
            child: const Text('Calculate'),
          ),
        ],
      ),
    );
  }
}
