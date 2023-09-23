import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo/riverpod/myState.dart';
import 'package:whateatgo/screen/home_screen.dart';
import 'package:whateatgo/screen/list_screen.dart';

import 'model/recipe.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    fetchData(ref);
    return const MaterialApp(
      home: ListScreen(),
    );
  }

  void fetchData(WidgetRef ref) async {
    //로컬 파일로부터 모든 레시피를 불러옴
    try {
      //파일을 읽어와 List<Recipe>로 변환시킨다.
      String jsonString = await rootBundle.loadString('sourceFile');
      Map<String, dynamic> dataMap = jsonDecode(jsonString);
      List<dynamic> dataList = dataMap['COOKRCP01']['row'];
      List<Recipe> recipes =
          dataList.map((json) => Recipe.fromJson(json)).toList();

      //전체 recipes 상태관리 변수에 넣기
      final List<Recipe> state = ref.watch(allRecipes);
      ref.read(allRecipes.notifier).loadRecipeList(recipes);
      print(state);
    } catch (e) {
      throw Exception(e);
    }
  }
}
