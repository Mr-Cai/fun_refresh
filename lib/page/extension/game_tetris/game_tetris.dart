import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './gamer/gamer.dart';
import './generated/i18n.dart';
import './material/audios.dart';
import './panel/page_portrait.dart';
import './gamer/keyboard.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class GameTetris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tetris',
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
    //only Android/iOS support land mode
    bool supportLandMode = Platform.isAndroid || Platform.isIOS;
    bool land = supportLandMode &&
        MediaQuery.of(context).orientation == Orientation.landscape;
    return land ? PageLand() : PagePortrait();
  }
}
