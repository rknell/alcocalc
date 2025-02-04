import 'package:alcocalc/functions.dart' as alcocalc;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/dilution_form.dart';
import '../components/dilution_result.dart';
import '../models/recipe.dart';
import '../models/sugar.dart';
import '../repositories/recipe_repository.dart';

class CalculatorPage extends ConsumerStatefulWidget {
  final Recipe? recipe;

  const CalculatorPage({super.key, this.recipe});

  @override
  ConsumerState<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends ConsumerState<CalculatorPage> {
  DilutionResultData? _result;

  @override
  Widget build(BuildContext context) {
    final repositoryAsync = ref.watch(recipeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe?.name ?? 'Calculator'),
      ),
      body: repositoryAsync.when(
        data: (repository) => FutureBuilder<List<Sugar>>(
          future: repository.getSugars(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DilutionForm(
                    availableSugars: snapshot.data!,
                    initialData: widget.recipe != null
                        ? DilutionFormData(
                            startingABV: 0.0,
                            startingTemperature: 20.0,
                            startingWeight: 0.0,
                            targetABV: widget.recipe!.targetABV,
                            selectedSugars: widget.recipe!.sugars,
                          )
                        : null,
                    onSubmit: (data) {
                      final result = alcocalc.dilution(
                        startingABV: data.startingABV,
                        startingTemperature: data.startingTemperature,
                        startingWeight: data.startingWeight,
                        targetABV: data.targetABV,
                        sugars: data.selectedSugars
                            .map((s) => alcocalc.Sugars(
                                  name: s.name,
                                  specificGravity: s.specificGravity,
                                  percentage: s.percentage,
                                ))
                            .toList(),
                      );

                      setState(() {
                        _result = DilutionResultData(
                          waterToAdd: result.additionalWaterLitres * 1000,
                          finalWeight: result.targetWeightAfterWater * 1000,
                          finalABV: data.targetABV,
                          finalTemperature: data.startingTemperature,
                        );
                      });
                    },
                  ),
                  if (_result != null) ...[
                    const SizedBox(height: 24),
                    DilutionResult(data: _result!),
                  ],
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
