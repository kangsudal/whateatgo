import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/recipe.dart';

class ManualScreen extends StatelessWidget {
  final Recipe recipe;
  const ManualScreen({
    super.key,
    required this.recipe,
  }); //생성자 매개변수로 Recipe를 받는다
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.rcpnm!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if (recipe.manual01 != '')
              Text(recipe.manual01!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg01 != '')
              CachedNetworkImage(
                imageUrl: recipe.manualimg01!,
              ),
            if (recipe.manual02 != '')
              Text(recipe.manual02!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg02 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg02!),
            if (recipe.manual03 != '')
              Text(recipe.manual03!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg03 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg03!),
            if (recipe.manual04 != '')
              Text(recipe.manual04!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg04 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg04!),
            if (recipe.manual05 != '')
              Text(recipe.manual05!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg05 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg05!),
            if (recipe.manual06 != '')
              Text(recipe.manual06!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg06 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg06!),
            if (recipe.manual07 != '')
              Text(recipe.manual07!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg07 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg07!),
            if (recipe.manual08 != '')
              Text(recipe.manual08!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg08 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg08!),
            if (recipe.manual09 != '')
              Text(recipe.manual09!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg09 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg09!),
            if (recipe.manual10 != '')
              Text(recipe.manual10!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg10 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg10!),
            if (recipe.manual11 != '')
              Text(recipe.manual11!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg11 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg11!),
            if (recipe.manual12 != '')
              Text(recipe.manual12!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg12 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg12!),
            if (recipe.manual13 != '')
              Text(recipe.manual13!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg13 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg13!),
            if (recipe.manual14 != '')
              Text(recipe.manual14!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg14 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg14!),
            if (recipe.manual15 != '')
              Text(recipe.manual15!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg15 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg15!),
            if (recipe.manual16 != '')
              Text(recipe.manual16!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg16 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg16!),
            if (recipe.manual17 != '')
              Text(recipe.manual17!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg17 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg17!),
            if (recipe.manual18 != '')
              Text(recipe.manual18!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg18 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg18!),
            if (recipe.manual19 != '')
              Text(recipe.manual19!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg19 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg19!),
            if (recipe.manual20 != '')
              Text(recipe.manual20!, style: const TextStyle(fontSize: 20)),
            if (recipe.manualimg20 != '')
              CachedNetworkImage(imageUrl: recipe.manualimg20!),
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
