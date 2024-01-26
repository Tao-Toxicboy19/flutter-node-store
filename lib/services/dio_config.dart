// ignore_for_file: unused_local_variable, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_node_store/utils/constants.dart';
import 'package:flutter_node_store/utils/logger.dart';

class DioConfig {
  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Accept'] = 'application/json';
          options.headers['Content-Type'] = 'application/json';
          options.baseUrl = apiUrl;
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (DioException err, handler) async {
          switch (err.response?.statusCode) {
            case 400:
              logger.e('Bad Request');
              break;
            case 401:
              logger.e('Unauthorized');
              break;
            case 403:
              logger.e('Forbidden');
              break;
            case 404:
              logger.e('Not Found');
              break;
            case 500:
              logger.e('Internal Server Error');
              break;
            default:
              logger.e('Something went wrong');
              break;
          }
          return handler.next(err);
        },
      ),
    );
  static Dio get dio => _dio;
}
