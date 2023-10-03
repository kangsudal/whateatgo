import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo/riverpod/myState.dart';
import 'package:whateatgo/screen/manual_screen.dart';

import '../model/recipe.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Recipe> items = ref.watch(filteredRecipesProvider);
    final TextEditingController myController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: myController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                border: OutlineInputBorder(),
                labelText: '검색',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                hintText: '두부',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onEditingComplete: () {
                ref
                    .read(filteredRecipesProvider.notifier)
                    .filterList(myController.text);
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index].rcpnm!),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ManualScreen(
                        recipe: items[index],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
