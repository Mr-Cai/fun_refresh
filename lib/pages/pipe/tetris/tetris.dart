import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fun_refresh/tools/global.dart';
import './gamer/gamer.dart';
import './generated/i18n.dart';
import './material/audios.dart';
import './panel/page_portrait.dart';
import './gamer/keyboard.dart';

final routeObserver = RouteObserver<ModalRoute>();

class Tetris extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  final bannerAd = createBannerAd(size: AdSize.smartBanner);

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    statusBar(isHide: true);
    bannerAd
      ..load()
      ..show(anchorOffset: 240.0);
    super.initState();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      navigatorObservers: [routeObserver],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Sound(
          child: Game(
            child: KeyboardController(
              child: TetrisPage(),
            ),
          ),
        ),
      ),
    );
  }
}

const SCREEN_BORDER_WIDTH = 3.0;

const BACKGROUND_COLOR = const Color(0xffefcc19);

class TetrisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool supportLandMode = Platform.isAndroid || Platform.isIOS;
    bool land = supportLandMode &&
        MediaQuery.of(context).orientation == Orientation.landscape;
    return land ? PageLand() : PagePortrait();
  }
}
