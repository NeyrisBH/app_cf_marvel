import 'dart:developer';

import 'package:app_cf_marvel/locator.dart';
import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/repository/comics_repo.dart';
import 'package:mobx/mobx.dart';

part 'comics_state.g.dart';

class ComicsState = ComicsStateBase with _$ComicsState;

abstract class ComicsStateBase with Store {
  late MainState main;
  final ComicsRepoImpl _comicsRepoImpl = sl<ComicsRepoImpl>();
  ComicsStateBase({required this.main});

  @observable
  ObservableList<ComicModel> comicsList = ObservableList<ComicModel>();

  @observable
  Observable<bool> isLoading = Observable(false);

  @action
  Future<void> fetchComics() async {
    isLoading.value = true;
    try {
      List<ComicModel> comics = await _comicsRepoImpl.fetchComics();
      comicsList.clear();
      comicsList.addAll(comics);
    } catch (error) {
      log('Error fetching comics: $error');
    } finally {
      isLoading.value = false;
    }
  }

  @computed
  bool get hasComics => comicsList.isNotEmpty;

  @computed
  int get comicsCount => comicsList.length;
}