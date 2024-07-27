import 'package:app_cf_marvel/data/local/database_app.dart';
import 'package:app_cf_marvel/data/local/tables.dart';
import 'package:app_cf_marvel/data/remote/apiMarvel.dart';
import 'package:app_cf_marvel/locator.dart';
import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/utils/constants.dart';

abstract class ComicsRepo {
  Future<List<ComicModel>> fetchComics();
  Future<ComicModel> saveOurUpdate(Map<String, Object?> data);
  Future<List<ComicModel>> getFavs();
  Future<bool> updateFavStatus(int id, bool isFavorite);
}

class ComicsRepoImpl extends ComicsRepo {
  final ApiMarvel _api = sl<ApiMarvel>();
  final DatabaseApp _databaseApp = sl<DatabaseApp>();

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
          'limit': limitApi,
        },
      );

      // Ensure the response is a Map
      if (response is String) {
        throw Exception('API response is not a JSON object.');
      }

      List<ComicModel> comics = (response['data']['results'] as List)
          .map((json) => ComicModel.toObject(json))
          .toList();

      // Return comics before saving to the database
      // Future.microtask(
      //   () async {
      //     for (var comic in comics) {
      //       await saveOurUpdate(comic.toMap());
      //     }
      //   },
      // );

      return comics;
    } catch (error) {
      throw Exception('Error fetching comics $error');
    }
  }

  @override
  Future<List<ComicModel>> getFavs() async {
    final database = await _databaseApp.database;
    var data = await database.rawQuery(
        'SELECT * FROM ${Tables.comicsTable} WHERE fav = ?', ['true']);
    return data.map((json) => ComicModel.toObject(json)).toList();
  }

  @override
  Future<bool> updateFavStatus(int id, bool isFavorite) async {
    final database = await _databaseApp.database;
    int count = await database.update(
      Tables.comicsTable,
      {'fav': isFavorite ? true : false},
      where: 'id = ?',
      whereArgs: [id],
    );
    return count > 0;
  }

  @override
  Future<ComicModel> saveOurUpdate(Map<String, Object?> data) async {
    final database = await _databaseApp.database;
    ComicModel comicModel = ComicModel.toObject(data);

    int count = await database.update(
      Tables.comicsTable,
      comicModel.toMap(),
      where: 'id = ?',
      whereArgs: [comicModel.id],
    );

    if (count == 0) {
      await database.insert(Tables.comicsTable, comicModel.toMap());
    }

    return comicModel;
  }
}
