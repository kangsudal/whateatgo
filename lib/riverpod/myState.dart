import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shake/shake.dart';

import '../model/recipe.dart';

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

//3. 홈 화면에 후보군 리스트(초기값은 모든 리스트)
final homeScreenRecipesProvider = StateProvider((ref) =>
    Hive.box('recipeBox').values.map((item) => Recipe.fromJson(item)).toList());

//4. 리스트 화면에 후보군 리스트(초기값은 모든 리스트)
//검색 필터를 적용한 리스트 Provider
//사용자가 화면상에서 떠나고 다시 진입했을 때 상태를 초기화 할 경우 autoDispose를 사용한다.
final listScreenRecipesProvider =
    StateNotifierProvider.autoDispose<FilteredRecipeListNotifier, List<Recipe>>(
  (ref) => FilteredRecipeListNotifier(),
);

class FilteredRecipeListNotifier extends StateNotifier<List<Recipe>> {
  FilteredRecipeListNotifier()
      : super(Hive.box('recipeBox')
            .values
            .map((item) => Recipe.fromJson(item))
            .toList());

  //필터할 대상(부모 리스트)
  void setDefaultList() {
    state = Hive.box('recipeBox')
        .values
        .map((item) => Recipe.fromJson(item))
        .toList();
  }

  List<Recipe> normalFilterList(String keyword) {
    //검색어를 포함하고있는 레시피 리스트
    List<Recipe> filtered;
    filtered = Hive.box('recipeBox')
        .values
        .map((item) => Recipe.fromJson(item))
        .toList()
        .where((element) =>
            (element.rcpnm!.contains(keyword)) || //메뉴명
            (element.rcppat2!.contains(keyword)) || //요리종류
            (element.hashtag!.contains(keyword)) || //해쉬태그
            (element.rcppartsdtls!.contains(keyword))) //재료정보
        .toList();
    state = filtered;
    return filtered;
  }

  List<Recipe> filterInFilteredResult(String keyword) {
    //검색어를 포함하고있는 레시피 리스트
    List<Recipe> filtered;
    filtered = state
        .where((element) =>
            (element.rcpnm!.contains(keyword)) || //메뉴명
            (element.rcppat2!.contains(keyword)) || //요리종류
            (element.hashtag!.contains(keyword)) || //해쉬태그
            (element.rcppartsdtls!.contains(keyword))) //재료정보
        .toList();
    state = filtered;
    return filtered;
  }
}
