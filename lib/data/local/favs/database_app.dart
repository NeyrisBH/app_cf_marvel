import 'package:app_cf_marvel/data/local/favs/tables.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFavApp {
  String name = "FavsApp";
  int version = 1;
  static Database? _databaseFav;

  Future<Database> get database async {
    if (_databaseFav != null) {
      return _databaseFav!;
    }
    _databaseFav = await _initDatabase();
    return _databaseFav!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), name);
    return await openDatabase(path, version: version, onCreate: _onCreate);
  }

  _onCreate(Database database, int version) async {
    for (final table in TablesFav.tables) {
    await database.execute(table);
    if (kDebugMode) {
      print('Table created: $table');
    }
  }
  }

  Future<void> insertFavorite(String title, String description, String thumbnailUrl) async {
    final db = await database;
    await db.insert(
      TablesFav.comicsTable,
      {'title': title, 'description': description, 'thumbnailUrl': thumbnailUrl, 'rating': 0.0},
    );
  }

  Future<void> updateRating(int id, double rating) async {
    final db = await database;
    await db.update(
      TablesFav.comicsTable,
      {'rating': rating},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getComics() async {
    final db = await database;
    return await db.query(TablesFav.comicsTable);
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete(
      TablesFav.comicsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
