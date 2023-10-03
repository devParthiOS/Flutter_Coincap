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

  Future<Response?> get(String _path) async {
    try {
      String _url = "$_baseUrl$_path";
      Response _response = await dio.get(_url);
      debugPrint(_response.toString());
      return _response;
    } catch (error) {
      print(error.toString());
    }
  }
}
