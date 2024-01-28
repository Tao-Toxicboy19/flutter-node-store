// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_node_store/models/product_model.dart';
import 'package:flutter_node_store/services/dio_config.dart';
import 'package:flutter_node_store/utils/logger.dart';
import 'package:flutter_node_store/utils/NetworkConnect.dart';

class ApiService {
  final Dio _dio = DioConfig.dio;
  final Dio _dioWithAuth = DioConfig.dioWithAuth;

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
      return jsonEncode(response.data);
    } catch (err) {
      logger.e(err);
    }
  }

  // Future<List<ProductModel>> getAllProducts() async {
  //   final response = await _dioWithAuth.get('products');
  //   if (response.statusCode == 200) {
  //     logger.d(response.data);
  //     final List<ProductModel> products = productModelFromJson(
  //       json.encode(response.data),
  //     );
  //     return products;
  //   }
  //   throw Exception('Failed to load products');
  // }

  Future<List<ProductModel>> getProducts() async {
    try {
      if (await _networkConnect.checkNetwork() == '') {
        throw Exception('No network is Connected');
      }
      final response = await _dioWithAuth.get('products');
      if (response.statusCode == 200) {
        logger.d(response.data);
        final List<ProductModel> products =
            productModelFromJson(json.encode(response.data));
        return products;
      }
      throw Exception('not found products');
    } catch (err) {
      logger.e(err);
      throw Exception('Failed to load products');
    }
  }

  // Future<List<ProductModel>> getProducts() async {
  //   try {
  //     if (await _networkConnect.checkNetwork() == '') {
  //       throw Exception('No network is connected');
  //     }

  //     final response = await _ditWithAuth.get('products');

  //     if (response.statusCode == 200) {
  //       logger.d(response.data);

  //       // Use jsonDecode to convert the JSON response to a dynamic object
  //       final List<ProductModel> products =
  //           productModelFromJson(jsonDecode(response.data));

  //       return products;
  //     }
  //   } catch (err) {
  //     logger.e(err);
  //     throw Exception('Failed to load products');
  //   }

  //   // Add a return statement at the end
  //   return []; // or return null; depending on your logic
  // }
}
