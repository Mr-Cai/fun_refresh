import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([]);
    super.initState();
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