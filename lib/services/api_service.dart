// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_node_store/main.dart';
import 'package:flutter_node_store/services/dio_config.dart';
import 'package:flutter_node_store/utils/utility.dart';

class ApiService {
  final Dio _dio = DioConfig.dio;

  registerLocal(values) async {
    if (await Utility.checkNetwork() == '') {
      return jsonEncode({'message': 'No network is Connected'});
    }
    try {
      final response = await _dio.post('auth/register', data: values);
      logger.d(response.data);
      return jsonEncode(response.data);
    } catch (err) {
      logger.e(err);
    }
  }
}
