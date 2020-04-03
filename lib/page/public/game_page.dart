import 'dart:math' show Random;
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/model/i18n/i18n.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:sensors/sensors.dart';
import 'package:toast/toast.dart';
import '../../model/event/drawer_nav_bloc.dart';

class GamePage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  @override
  void initState() {
    accelerometerEvents.listen((event) {
      int value = 15; // 摇一摇阀值, 值越大越迟钝
      if (event.x >= value ||
          event.x <= -value ||
          event.y >= value ||
          event.y <= -value ||
          event.z >= value ||
          event.z <= -value) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).game,
      ),
      body: Stack(
        children: [],
      ),
    );
  }
}

class GameLogo extends StatelessWidget {
  const GameLogo({this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            pushName(context, game2048);
            break;
          case 1:
            pushName(context, tetris);
            break;
          case 2:
            pushName(context, snake);
            break;
          default:
        }
      },
      onLongPress: () {
        switch (index) {
          case 0:
            Toast.show('2048小游戏', context);
            break;
          case 1:
            Toast.show('俄罗斯方块', context);
            break;
          case 2:
            Toast.show('经典贪吃蛇', context);
            break;
          default:
        }
      },
      child: Container(
        width: 32.0,
        height: 32.0,
        child: netPic(pic: ''),
      ),
    );
  }
}
