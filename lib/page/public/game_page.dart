import 'dart:math' show Random, sqrt;
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
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors/sensors.dart';
import 'package:toast/toast.dart';
import '../../model/event/drawer_nav_bloc.dart';

class GamePage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var random = Random();
  double pos = 0.0;

  final relativeRectTween = RelativeRectTween(
    begin: RelativeRect.fromLTRB(40, 40, 0, 0),
    end: RelativeRect.fromLTRB(0, 0, 40, 40),
  );

  AnimationController _posCtrl;
  AnimationController _scaleCtrl;
  AnimationController _fadeCtrl;
  AnimationController _rotateCtrl;

  Animation<double> _scaleAnim;
  Animation<double> _fadeAnim;
  Animation<double> _rotateAnim;

  bool _first = true;
  int logoIndex = 0;
  double randomSize = 0.0;

  bool permission = false;

  checkPermit() async {
    var permit = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.sensors);
    if (permit != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.sensors]);
    } else {
      permission = true;
    }
  }

  @override
  void initState() {
    accelerometerEvents.listen((event) {
      // 摇一摇阀值,不同手机能达到的最大值不同，如某品牌手机只能达到20。
      int value = 10;
      if (event.x >= value ||
          event.x <= -value ||
          event.y >= value ||
          event.y <= -value ||
          event.z >= value ||
          event.z <= -value) {
        setState(() {
          getRanSize();
          refreshLayout();
        });
      }
    });
    setState(() {
      pos = 24 + random.nextInt(128).toDouble();
      getRanSize();
    });

    _posCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleCtrl = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      value: 0.1,
    );

    _rotateCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnim = CurvedAnimation(
      parent: _scaleCtrl,
      curve: Curves.slowMiddle,
    );

    _fadeAnim = Tween(begin: 0.0, end: 1.0).animate(_fadeCtrl);

    _rotateAnim = CurvedAnimation(
      parent: _rotateCtrl,
      curve: Curves.easeInOut,
    ).drive(Tween(begin: 0, end: 0.1));

    _scaleCtrl.forward();
    _fadeCtrl.forward();
    _rotateCtrl.repeat();

    super.initState();
  }

  double getRanSize() => randomSize = 48 + random.nextInt(66).toDouble();

  @override
  void dispose() {
    _posCtrl.dispose();
    _scaleCtrl.dispose();
    _fadeCtrl.dispose();
    _rotateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!permission) {
      checkPermit();
    }

    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).game,
      ),
      body: GestureDetector(
        child: Stack(
          children: [
            Positioned(
              top: sizeH(context) * .2,
              left: sizeW(context) * .1,
              child: GameLogo(
                fadeAnim: _fadeAnim,
                scaleAnim: _scaleAnim,
                index: random.nextInt(1) + logoIndex,
                randomSize: getRanSize(),
              ),
            ),
            Positioned(
              top: sizeH(context) * .4,
              left: sizeW(context) * .3,
              child: GameLogo(
                fadeAnim: _fadeAnim,
                scaleAnim: _scaleAnim,
                index: random.nextInt(2) + logoIndex,
                randomSize: getRanSize(),
              ),
            ),
            Positioned(
              top: sizeH(context) * .6,
              left: sizeW(context) * .3,
              child: GameLogo(
                fadeAnim: _fadeAnim,
                scaleAnim: _scaleAnim,
                index: random.nextInt(3) - logoIndex,
                randomSize: getRanSize(),
              ),
            ),
            Positioned(
              top: sizeH(context) * .1,
              right: sizeW(context) * .1,
              child: GameLogo(
                fadeAnim: _fadeAnim,
                scaleAnim: _scaleAnim,
                index: random.nextInt(3),
                randomSize: getRanSize(),
              ),
            ),
            Positioned(
              bottom: sizeH(context) * .1,
              left: sizeW(context) * .05,
              child: GameLogo(
                fadeAnim: _fadeAnim,
                scaleAnim: _scaleAnim,
                index: random.nextInt(3),
                randomSize: getRanSize(),
              ),
            ),
            Positioned(
              bottom: sizeH(context) * .3,
              right: sizeW(context) * .05,
              child: GameLogo(
                fadeAnim: _fadeAnim,
                scaleAnim: _scaleAnim,
                index: random.nextInt(3),
                randomSize: getRanSize(),
              ),
            ),
            Positioned(
              bottom: sizeH(context) * .5,
              right: sizeW(context) * .03,
              child: GameLogo(
                fadeAnim: _fadeAnim,
                scaleAnim: _scaleAnim,
                index: random.nextInt(3),
                randomSize: getRanSize(),
              ),
            ),
            Positioned(
              bottom: 8.0,
              right: 8.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    refreshLayout();
                  });
                },
                child: RotationTransition(
                  turns: _rotateAnim,
                  child: SvgPicture.asset(
                    path('shake', 5),
                    width: 64.0,
                  ),
                ),
              ),
            ),
            /* Positioned(
              bottom: 8.0,
              right: 8.0,
              child: InkWell(
                child: SvgPicture.asset(path('refresh', 3)),
                onTap: () {
                  refreshLayout();
                },
              ),
            ), */
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void refreshLayout() {
    getRanSize();
    pos = 24 + random.nextInt(128).toDouble();
    logoIndex = random.nextInt(1);
    if (_first) {
      _posCtrl.forward();
      _fadeCtrl.forward();
      _scaleCtrl.forward();
      Future.delayed(Duration(seconds: 1), () {
        _scaleCtrl.resync(this);
        _fadeCtrl.resync(this);
      });
    } else {
      _posCtrl.reverse();
      _fadeCtrl.reverse();
      _scaleCtrl.reverse();
      Future.delayed(Duration(seconds: 1), () {
        _scaleCtrl.forward();
        _fadeCtrl.forward();
      });
    }
    _first = !_first;
  }
}

class GameLogo extends StatelessWidget {
  const GameLogo({
    @required Animation<double> fadeAnim,
    @required Animation<double> scaleAnim,
    @required this.index,
    this.randomSize,
  })  : _fadeAnim = fadeAnim,
        _scaleAnim = scaleAnim;

  final Animation<double> _fadeAnim;
  final Animation<double> _scaleAnim;
  final int index;
  final double randomSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            pushName(context, game2048);
            break;
          case 1:
            pushName(context, game_tetris);
            break;
          case 2:
            pushName(context, game_snake);
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
      child: FadeTransition(
        opacity: _fadeAnim,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: covers[index],
              width: randomSize ?? 128.0,
              height: randomSize ?? 128.0,
              fit: BoxFit.cover,
              placeholder: (_, __) => Center(
                child: RefreshProgressIndicator(),
              ),
              errorWidget: (_, __, ___) => errorLoad(
                context,
                height: sizeH(context) * .2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
