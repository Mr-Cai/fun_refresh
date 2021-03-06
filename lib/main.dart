import 'dart:async';
import 'package:camera/camera.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import './tools/global.dart' show cameras, ctxKey, portrait, statusBar;
import './pages/routes/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generator,
          navigatorKey: ctxKey,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('zh', 'CH'),
            const Locale('en', 'US')
          ]),
    );
  }
}
