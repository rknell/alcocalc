import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/sugar.dart';

Future<List<Sugar>?> showSugarSelector({
  required BuildContext context,
  required List<Sugar> availableSugars,
  required List<Sugar> selectedSugars,
}) async {
  return showDialog<List<Sugar>>(
    context: context,
    builder: (context) => SugarSelectorDialog(
      availableSugars: availableSugars,
      selectedSugars: selectedSugars,
    ),
  );
}

class SugarSelectorDialog extends StatefulWidget {
  final List<Sugar> availableSugars;
  final List<Sugar> selectedSugars;

  const SugarSelectorDialog({
    super.key,
    required this.availableSugars,
    required this.selectedSugars,
  });

  @override
  State<SugarSelectorDialog> createState() => _SugarSelectorDialogState();
}

class _SugarSelectorDialogState extends State<SugarSelectorDialog> {
  late final Map<String, bool> _selectedMap;
  final Map<String, TextEditingController> _percentageControllers = {};

  @override
  void initState() {
    super.initState();
    _selectedMap = {
      for (var sugar in widget.availableSugars)
        sugar.id: widget.selectedSugars.any((s) => s.id == sugar.id),
    };

    for (var sugar in widget.availableSugars) {
      final selected = widget.selectedSugars.firstWhere(
        (s) => s.id == sugar.id,
        orElse: () => sugar,
      );
      _percentageControllers[sugar.id] = TextEditingController(
        text: (selected.percentage * 100).toStringAsFixed(1),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _percentageControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Sugars'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget.availableSugars.map((sugar) {
            return Row(
              children: [
                Checkbox(
                  value: _selectedMap[sugar.id] ?? false,
                  onChanged: (value) {
                    setState(() {
                      _selectedMap[sugar.id] = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sugar.name),
                      Text(
                        'SG: ${sugar.specificGravity.toStringAsFixed(3)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (_selectedMap[sugar.id] ?? false) ...[
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80,
                    child: TextFormField(
                      controller: _percentageControllers[sugar.id],
                      decoration: const InputDecoration(
                        labelText: '%',
                        isDense: true,
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*')),
                      ],
                    ),
                  ),
                ],
              ],
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final selectedSugars = widget.availableSugars
                .where((sugar) => _selectedMap[sugar.id] ?? false)
                .map((sugar) {
              final percentageText =
                  _percentageControllers[sugar.id]?.text ?? '1.0';
              final percentage = double.tryParse(percentageText) ?? 1.0;
              return sugar.copyWith(percentage: percentage / 100);
            }).toList();

            Navigator.of(context).pop(selectedSugars);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
