import 'package:app_cf_marvel/data/local/tables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseApp{
  String name = "OauthApp";
  int version = 1;
  static Database? _database;

  Future<Database>get database async{
    if(_database!=null){
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase()async{
    String path = join(await getDatabasesPath(),name);
    return await openDatabase(
        path,
      version: version,
      onCreate: _onCreate
    );
  }
  _onCreate(Database database, int version){
    Tables.tables.forEach((scrip) async=>await database.execute(scrip));
  }
}