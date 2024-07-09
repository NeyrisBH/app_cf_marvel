import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<ComicModel> favoritesList;

  const FavoritesScreen({
    super.key,
    required this.favoritesList,
  });

  @override
  Widget build(BuildContext context) {
    print('Estos son los favs${favoritesList.toString()}');
    return Scaffold(
      body: ListView.builder(
        itemCount: favoritesList.length,
        itemBuilder: (context, index) {
          final comic = favoritesList[index];
          return ListTile(
            selectedColor: LightColor.green,
            title: Text(comic.title),
            subtitle: Text(comic.description),
            leading: Image.network(comic.thumbnailUrl ?? ''),
          );
        },
      ),
    );
  }
}