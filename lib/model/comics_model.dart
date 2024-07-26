import 'package:app_cf_marvel/utils/validate.dart';

class ComicModel {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;
  bool isFavorite;

  ComicModel({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.thumbnailUrl = '',
    this.isFavorite = false,
  });

  factory ComicModel.toObject(Map<String, dynamic> data) {
    Validate validate = Validate(data);
    return ComicModel(
      id: validate.checkKeyExists(key: 'id', initialize: 0),
      title: validate.checkKeyExists(key: 'title', initialize: ''),
      description: validate.checkKeyExists(key: 'description', initialize: ''),
      thumbnailUrl: _parseThumbnailUrl(
        validate.checkKeyExists(key: 'thumbnail', initialize: ''),
      ),
      isFavorite: validate.checkKeyExists(key: 'fav', initialize: false) == true,
    );
  }

  static String _parseThumbnailUrl(Map<String, dynamic>? thumbnail) {
    if (thumbnail != null &&
        thumbnail.containsKey('path') &&
        thumbnail.containsKey('extension')) {
      return '${thumbnail['path']}.${thumbnail['extension']}';
    }
    return 'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available';
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'thumbnail': thumbnailUrl,
    'fav': isFavorite ? true : false,
  };
}
