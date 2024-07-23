class Tables{
  static const sessionTable = "session";
  static const userTable  = "user";
  static const comicsTable = "comics";

  static const List<String> tables =
  [
    "CREATE TABLE IF NOT EXISTS $sessionTable(id INTEGER PRIMARY KEY AUTOINCREMENT,access_token TEXT,refresh_token TEXT,token_type TEXT,expire_time TEXT,created_at TEXT,expires_in TEXT)",
    "CREATE TABLE IF NOT EXISTS $userTable(id INTEGER PRIMARY KEY AUTOINCREMENT,email TEXT,username TEXT,name TEXT)",
    "CREATE TABLE IF NOT EXISTS $comicsTable (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, thumbnailUrl TEXT, rating REAL)"
  ];

}