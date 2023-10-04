import 'package:dio/dio.dart';
import 'package:coincap/models/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HTTPService {
  final dio = Dio();

  AppConfig? _appConfig;
  String? _baseUrl;

  HTTPService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _baseUrl = _appConfig?.COIN_API_BASE_URL;
  }

  Future<Response?> get(String path) async {
    try {
      String url = "$_baseUrl$path";
      Response response = await dio.get(url);
      return response;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
