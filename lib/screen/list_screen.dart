import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo/riverpod/myState.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(allRecipesProvider);
    return Scaffold(
      body: ListView.builder(
        itemCount: state.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(state[index].rcpnm!);
        },
      ),
    );
  }
}
