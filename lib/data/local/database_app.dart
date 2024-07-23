import 'package:app_cf_marvel/data/local/tables.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp {
  String name = "OauthApp";
  int version = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), name);
    return await openDatabase(path, version: version, onCreate: _onCreate);
  }

  _onCreate(Database database, int version) async {
    if (kDebugMode) {
      print("Creating tables...");
    }
    for (final table in Tables.tables) {
      await database.execute(table);
    }
  }

  Future<void> insertComic(
      String title, String description, String thumbnailUrl) async {
    final db = await database;
    await db.insert(
      Tables.comicsTable,
      {
        'title': title,
        'description': description,
        'thumbnailUrl': thumbnailUrl,
        'rating': 0.0
      },
    );
  }

  Future<void> updateRating(int id, double rating) async {
    final db = await database;
    await db.update(
      Tables.comicsTable,
      {'rating': rating},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getComics() async {
    final db = await database;
    return await db.query(Tables.comicsTable);
  }

  Future<void> deleteComic(int id) async {
    final db = await database;
    await db.delete(
      Tables.comicsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
