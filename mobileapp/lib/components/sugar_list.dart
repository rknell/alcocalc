import 'package:alcocalc/tables/brix.dart';
import 'package:flutter/material.dart';
import '../models/sugar.dart';

class SugarList extends StatelessWidget {
  final List<Sugar> sugars;
  final void Function(Sugar sugar) onDelete;

  const SugarList({
    super.key,
    required this.sugars,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (sugars.isEmpty) {
      return const Center(child: Text('No sugar ingredients added yet'));
    }

    return ListView.builder(
      itemCount: sugars.length,
      itemBuilder: (context, index) {
        final sugar = sugars[index];
        final brix = Brix.densityToBrix(sugar.specificGravity);
        return ListTile(
          title: Text(sugar.name),
          subtitle: Text(
              'Specific Gravity: ${sugar.specificGravity.toStringAsFixed(4)}\n'
              'Brix: ${brix.toStringAsFixed(1)}°Bx'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(sugar),
          ),
        );
      },
    );
  }
}
