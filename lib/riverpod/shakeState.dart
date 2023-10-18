import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';
import 'package:whateatgo2/riverpod/homeScreenState.dart';

//1. 흔들었을때,refresh 버튼을 눌렀을때 random 인덱스값
final diceNumberProvider = StateNotifierProvider<DiceNumberNotifier, int>(
  (ref) {
    final homeScreenRecipes = ref.watch(homeScreenRecipesProvider);
    return DiceNumberNotifier(length: homeScreenRecipes.length);
  },
);

class DiceNumberNotifier extends StateNotifier<int> {
  DiceNumberNotifier({required this.length}) : super(-1);

  int length;

  //주사위를 굴립니다.
  void roll() {
    debugPrint('0~$length개 요리');
    state = Random().nextInt(length); // 시작은 -1 , 0~1114
    debugPrint('$state번째 요리');
  }
}

//2. ShakeDetector Provider
final shakeDetectorProvider = StateProvider(
  (ref) => ShakeDetector.waitForStart(
    shakeThresholdGravity: 2,
    onPhoneShake: () {
      ref.read(diceNumberProvider.notifier).roll();
    },
  ),
);
