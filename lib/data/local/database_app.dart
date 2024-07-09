import 'package:app_cf_marvel/data/local/tables.dart';
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

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), name);
    return await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database database, int version) async {
    for (final table in Tables.tables) {
      await database.execute(table);
    }
  }

  Future<void> insertFavorite(String title, String description, String thumbnailUrl) async {
    final db = await database;
    await db.insert(
      Tables.favoritesTable,
      {'title': title, 'description': description, 'thumbnailUrl': thumbnailUrl},
    );
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query(Tables.favoritesTable);
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete(
      Tables.favoritesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}