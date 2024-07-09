import 'dart:developer';

import 'package:app_cf_marvel/model/series_model.dart';
import 'package:app_cf_marvel/repository/series_repo.dart';
import 'package:mobx/mobx.dart';

part 'series_state.g.dart';

class SeriesState = SeriesStateBase with _$SeriesState;

abstract class SeriesStateBase with Store {
  final SeriesRepo _seriesRepo = SeriesRepoImpl();

  @observable
  ObservableList<SeriesModel> seriesList = ObservableList<SeriesModel>();

  @observable
  Observable<bool> isLoading = Observable(false);

  @action
  Future<void> fetchSeries() async {
    isLoading.value = true;
    try {
      List<SeriesModel> series = await  _seriesRepo.fetchSeries();
      seriesList.clear();
      seriesList.addAll(series);
    } catch (error) {
      log('Error fetching series: $error');
    } finally {
      isLoading.value = false;
    }
  }

  @computed
  bool get hasSeries => seriesList.isNotEmpty;

  @computed
  int get seriesCount => seriesList.length;
}