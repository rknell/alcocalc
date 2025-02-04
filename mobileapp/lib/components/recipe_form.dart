import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/sugar.dart';
import 'sugar_selector.dart';

class RecipeFormData {
  final String name;
  final double targetABV;
  final List<Sugar> selectedSugars;

  RecipeFormData({
    required this.name,
    required this.targetABV,
    required this.selectedSugars,
  });
}

class RecipeForm extends StatefulWidget {
  final List<Sugar> availableSugars;
  final void Function(RecipeFormData) onSubmit;

  const RecipeForm({
    super.key,
    required this.availableSugars,
    required this.onSubmit,
  });

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _targetABVController = TextEditingController();
  List<Sugar> _selectedSugars = [];

  @override
  void dispose() {
    _nameController.dispose();
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
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Recipe Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
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
                return 'Please enter a target ABV';
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
                          'Specific Gravity: ${_selectedSugars[index].specificGravity.toStringAsFixed(3)}',
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
                  RecipeFormData(
                    name: _nameController.text,
                    targetABV: double.parse(_targetABVController.text),
                    selectedSugars: _selectedSugars,
                  ),
                );
              }
            },
            child: const Text('Save Recipe'),
          ),
        ],
      ),
    );
  }
}
