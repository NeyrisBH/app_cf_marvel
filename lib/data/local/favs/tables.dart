class TablesFav{
  static const comicsTable = "comics";
  //static const favoritesTable = 'favorites';

  static const List<String> tables =
  [
    '''
    CREATE TABLE IF NOT EXISTS $comicsTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      thumbnailUrl TEXT,
      rating REAL
    )
    ''',
  ];

}