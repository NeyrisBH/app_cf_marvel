import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../utils/constants.dart';

class ApiMarvel {
  late Dio dio;

  ApiMarvel() {
    dio = Dio(
      BaseOptions(
        baseUrl: urlMarvel,
        connectTimeout: const Duration(seconds: 40),
        receiveTimeout: const Duration(seconds: 120),
        headers: {
          HttpHeaders.authorizationHeader: '',
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      ),
    );

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters, String accessToken = ''}) async {
    try {
      final Response response = await dio.get(endpoint, queryParameters: queryParameters);
      return validateResponse(response);
    } on DioError catch (error) {
      throw Exception('Error interno: $error');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body, {String accessToken = ''}) async {
    try {
      final Response response = await dio.post(endpoint, data: body);
      return validateResponse(response);
    } on DioError catch (error) {
      throw Exception('Error interno: $error');
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body, {String accessToken = ''}) async {
    try {
      final Response response = await dio.put(endpoint, data: body);
      return validateResponse(response);
    } on DioError catch (error) {
      throw Exception('Error interno: $error');
    }
  }

  Future<dynamic> delete(String endpoint, {String accessToken = ''}) async {
    try {
      final Response response = await dio.delete(endpoint);
      return validateResponse(response);
    } on DioError catch (error) {
      throw Exception('Error interno: $error');
    }
  }

  void addToken(String accessToken) {
    dio.options.headers[HttpHeaders.contentTypeHeader] =
        (accessToken.isNotEmpty) ? 'application/x-www-form-urlencoded' : 'application/json; charset=utf-8';
    dio.options.headers[HttpHeaders.authorizationHeader] = (accessToken.isNotEmpty) ? 'Bearer $accessToken' : '';
  }

  dynamic validateResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
      case 401:
        throw Exception(response.data['error'].toString());
      case 500:
        throw Exception('Error en el servidor: ${response.statusCode.toString()}');
      default:
        throw Exception('Error inesperado: ${response.statusCode.toString()}');
    }
  }
}