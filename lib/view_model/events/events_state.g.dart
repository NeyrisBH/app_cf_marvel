// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventsState on EventsStateBase, Store {
  Computed<bool>? _$hasEventsComputed;

  @override
  bool get hasEvents =>
      (_$hasEventsComputed ??= Computed<bool>(() => super.hasEvents,
              name: 'EventsStateBase.hasEvents'))
          .value;
  Computed<int>? _$eventsCountComputed;

  @override
  int get eventsCount =>
      (_$eventsCountComputed ??= Computed<int>(() => super.eventsCount,
              name: 'EventsStateBase.eventsCount'))
          .value;

  late final _$eventsListAtom =
      Atom(name: 'EventsStateBase.eventsList', context: context);

  @override
  ObservableList<EventModel> get eventsList {
    _$eventsListAtom.reportRead();
    return super.eventsList;
  }

  @override
  set eventsList(ObservableList<EventModel> value) {
    _$eventsListAtom.reportWrite(value, super.eventsList, () {
      super.eventsList = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'EventsStateBase.isLoading', context: context);

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

  late final _$fetchEventsAsyncAction =
      AsyncAction('EventsStateBase.fetchEvents', context: context);

  @override
  Future<void> fetchEvents() {
    return _$fetchEventsAsyncAction.run(() => super.fetchEvents());
  }

  @override
  String toString() {
    return '''
eventsList: ${eventsList},
isLoading: ${isLoading},
hasEvents: ${hasEvents},
eventsCount: ${eventsCount}
    ''';
  }
}
