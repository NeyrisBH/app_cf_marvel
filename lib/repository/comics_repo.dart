import 'package:app_cf_marvel/data/local/database_app.dart';
import 'package:app_cf_marvel/data/local/tables.dart';
import 'package:app_cf_marvel/data/remote/apiMarvel.dart';
import 'package:app_cf_marvel/locator.dart';
import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/utils/constants.dart';
import 'package:flutter/foundation.dart';

abstract class ComicsRepo {
  Future<List<ComicModel>> fetchComics();
  Future<void>saveOurUpdate(Map<String, dynamic> data);
  Future<List<ComicModel>>getFavs();
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
      List<ComicModel> comics = (response['data']['results'] as List)
          .map((json) => ComicModel.toObject(json))
          .toList();

      //Guardar comics en la base de datos
      for (var comic in comics) {
        comic.isFavorite = false;
        await saveOurUpdate(comic.toMap());
      }

      return comics;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching comics: $error');
      }
      throw Exception('Error fetching comics');
    }
  }
  
  @override
  Future<List<ComicModel>> getFavs() async {
    final database = await _databaseApp.database;
    var data = await database.rawQuery('SELECT * FROM ${Tables.comicsTable} WHERE fav = ?', ['true']);
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
  Future<void> saveOurUpdate(Map<String, dynamic> data) async {
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
  }
}
