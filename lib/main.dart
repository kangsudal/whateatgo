import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo/riverpod/myState.dart';
import 'package:whateatgo/screen/home_screen.dart';
import 'package:shake/shake.dart';

import 'model/recipe.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ShakeDetector.autoStart(
      onPhoneShake: () {
        ref.read(diceNumberProvider.notifier).state++;
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 앱의 라이프사이클 상태가 변경될 때마다 호출된다.
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        detector.startListening();
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        detector.stopListening();
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData(ref);
    return const MaterialApp(
      home: HomeScreen(), //ListScreen(),
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
      ref.read(allRecipes.notifier).loadRecipeList(recipes);
    } catch (e) {
      throw Exception(e);
    }
  }
}
