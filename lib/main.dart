import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './model/i18n/i18n.dart';
import 'package:fun_refresh/page/routes/route_generator.dart';
import 'package:tencent_ad/tencent_ad.dart';

import 'model/data/local_asset.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TencentAD.config(appID: config['appID']);
  runApp(FunRefreshApp());
}

class FunRefreshApp extends StatefulWidget {
  @override
  createState() => _FunRefreshAppState();
}

class _FunRefreshAppState extends State<FunRefreshApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light));
    super.initState();
  }

  @override
  build(BuildContext context) {
    imageCache.clear();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generator,
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
