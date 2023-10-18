import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/recipe.dart';

//1. 홈 화면에 후보군 리스트(초기값은 모든 리스트)
final homeScreenRecipesProvider =
    StateProvider((ref) => Hive.box<Recipe>('recipeBox').values.toList());

//2. 리스트 화면에 후보군 리스트(초기값은 모든 리스트)
//검색 필터를 적용한 리스트 Provider
//사용자가 화면상에서 떠나고 다시 진입했을 때 상태를 초기화 할 경우 autoDispose를 사용한다.
final listScreenRecipesProvider =
    StateNotifierProvider.autoDispose<FilteredRecipeListNotifier, List<Recipe>>(
  (ref) => FilteredRecipeListNotifier(),
);

class FilteredRecipeListNotifier extends StateNotifier<List<Recipe>> {
  FilteredRecipeListNotifier()
      : super(Hive.box<Recipe>('recipeBox').values.toList());

  //필터할 대상(부모 리스트)
  void setDefaultList() {
    state = Hive.box<Recipe>('recipeBox').values.toList();
  }

  List<Recipe> normalFilterList(String keyword) {
    //검색어를 포함하고있는 레시피 리스트
    List<Recipe> filtered;
    filtered = Hive.box<Recipe>('recipeBox')
        .values
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
