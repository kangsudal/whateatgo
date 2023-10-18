import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo2/riverpod/listScreenState.dart';
import 'package:whateatgo2/screen/manual_screen.dart';
import 'package:whateatgo2/riverpod/shakeState.dart';

import '../model/recipe.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key});

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  @override
  void initState() {
    //홈화면으로부터 벗어나 manual화면으로 들어왔을때 잠시 shakeDetector를 끈다.
    ref.read(shakeDetectorProvider.notifier).state.stopListening();
    super.initState();
  }

  @override
  void deactivate() {
    //State 객체가 Flutter의 구성 트리로부터 제거될 때 호출
    //다시 홈화면으로 갈땐 shakeDetector를 킨다.
    ref.read(shakeDetectorProvider.notifier).state.startListening();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    List<Recipe> items = ref.watch(listScreenRecipesProvider);
    Map<String, bool> categories = ref.watch(recipeCategoryProvider);
    final TextEditingController myController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                border: const OutlineInputBorder(),
                labelText: '검색',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                hintText: '두부',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.undo,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    //검색조건 모두 초기화
                    ref
                        .read(listScreenRecipesProvider.notifier)
                        .setDefaultList();
                    ref.read(recipeCategoryProvider.notifier).state = {
                      '밥': true,
                      '후식': true,
                      '반찬': true,
                      '일품': true,
                      '국&찌개': true,
                    };
                  },
                ),
              ),
              onEditingComplete: () {
                ref
                    .read(listScreenRecipesProvider.notifier)
                    .normalFilterList(myController.text);
              },
              autofocus: true,
            ),
          ),
          //'밥', '후식', '반찬', '일품',  '국&찌개' 분류 필터 체크박스
          Row(
            children: categories.keys.map((String key) {
              return Expanded(
                child: Center(
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: -5,
                    children: [
                      Checkbox(
                        value: categories[key],
                        onChanged: (bool? value) {
                          /// 현재 리스트 state에서 체크된 카테고리 필터를 적용한다.
                          /// https://stackoverflow.com/questions/45153204/how-can-i-handle-a-list-of-checkboxes-dynamically-created-in-flutter
                          setState(() {
                            categories[key] = value ?? false;
                            ref
                                .read(listScreenRecipesProvider.notifier)
                                .filterListByCategory(categories);
                          });
                        },
                      ),
                      Text(key),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          ListTile(
            subtitle: Text(
              '검색결과 ${ref.watch(listScreenRecipesProvider).length}개',
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(items[index].rcpnm!),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ManualScreen(
                        recipe: items[index],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
