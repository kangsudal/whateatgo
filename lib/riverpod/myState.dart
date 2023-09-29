import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/recipe.dart';

//흔들었을때,refresh 버튼을 눌렀을때 random 인덱스값
final diceNumberProvider = StateNotifierProvider(
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

//처음 전체 레시피 데이터를 로드했을때 담을 리스트 글로벌 변수 역할
final allRecipes = StateNotifierProvider<RecipeListNotifier, List<Recipe>>(
  (ref) => RecipeListNotifier(),
);

class RecipeListNotifier extends StateNotifier<List<Recipe>> {
  RecipeListNotifier() : super([]);

  void loadRecipeList(List<Recipe> list) {
    state = list;
  }

  List<Recipe> filteredList(String keyword) {
    //검색어를 포함하고있는 레시피 리스트
    List<Recipe> filtered;
    filtered = state
        .where((element) =>
            (element.rcpnm!.contains(keyword)) || //메뉴명
            (element.rcppat2!.contains(keyword)) || //요리종류
            (element.hashtag!.contains(keyword)) || //해쉬태그
            (element.rcppartsdtls!.contains(keyword))) //재료정보
        .toList();

    return filtered;
  }
}
