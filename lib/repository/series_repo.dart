import 'package:app_cf_marvel/data/remote/apiMarvel.dart';
import 'package:app_cf_marvel/model/series_model.dart';
import 'package:app_cf_marvel/utils/constants.dart';
import 'package:flutter/foundation.dart';

abstract class SeriesRepo {
  Future<List<SeriesModel>> fetchSeries();
}

class SeriesRepoImpl extends SeriesRepo {
  final ApiMarvel _api = ApiMarvel();

  @override
  Future<List<SeriesModel>> fetchSeries() async {
    try {
      final response = await _api.get(
        seriesApi,
        queryParameters: {
          'apikey': apiKeyMarvel,
          'ts': ts,
          'hash': hashMarvel,
          'startYear': '2024',
          'limit': '100',
        },
      );
      List<SeriesModel> series = (response['data']['results'] as List)
          .map((json) => SeriesModel.fromJson(json))
          .toList();
      return series;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching series: $error');
      }
      throw Exception('Error fetching series');
    }
  }
}
