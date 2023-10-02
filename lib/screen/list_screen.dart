import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo/riverpod/myState.dart';
import 'package:whateatgo/screen/manual_screen.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(allRecipesProvider);
    return Scaffold(
      body: ListView.separated(
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
    );
  }
}
