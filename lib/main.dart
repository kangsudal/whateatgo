import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo/screen/home_screen.dart';

import 'model/recipe.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    fetchData();
    return const MaterialApp(
      home: HomeScreen(),
    );
  }

  void fetchData() async {
    //로컬 파일로부터 모든 레시피를 불러옴
    try {
      //파일을 읽어와 List<Recipe>로 변환시킨다.
      String jsonString = await rootBundle.loadString('sourceFile');
      Map<String, dynamic> dataMap = jsonDecode(jsonString);
      List<dynamic> dataList = dataMap['COOKRCP01']['row'];
      List<Recipe> recipes =
          dataList.map((json) => Recipe.fromJson(json)).toList();

      //TODO: recipes 상태관리 변수에 넣기
    } catch (e) {
      throw Exception(e);
    }
  }
}
