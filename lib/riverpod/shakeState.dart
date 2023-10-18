import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';

//1. 흔들었을때,refresh 버튼을 눌렀을때 random 인덱스값
final diceNumberProvider = StateNotifierProvider<DiceNumberNotifier, int>(
  (ref) => DiceNumberNotifier(),
);

class DiceNumberNotifier extends StateNotifier<int> {
  DiceNumberNotifier() : super(-1);

  //주사위를 굴립니다.
  void roll() {
    state = Random().nextInt(1115); // 시작은 -1 , 0~1114
    print(state);
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
