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
    final Recipe? currentRecipe =
        diceNumber == -1 ? null : allRecipes.elementAt(diceNumber);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 196, 112, 1),
      appBar: AppBar(),
      body: currentRecipe == null
          ? const Center(
              child: Text(
                '흔들어주세요!',
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            currentRecipe.attfilenomk!,
                            loadingBuilder: (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          currentRecipe.rcpnm!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color: Colors.black,
                                fontFamily: 'BlackHanSans',
                              ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: BorderSide(
                            color: Colors.black,
                            width: 2.5,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('레시피보기'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('식당찾기'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.black,
        child: const Icon(Icons.refresh),
        onPressed: () {
          ref.read(diceNumberProvider.notifier).roll();
        },
      ),
    );
  }
}
