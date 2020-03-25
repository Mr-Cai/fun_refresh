import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:permission_handler/permission_handler.dart';
import './tools/global.dart' show ctxKey, portrait, splashAD, statusBar;
import './model/i18n/i18n.dart';
import './page/routes/route_generator.dart';

void main() {
  splashAD();
  runApp(FunRefreshApp());
}

class FunRefreshApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FunRefreshAppState();
}

class _FunRefreshAppState extends State<FunRefreshApp> {
  StreamSubscription connectSubs;
  ConnectivityResult _prevResult;
  bool permission = false;

  @override
  void initState() {
    statusBar();
    portrait();
    connectSubs = Connectivity().onConnectivityChanged.listen(
      (result) {
        if (result == ConnectivityResult.none) {
          pushName(context, '', args: {
            'name': 'disconnect',
            'anim': 'no_connection',
            'desc': '网络连接已断开，请检查配置！！',
            'title': '网络异常'
          });
        } else if (_prevResult == ConnectivityResult.none) {
          pushReplace(context, '/');
        }
        _prevResult = result;
      },
    );
    // checkPermit();
    super.initState();
  }

  void checkPermit() async {
    var permit = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.sensors);
    if (permit != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.sensors]);
    } else {
      permission = true;
    }
  }

  @override
  void dispose() {
    connectSubs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!permission) {
      checkPermit();
    }
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
