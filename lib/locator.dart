import 'package:app_cf_marvel/data/remote/apiMarvel.dart';
import 'package:app_cf_marvel/repository/session_repo.dart';
import 'package:app_cf_marvel/repository/user_repo.dart';
import 'package:get_it/get_it.dart';

import 'data/local/database_app.dart';
import 'data/remote/api.dart';

final sl = GetIt.instance;

Future<void> setupLocator()async{
  sl.registerLazySingleton<DatabaseApp>(() => DatabaseApp());
  sl.registerLazySingleton<Api>(() => Api());
  sl.registerLazySingleton<SessionRepoImpl>(() => SessionRepoImpl());
  sl.registerLazySingleton<UserRepoImpl>(() => UserRepoImpl());
  sl.registerLazySingleton<ApiMarvel>(() => ApiMarvel());
}