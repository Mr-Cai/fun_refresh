import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fun_refresh/tools/global.dart';
import './model/i18n/i18n.dart';
import './page/routes/route_generator.dart';
import 'package:tencent_ad/tencent_ad.dart';

import 'model/data/local_asset.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TencentAD.config(appID: config['appID']);
  runApp(FunRefreshApp());
}

class FunRefreshApp extends StatefulWidget {
  @override
  _FunRefreshAppState createState() => _FunRefreshAppState();
}

class _FunRefreshAppState extends State<FunRefreshApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    imageCache.clear();
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
      ],
      supportedLocales: [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
    );
  }
}
