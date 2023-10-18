import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whateatgo2/model/recipe.dart';

//1. 홈 화면에 switch 상태 관리
final homeScreenRecipeCategoryProvider = StateProvider<Map<String, bool>>(
  (ref) => {
    '밥': true,
    '후식': true,
    '반찬': true,
    '일품': true,
    '국&찌개': true,
  },
);

//2. 홈 화면에 후보군 리스트(초기값은 모든 리스트)
final homeScreenRecipesProvider =
    StateNotifierProvider<HomeScreenFilteredRecipeListNotifier, List<Recipe>>(
  (ref) => HomeScreenFilteredRecipeListNotifier(),
);

class HomeScreenFilteredRecipeListNotifier extends StateNotifier<List<Recipe>> {
  HomeScreenFilteredRecipeListNotifier()
      : super(Hive.box<Recipe>('recipeBox').values.toList());

  List<Recipe> filterList(Map<String, bool> categories) {
    //'밥', '후식', '반찬', '일품',  '국&찌개' 분류 SwitchListTile들 중에서
    // 스위치 온 된(true) key 값만 가져온다. (국&찌개, 후식 등)
    // https://stackoverflow.com/questions/73309888/how-to-return-a-list-of-map-keys-if-they-are-true
    List<String> trueCategories = [];
    categories.forEach((category, isSwitchOn) {
      if (isSwitchOn == true) {
        trueCategories.add(category);
      }
    });

    //스위치 온 된 음식 분류를 포함하고있는 레시피를 담을 리스트
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
}
