import 'dart:developer';

import 'package:app_cf_marvel/locator.dart';
import 'package:app_cf_marvel/main_store/main_state.dart';
import 'package:app_cf_marvel/model/events_model.dart';
import 'package:app_cf_marvel/repository/events_repo.dart';
import 'package:mobx/mobx.dart';

part 'events_state.g.dart';

class EventsState = EventsStateBase with _$EventsState;

abstract class EventsStateBase with Store {
  late MainState main;
  final EventsRepoImpl _eventsRepoImpl = sl<EventsRepoImpl>();
  EventsStateBase({required this.main});

  @observable
  ObservableList<EventModel> eventsList = ObservableList<EventModel>();

  @observable
  Observable<bool> isLoading = Observable(false);

  @action
  Future<void> fetchEvents() async {
    isLoading.value = true;
    try {
      List<EventModel> events = await  _eventsRepoImpl.fetchEvents();
      eventsList.clear();
      eventsList.addAll(events);
    } catch (error) {
      log('Error fetching events: $error');
    } finally {
      isLoading.value = false;
    }
  }

  @computed
  bool get hasEvents => eventsList.isNotEmpty;

  @computed
  int get eventsCount => eventsList.length;
}