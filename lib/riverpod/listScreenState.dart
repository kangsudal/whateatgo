import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/recipe.dart';

//1. 리스트 화면에 체크박스 상태 관리
final recipeCategoryProvider = AutoDisposeStateProvider<Map<String, bool>>(
  (ref) => {
    '밥': true,
    '후식': true,
    '반찬': true,
    '일품': true,
    '국&찌개': true,
    '기타': true,
  },
);

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

  List<Recipe> filterList(String keyword, Map<String, bool> categories) {
    //'밥', '후식', '반찬', '일품',  '국&찌개' 분류 체크박스에서
    // 체크된(true) key 값만 가져온다. (국&찌개, 후식 등)
    // https://stackoverflow.com/questions/73309888/how-to-return-a-list-of-map-keys-if-they-are-true
    List<String> trueCategories = [];
    categories.forEach((category, isChecked) {
      if (isChecked == true) {
        trueCategories.add(category);
      }
    });

    //검색어를 포함하고 & 체크된 음식 분류를 포함하고있는 레시피를 담을 리스트
    List<Recipe> filtered = [];

    for (String category in trueCategories) {
      filtered += Hive.box<Recipe>('recipeBox')
          .values
          .toList()
          .where((element) =>
              (element.rcpnm!.contains(keyword)) || //메뉴명
              (element.rcppat2!.contains(keyword)) || //요리종류
              (element.hashtag!.contains(keyword)) || //해쉬태그
              (element.rcppartsdtls!.contains(keyword))) //재료정보
          .where((recipe) => recipe.rcppat2 == category)
          .toList();
    }

    state = filtered;
    return filtered;
  }
}
