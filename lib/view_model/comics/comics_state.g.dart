// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comics_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ComicsState on ComicsStateBase, Store {
  Computed<bool>? _$hasComicsComputed;

  @override
  bool get hasComics =>
      (_$hasComicsComputed ??= Computed<bool>(() => super.hasComics,
              name: 'ComicsStateBase.hasComics'))
          .value;
  Computed<int>? _$comicsCountComputed;

  @override
  int get comicsCount =>
      (_$comicsCountComputed ??= Computed<int>(() => super.comicsCount,
              name: 'ComicsStateBase.comicsCount'))
          .value;

  late final _$comicsListAtom =
      Atom(name: 'ComicsStateBase.comicsList', context: context);

  @override
  ObservableList<ComicModel> get comicsList {
    _$comicsListAtom.reportRead();
    return super.comicsList;
  }

  @override
  set comicsList(ObservableList<ComicModel> value) {
    _$comicsListAtom.reportWrite(value, super.comicsList, () {
      super.comicsList = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ComicsStateBase.isLoading', context: context);

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

  late final _$fetchComicsAsyncAction =
      AsyncAction('ComicsStateBase.fetchComics', context: context);

  @override
  Future<void> fetchComics() {
    return _$fetchComicsAsyncAction.run(() => super.fetchComics());
  }

  @override
  String toString() {
    return '''
comicsList: ${comicsList},
isLoading: ${isLoading},
hasComics: ${hasComics},
comicsCount: ${comicsCount}
    ''';
  }
}
