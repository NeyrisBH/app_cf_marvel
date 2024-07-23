

import 'package:app_cf_marvel/utils/validate.dart';

class EventModel {
  int id;
  String title;
  String description;
  String thumbnailUrl;
  bool isFavorite;

  EventModel({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.thumbnailUrl = "",
    this.isFavorite = false,
  });

  factory EventModel.toObject(Map<String, dynamic> data) {
    Validate validate = Validate(data);
    return EventModel(
      id: validate.checkKeyExists(key: 'id', initialize: 0),
      title: validate.checkKeyExists(key: 'title', initialize: ''),
      description: validate.checkKeyExists(key: 'description', initialize: ''),
      thumbnailUrl: _parseThumbnailUrl(
        validate.checkKeyExists(key: 'thumbnail', initialize: ''),
      ),
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
    'thumbnail': thumbnailUrl
  };
}