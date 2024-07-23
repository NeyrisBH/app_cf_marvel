import 'package:app_cf_marvel/data/remote/apiMarvel.dart';
import 'package:app_cf_marvel/model/events_model.dart';
import 'package:app_cf_marvel/utils/constants.dart';
import 'package:flutter/foundation.dart';

abstract class EventsRepo {
  Future<List<EventModel>> fetchEvents();
}

class EventsRepoImpl extends EventsRepo {
  final ApiMarvel _api = ApiMarvel();

  @override
  Future<List<EventModel>> fetchEvents() async {
    try {
      final response = await _api.get(
        eventsApi,
        queryParameters: {
          'apikey': apiKeyMarvel,
          'ts': ts,
          'hash': hashMarvel,
          'limit': '5',
        },
      );
      List<EventModel> events = (response['data']['results'] as List)
          .map((json) => EventModel.toObject(json))
          .toList();
      return events;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching events: $error');
      }
      throw Exception('Error fetching events');
    }
  }
}
