import 'package:app_cf_marvel/utils/validate.dart';

class EventModel {
  int id;
  String title;
  String description;
  String thumbnailUrl;

  EventModel({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.thumbnailUrl = "",
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    Validate validate = Validate(map);
    return EventModel(
      id: validate.checkKeyExists(key: "id", initialize: 0),
      title: validate.checkKeyExists(key: "title", initialize: ""),
      description: validate.checkKeyExists(key: "description", initialize: ""),
      thumbnailUrl: validate.checkKeyExists(key: "thumbnailUrl", initialize: ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "thumbnailUrl": thumbnailUrl,
    };
  }
}