import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo2/riverpod/homeScreenState.dart';
import 'package:whateatgo2/riverpod/shakeState.dart';
import 'package:whateatgo2/screen/list_screen.dart';
import 'package:whateatgo2/screen/manual_screen.dart';

import 'package:whateatgo2/model/recipe.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int diceNumber = ref.watch(diceNumberProvider);
    final List<Recipe> recipeList = ref.watch(homeScreenRecipesProvider);
    final Recipe? currentRecipe =
        diceNumber == -1 ? null : recipeList.elementAt(diceNumber);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
        appBar: AppBar(),
        endDrawer: Drawer(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ListTile(
                title: const Text(
                  '전체',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ListScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  '관심 항목',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              const BuymeacoffeeWidget(),
            ],
          ),
        ),
        body: currentRecipe == null
            ? Center(
                child: Text(
                  '흔들어주세요!',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              )
            : ContentWidget(currentRecipe: currentRecipe),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Colors.black,
          child: const Icon(Icons.refresh),
          onPressed: () {
            ref.read(diceNumberProvider.notifier).roll();
          },
        ),
      ),
    );
  }
}

class BuymeacoffeeWidget extends StatelessWidget {
  const BuymeacoffeeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: ListTile(
          title: const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.coffee,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Buy me a coffee',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.currentRecipe,
  });

  final Recipe? currentRecipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Expanded(
            child: TopWidget(currentRecipe: currentRecipe),
          ),
          BottomButtonsWidget(currentRecipe: currentRecipe),
        ],
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({
    super.key,
    required this.currentRecipe,
  });

  final Recipe? currentRecipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            currentRecipe!.attfilenomain!,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) {
                return Stack(
                  children: [
                    child,
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
              return SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        Text(
          currentRecipe!.rcpnm!,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.black,
                // fontFamily: 'BlackHanSans',
              ),
        ),
      ],
    );
  }
}

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({
    super.key,
    required this.currentRecipe,
  });

  final Recipe? currentRecipe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            side: const BorderSide(
              color: Colors.black,
              width: 2.5,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ManualScreen(recipe: currentRecipe!);
                },
              ),
            );
          },
          child: const Text('Recipe'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Restaurant'),
        ),
      ],
    );
  }
}
