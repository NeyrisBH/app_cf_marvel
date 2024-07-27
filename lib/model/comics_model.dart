import 'package:app_cf_marvel/utils/validate.dart';

class ComicModel {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  bool isFavorite;

  ComicModel({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.thumbnail = '',
    this.isFavorite = false,
  });

  factory ComicModel.toObject(Map<String, dynamic> data) {
    Validate validate = Validate(data);
    return ComicModel(
      id: validate.checkKeyExists(key: 'id', initialize: 0),
      title: validate.checkKeyExists(key: 'title', initialize: ''),
      description: validate.checkKeyExists(key: 'description', initialize: ''),
      thumbnail: _parseThumbnailUrl(
        validate.checkKeyExists(key: 'thumbnail', initialize: ''),
      ),
      isFavorite: false, // Initialize as false
    );
  }

  static String _parseThumbnailUrl(dynamic thumbnail) {
    if (thumbnail is Map<String, dynamic> &&
        thumbnail.containsKey('path') &&
        thumbnail.containsKey('extension')) {
      return '${thumbnail['path']}.${thumbnail['extension']}';
    } else if (thumbnail is String) {
      return thumbnail; // Handle if thumbnail is already a URL string
    }
    return 'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available';
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'thumbnail': thumbnail,
    'fav': isFavorite ? 1 : 0,
  };
}