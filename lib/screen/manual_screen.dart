import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/recipe.dart';
import '../riverpod/myState.dart';

class ManualScreen extends ConsumerStatefulWidget {
  final Recipe recipe; //생성자 매개변수로 Recipe를 받는다
  const ManualScreen({
    super.key,
    required this.recipe,
  });

  @override
  ConsumerState<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends ConsumerState<ManualScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.rcpnm!),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            // if (widget.recipe.attfilenomain != '')
            //   CachedNetworkImage(imageUrl: widget.recipe.attfilenomain!),
            //재료 or 썸네일 사진
            if (widget.recipe.attfilenomk != '')
              CachedNetworkImage(imageUrl: widget.recipe.attfilenomk!),
            //재료
            const Text(
              '재료:',
              style: TextStyle(fontSize: 30),
            ),
            if (widget.recipe.rcppartsdtls != '')
              Text(widget.recipe.rcppartsdtls!,
                  style: const TextStyle(fontSize: 20)),
            const SizedBox(
              height: 50,
            ),
            if (widget.recipe.manual01 != '')
              Text(widget.recipe.manual01!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg01 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg01!),
            if (widget.recipe.manual02 != '')
              Text(widget.recipe.manual02!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg02 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg02!),
            if (widget.recipe.manual03 != '')
              Text(widget.recipe.manual03!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg03 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg03!),
            if (widget.recipe.manual04 != '')
              Text(widget.recipe.manual04!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg04 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg04!),
            if (widget.recipe.manual05 != '')
              Text(widget.recipe.manual05!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg05 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg05!),
            if (widget.recipe.manual06 != '')
              Text(widget.recipe.manual06!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg06 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg06!),
            if (widget.recipe.manual07 != '')
              Text(widget.recipe.manual07!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg07 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg07!),
            if (widget.recipe.manual08 != '')
              Text(widget.recipe.manual08!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg08 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg08!),
            if (widget.recipe.manual09 != '')
              Text(widget.recipe.manual09!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg09 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg09!),
            if (widget.recipe.manual10 != '')
              Text(widget.recipe.manual10!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg10 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg10!),
            if (widget.recipe.manual11 != '')
              Text(widget.recipe.manual11!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg11 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg11!),
            if (widget.recipe.manual12 != '')
              Text(widget.recipe.manual12!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg12 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg12!),
            if (widget.recipe.manual13 != '')
              Text(widget.recipe.manual13!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg13 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg13!),
            if (widget.recipe.manual14 != '')
              Text(widget.recipe.manual14!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg14 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg14!),
            if (widget.recipe.manual15 != '')
              Text(widget.recipe.manual15!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg15 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg15!),
            if (widget.recipe.manual16 != '')
              Text(widget.recipe.manual16!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg16 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg16!),
            if (widget.recipe.manual17 != '')
              Text(widget.recipe.manual17!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg17 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg17!),
            if (widget.recipe.manual18 != '')
              Text(widget.recipe.manual18!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg18 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg18!),
            if (widget.recipe.manual19 != '')
              Text(widget.recipe.manual19!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg19 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg19!),
            if (widget.recipe.manual20 != '')
              Text(widget.recipe.manual20!,
                  style: const TextStyle(fontSize: 20)),
            if (widget.recipe.manualimg20 != '')
              CachedNetworkImage(imageUrl: widget.recipe.manualimg20!),
            ElevatedButton(
              child: const Text("오늘은 이 메뉴로 확정!"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
