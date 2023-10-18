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
    StateProvider((ref) => Hive.box<Recipe>('recipeBox').values.toList());
