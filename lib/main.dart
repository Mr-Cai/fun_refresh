import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import './tools/global.dart';
import './model/i18n/i18n.dart';
import './page/routes/route_generator.dart';
import 'package:tencent_ad/tencent_ad.dart';

import 'model/data/local_asset.dart';

Future<void> main() async {
  BaseOptions options = BaseOptions(
    baseUrl: 'https://www.google.com',
    connectTimeout: 999,
    receiveTimeout: 999,
  );
  Dio dio = Dio(options);
  String splashID = '';
  try {
    await dio.get('');
    splashID = null;
  } on DioError catch (_) {
    // 请求谷歌超时说明是大陆网络, 配置开屏, 海外不配置
    splashID = config['splashID'];
  }
  WidgetsFlutterBinding.ensureInitialized();
  TencentAD.config(appID: config['appID'], phoneSTAT: 0, fineLOC: 0).then(
    (_) => SplashAd(splashID, bgPic: config['bgPic'], callBack: (event, args) {
      switch (event) {
        case SplashAdEvent.onAdExposure:
        case SplashAdEvent.onAdPresent:
          return SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.bottom], // 隐藏状态栏
          );
          break;
        case SplashAdEvent.onAdClosed:
        case SplashAdEvent.onAdDismiss:
        case SplashAdEvent.onNoAd:
          return SystemChrome.setEnabledSystemUIOverlays(
              [SystemUiOverlay.values[0]]); // 显示状态栏
        default:
          return SystemChrome.setEnabledSystemUIOverlays(
              [SystemUiOverlay.values[0]]);
      }
    }).showAd(),
  );
  runApp(FunRefreshApp());
}

class FunRefreshApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FunRefreshAppState();
}

class _FunRefreshAppState extends State<FunRefreshApp> {
  StreamSubscription connectSubs;
  ConnectivityResult _prevResult;

  @override
  void initState() {
    connectSubs = Connectivity().onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.none) {
          pushName(context, '', args: {'type': 'disconnect'});
        } else if (_prevResult == ConnectivityResult.none) {
          pushReplace(context, home);
        }
        _prevResult = result;
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    connectSubs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generator,
      navigatorKey: ctxKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        I18nDelegate.i18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
    );
  }

}
