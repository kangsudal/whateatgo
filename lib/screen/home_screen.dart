import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo/riverpod/myState.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diceNumber = ref.watch(diceNumberProvider);
    return Scaffold(
      body: Center(
        child: Text('$diceNumber'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(diceNumberProvider.notifier).state++;
        },
      ),
    );
  }
}
