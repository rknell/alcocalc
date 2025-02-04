import 'package:alcocalc/tables/brix.dart';
import 'package:flutter/material.dart';

class SugarForm extends StatefulWidget {
  final void Function(String name, double specificGravity) onSubmit;

  const SugarForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<SugarForm> createState() => _SugarFormState();
}

class _SugarFormState extends State<SugarForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _specificGravityController = TextEditingController();
  final _brixController = TextEditingController();
  bool _useBrix = true;

  @override
  void dispose() {
    _nameController.dispose();
    _specificGravityController.dispose();
    _brixController.dispose();
    super.dispose();
  }

  void _onBrixChanged(String value) {
    if (value.isEmpty) {
      _specificGravityController.clear();
      return;
    }
    final brix = double.tryParse(value);
    if (brix != null) {
      final sg = Brix.brixToDensity(brix);
      _specificGravityController.text = sg.toStringAsFixed(4);
    }
  }

  void _onSpecificGravityChanged(String value) {
    if (value.isEmpty) {
      _brixController.clear();
      return;
    }
    final sg = double.tryParse(value);
    if (sg != null) {
      final brix = Brix.densityToBrix(sg);
      _brixController.text = brix.toStringAsFixed(1);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(
      _nameController.text,
      double.parse(_specificGravityController.text),
    );

    _nameController.clear();
    _specificGravityController.clear();
    _brixController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _brixController,
                  enabled: _useBrix,
                  decoration: const InputDecoration(
                    labelText: 'Brix',
                    suffixText: '°Bx',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: _onBrixChanged,
                  validator: _useBrix
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Brix';
                          }
                          final number = double.tryParse(value);
                          if (number == null || number < 0 || number > 100) {
                            return 'Please enter a valid Brix value';
                          }
                          return null;
                        }
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _specificGravityController,
                  enabled: !_useBrix,
                  decoration: const InputDecoration(
                    labelText: 'Specific Gravity',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: _onSpecificGravityChanged,
                  validator: !_useBrix
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter specific gravity';
                          }
                          final number = double.tryParse(value);
                          if (number == null || number <= 0) {
                            return 'Please enter a valid specific gravity';
                          }
                          return null;
                        }
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Use Brix'),
                  value: true,
                  groupValue: _useBrix,
                  onChanged: (value) {
                    setState(() {
                      _useBrix = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Use SG'),
                  value: false,
                  groupValue: _useBrix,
                  onChanged: (value) {
                    setState(() {
                      _useBrix = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Add Sugar Ingredient'),
          ),
        ],
      ),
    );
  }
}
