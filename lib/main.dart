import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import './tools/global.dart' show ctxKey, portrait, statusBar;
import './pages/routes/route_generator.dart';

void main() {
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
    );
  }
}
