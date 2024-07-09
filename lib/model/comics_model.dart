class ComicModel {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;

  ComicModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  factory ComicModel.fromJson(Map<String, dynamic> json) {
    return ComicModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnailUrl: _parseThumbnailUrl(json['thumbnail']),
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
}