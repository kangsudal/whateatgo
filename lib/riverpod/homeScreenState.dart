import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whateatgo2/model/recipe.dart';

//1. 홈 화면에 후보군 리스트(초기값은 모든 리스트)
final homeScreenRecipesProvider =
    StateProvider((ref) => Hive.box<Recipe>('recipeBox').values.toList());
