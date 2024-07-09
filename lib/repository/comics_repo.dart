import 'package:app_cf_marvel/data/remote/apiMarvel.dart';
import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/utils/constants.dart';
import 'package:flutter/foundation.dart';

abstract class ComicsRepo {
  Future<List<ComicModel>> fetchComics();
}

class ComicsRepoImpl extends ComicsRepo {
  final ApiMarvel _api = ApiMarvel();

  @override
  Future<List<ComicModel>> fetchComics() async {
    try {
      final response = await _api.get(
        comicsApi,
        queryParameters: {
          'apikey': apiKeyMarvel,
          'ts': ts,
          'hash': hashMarvel,
          'startYear': '2024',
          'limit': '100',
          'orderBy': '-modified',
        },
      );
      List<ComicModel> comics = (response['data']['results'] as List)
          .map((json) => ComicModel.toObject(json))
          .toList();
      return comics;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching comics: $error');
      }
      throw Exception('Error fetching comics');
    }
  }
}
