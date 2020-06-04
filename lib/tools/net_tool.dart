import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/model/confetti/confetti_response.dart';
import 'package:fun_refresh/model/plugin/plugin_response.dart';
import '../model/weather/he_weather.dart';
import '../tools/api.dart';

final netool = NeTool();

class NeTool {
  /// 和风天气
  /// [requestUrl] 请求地址
  /// [queryParameters] 请求参数
  /// [response] 响应JSON
  Future<HeWeather> pullWeather(String requestUrl) async {
    final Response<Map<String, Object>> response = await Dio().get(
      requestUrl,
      queryParameters: {
        'location': '深圳',
        'key': weatherKey,
      },
    );
    return HeWeather.fromJson(response.data);
  }

  /// 扩展小程序图标信息
  /// [requestUrl] 请求地址
  /// [queryParameters] 请求参数
  /// [response] 响应JSON
  Future<ConfettiResponse> pullExtAppData() async {
    final options = BaseOptions(baseUrl: EXT_BASE);
    final dio = Dio(options);
    if (Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
    final Response<Map<String, Object>> response = await dio.get('/$confetti');
    return ConfettiResponse.fromJson(response.data);
  }

  /// 插件数据接口
  Future<PluginResponse> pullPluginList() async {
    final options = BaseOptions(baseUrl: EXT_BASE);
    final dio = Dio(options);
    if (Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
    final Response<Map<String, Object>> response = await dio.get('/$plugins');
    return PluginResponse.fromJson(response.data);
  }

  /// 登录接口
  /// [nickName] 用户名
  /// [password] 密码
  /// [phone] 手机号
  Future<Map<String, Object>> login({
    String nickName,
    String phone,
    @required String password,
  }) async {
    final options = BaseOptions(baseUrl: BASE_URL);
    final dio = Dio(options);

    if (Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }

    final Response<Map<String, Object>> response = await dio.post(
      '/login',
      data: {
        'nick_name': nickName,
        'phone': phone,
        'password': password,
      },
    );
    return response.data;
  }

  /// 注册接口
  /// [nickName] 用户名
  /// [password] 密码
  /// [phone] 手机号
  Future<Map<String, Object>> regist({
    String nickName,
    String phone,
    @required String password,
  }) async {
    final options = BaseOptions(baseUrl: BASE_URL);
    final dio = Dio(options);

    if (Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
    FormData formData = FormData.fromMap({
      // 'avatar': await MultipartFile.fromFile(
      //   './net_tool.dart',
      //   filename: 'xxx.txt',
      // ),
      'nick_name': nickName,
      'phone': phone,
      'password': password,
    });

    final Response<Map<String, Object>> response = await dio.post(
      '/register',
      data: formData,
    );
    return response.data;
  }
}
