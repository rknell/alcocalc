import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/sugar_form.dart';
import '../components/sugar_list.dart';
import '../models/sugar.dart';
import '../repositories/recipe_repository.dart';

class SugarsPage extends ConsumerStatefulWidget {
  const SugarsPage({super.key});

  @override
  ConsumerState<SugarsPage> createState() => _SugarsPageState();
}

class _SugarsPageState extends ConsumerState<SugarsPage> {
  void _addSugar(String name, double specificGravity) async {
    final repository = await ref.read(recipeRepositoryProvider.future);
    final sugar = Sugar.create(
      name: name,
      specificGravity: specificGravity,
    );

    await repository.saveSugar(sugar);
    ref.invalidate(recipeRepositoryProvider);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sugar ingredient added')),
      );
    }
  }

  void _deleteSugar(Sugar sugar) async {
    final repository = await ref.read(recipeRepositoryProvider.future);
    await repository.deleteSugar(sugar.id);
    ref.invalidate(recipeRepositoryProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sugar ingredient deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final repositoryAsync = ref.watch(recipeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugar Ingredients'),
      ),
      body: repositoryAsync.when(
        data: (repository) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SugarForm(onSubmit: _addSugar),
            ),
            const Divider(),
            Expanded(
              child: FutureBuilder<List<Sugar>>(
                future: repository.getSugars(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return SugarList(
                    sugars: snapshot.data!,
                    onDelete: _deleteSugar,
                  );
                },
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
