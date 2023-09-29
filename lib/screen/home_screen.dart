import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo/riverpod/myState.dart';

import '../model/recipe.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int diceNumber = ref.watch(diceNumberProvider);
    final List<Recipe> allRecipes = ref.watch(allRecipesProvider);
    return Scaffold(
      body: Center(
        child: diceNumber == -1
            ? const Text('흔들어주세요!')
            : Text('${allRecipes.elementAt(diceNumber).rcpnm}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(diceNumberProvider.notifier).roll();
        },
      ),
    );
  }
}
