import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whateatgo2/riverpod/myState.dart';
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
                    ref
                        .read(listScreenRecipesProvider.notifier)
                        .setDefaultList();
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
