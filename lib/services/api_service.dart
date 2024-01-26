// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_node_store/services/dio_config.dart';
import 'package:flutter_node_store/utils/logger.dart';
import 'package:flutter_node_store/utils/NetworkConnect.dart';

class ApiService {
  final Dio _dio = DioConfig.dio;
  final NetworkConnect _networkConnect = NetworkConnect();

  registerLocal(values) async {
    try {
      if (await _networkConnect.checkNetwork() == '') {
        return jsonEncode({'message': 'No network is Connected'});
      }
      final response = await _dio.post('auth/register', data: values);
      return jsonEncode(response.data);
    } catch (err) {
      logger.e(err);
    }
  }

  loginLocal(values) async {
    try {
      if (await _networkConnect.checkNetwork() == '') {
        return jsonEncode({'message': 'No network is Connected'});
      }
      final response = await _dio.post('auth/login', data: values);
      logger.d(response.data);
      return jsonEncode(response.data);
    } catch (err) {
      logger.e(err);
    }
  }
}
