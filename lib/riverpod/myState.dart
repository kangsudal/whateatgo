import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/recipe.dart';

//1. 홈 화면에 후보군 리스트(초기값은 모든 리스트)
final homeScreenRecipesProvider =
    StateProvider((ref) => Hive.box<Recipe>('recipeBox').values.toList());

final recipeCategoryProvider = AutoDisposeStateProvider<Map<String, bool>>(
  (ref) => {
    '밥': true,
    '후식': true,
    '반찬': true,
    '일품': true,
    '국&찌개': true,
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

  List<Recipe> filterListByCategory(Map<String, bool> categories) {
    ///'밥', '후식', '반찬', '일품',  '국&찌개' 분류 필터 버튼 상태관리
    /// 체크된(true) key 값만 가져온다. (국&찌개, 후식 등)
    /// https://stackoverflow.com/questions/73309888/how-to-return-a-list-of-map-keys-if-they-are-true
    List<String> trueCategories = [];
    categories.forEach((category, isChecked) {
      if (isChecked == true) {
        trueCategories.add(category);
      }
    });

    //체크된 카테고리를 포함하고있는 레시피 리스트
    List<Recipe> filtered = [];

    for (String category in trueCategories) {
      filtered += Hive.box<Recipe>('recipeBox')
          .values
          .toList()
          .where((recipe) => recipe.rcppat2 == category)
          .toList();
    }

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
