// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SeriesState on SeriesStateBase, Store {
  Computed<bool>? _$hasSeriesComputed;

  @override
  bool get hasSeries =>
      (_$hasSeriesComputed ??= Computed<bool>(() => super.hasSeries,
              name: 'SeriesStateBase.hasSeries'))
          .value;
  Computed<int>? _$seriesCountComputed;

  @override
  int get seriesCount =>
      (_$seriesCountComputed ??= Computed<int>(() => super.seriesCount,
              name: 'SeriesStateBase.seriesCount'))
          .value;

  late final _$seriesListAtom =
      Atom(name: 'SeriesStateBase.seriesList', context: context);

  @override
  ObservableList<SeriesModel> get seriesList {
    _$seriesListAtom.reportRead();
    return super.seriesList;
  }

  @override
  set seriesList(ObservableList<SeriesModel> value) {
    _$seriesListAtom.reportWrite(value, super.seriesList, () {
      super.seriesList = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'SeriesStateBase.isLoading', context: context);

  @override
  Observable<bool> get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(Observable<bool> value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$fetchSeriesAsyncAction =
      AsyncAction('SeriesStateBase.fetchSeries', context: context);

  @override
  Future<void> fetchSeries() {
    return _$fetchSeriesAsyncAction.run(() => super.fetchSeries());
  }

  @override
  String toString() {
    return '''
seriesList: ${seriesList},
isLoading: ${isLoading},
hasSeries: ${hasSeries},
seriesCount: ${seriesCount}
    ''';
  }
}
