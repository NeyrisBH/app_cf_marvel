import 'package:app_cf_marvel/model/comics_model.dart';

class FavoritesModel {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;

  FavoritesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl
  });

  factory FavoritesModel.fromComicModel(ComicModel comic){
    return FavoritesModel(
      id: comic.id,
      title: comic.title,
      description: comic.description,
      thumbnailUrl: comic.thumbnailUrl ?? '',
    );
  }
}