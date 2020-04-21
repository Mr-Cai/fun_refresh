import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/model/mock/extension/extension_app.dart';
import 'package:fun_refresh/model/mock/extension/plugin/girl_gank.dart';
import 'package:fun_refresh/model/mock/video/eye_channel.dart';
import 'package:fun_refresh/model/mock/video/eye_related.dart';
import 'package:fun_refresh/model/mock/video/tiktok_hot_week.dart';
import '../model/mock/video/eye_video.dart';
import '../model/mock/weather/he_weather.dart';
import '../tools/api.dart';

final netool = NeTool();
final dio = Dio();

class NeTool {
  final options = BaseOptions(baseUrl: EYE_BASE);

  /// 开眼API: 日报视频列表请求 GET
  /// [requestUrl] 请求地址
  /// [options] 请求头
  /// [queryParameters] 请求参数
  /// [response] 响应JSON
  Future<EyeVideo> pullEyeVideo() async {
    final Response<Map<String, Object>> response = await Dio(options).get(
      EYE_DAILY,
      queryParameters: {'deviceModel': 'GM1910', 'vc': 531, 'num': 100},
      options: Options(headers: {'User-Agent': POST_MAN}),
    );
    if (response.statusCode == 200) {
      return EyeVideo.fromJson(response.data); // 从获取的JSON中解析数据
    } else {
      throw Exception();
    }
  }

  Future<EyeRelated> pullEyeRelated({int id}) async {
    final Response<Map<String, Object>> response = await Dio(options).get(
      EYE_RELATED,
      queryParameters: {'deviceModel': 'GM1910', 'vc': 531, 'id': id},
      options: Options(headers: {'User-Agent': POST_MAN}),
    );
    if (response.statusCode == 200) {
      return EyeRelated.fromJson(response.data); // 从获取的JSON中解析数据
    } else {
      throw Exception();
    }
  }

  Future<EyeChannel> pullEyeChannel({int id}) async {
    final Response<Map<String, Object>> response = await Dio(options).get(
      EYE_CHANNEL,
      queryParameters: {
        'pgcId': id,
        'udid': '35dd199248e443f58b4022fc99c022d3a3c1a356'
      },
      options: Options(headers: {'User-Agent': POST_MAN}),
    );
    if (response.statusCode == 200) {
      return EyeChannel.fromJson(response.data); // 从获取的JSON中解析数据
    } else {
      throw Exception();
    }
  }

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
  Future<ExtResponse> pullExtAppData() async {
    final options = BaseOptions(baseUrl: EXT_BASE);
    final dio = Dio(options);
    if (Platform.isAndroid) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }
    final Response<Map<String, Object>> response = await dio.get('/$typeList');
    return ExtResponse.fromJson(response.data);
  }

  Future<List<String>> requestTikTokItemIDs() async {
    RegExp regExp;
    List<String> itemIDs = [];
    String rawStr;
    String itemID;
    final Response<String> html = await dio.get(tiktokHotWeekHtml);
    regExp = RegExp(r'https.*douyin.*\d', multiLine: true);
    regExp.allMatches(html.data).forEach((element) async {
      rawStr = html.data.substring(element.start, element.end);
      itemID = rawStr.replaceAll(RegExp(r'h.*\/'), '');
      itemID = itemID.replaceAll(RegExp(r'\?.*'), '');
      itemIDs.add(itemID);
    });
    return itemIDs;
  }

  Future<TiktokHotWeek> requestTiktokWeekHot(String itemID) async {
    Response<Map<String, Object>> response = await dio.get(
      tiktokHotWeek,
      queryParameters: {
        'item_ids': itemID,
      },
    );
    return TiktokHotWeek.fromJson(response.data);
  }

  Future<List> requestMusic({@required int count}) async {
    final Response<List> response = await dio.post(
      'http://y.webzcz.cn/api.php',
      data: FormData.fromMap({
        'types': 'search',
        'count': count,
        'source': 'kugou',
        'name': 'chillhop',
        'pages': 1
      }),
      options: Options(
        headers: {
          'Content-Type':
              'multipart/form-data; boundary=<calculated when request is sent>',
          'Content-Length': '<calculated when request is sent>',
          'User-Agent': POST_MAN
        },
      ),
    );
    return response.data;
  }

  Future<Map> searchMusic({@required String playID, String searchType}) async {
    final Response<Map> response = await dio.post(
      'http://y.webzcz.cn/api.php',
      data: FormData.fromMap({
        'types': 'url',
        'id': playID,
        'source': searchType ?? 'kugou',
      }),
      options: Options(
        headers: {
          'Content-Type':
              'multipart/form-data; boundary=<calculated when request is sent>',
          'Content-Length': '<calculated when request is sent>',
          'User-Agent': POST_MAN
        },
      ),
    );
    return response.data;
  }

  Future<GirlGank> getGirlPicGank({int count, int page}) async {
    final response = await Dio(
      BaseOptions(baseUrl: GIRL_GANK),
    ).get('$page/count/$count');
    return GirlGank.fromJson(response.data);
  }
}
