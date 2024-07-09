import 'dart:developer';

import 'package:app_cf_marvel/model/comics_model.dart';
import 'package:app_cf_marvel/repository/comics_repo.dart';
import 'package:mobx/mobx.dart';

part 'comics_state.g.dart';

class ComicsState = ComicsStateBase with _$ComicsState;

abstract class ComicsStateBase with Store {
  final ComicsRepo _comicsRepo = ComicsRepoImpl();

  @observable
  ObservableList<ComicModel> comicsList = ObservableList<ComicModel>();

  @observable
  Observable<bool> isLoading = Observable(false);

  @action
  Future<void> fetchComics() async {
    isLoading.value = true;
    try {
      List<ComicModel> comics = await _comicsRepo.fetchComics();
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