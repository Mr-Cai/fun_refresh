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
  Animation<double> _rotateAnim;

  Animation<RelativeRect> _rectAnim0;
  Animation<RelativeRect> _rectAnim1;
  Animation<RelativeRect> _rectAnim2;
  Animation<RelativeRect> _rectAnim3;
  Animation<RelativeRect> _rectAnim4;
  Animation<RelativeRect> _rectAnim5;
  Animation<RelativeRect> _rectAnim6;

  AnimationController _rectCtrl;
  AnimationController _rotateCtrl;

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
    initAnim();
    super.initState();
  }

  @override
  void dispose() {
    _rectCtrl.dispose();
    super.dispose();
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
        children: [
          PositionedTransition(
            rect: _rectAnim0,
            child: GameLogo(
              logo: covers[0],
              index: 0,
            ),
          ),
          PositionedTransition(
            rect: _rectAnim1,
            child: GameLogo(
              logo: covers[1],
              index: 1,
            ),
          ),
          PositionedTransition(
            rect: _rectAnim2,
            child: GameLogo(
              logo: covers[2],
              index: 2,
            ),
          ),
          PositionedTransition(
            rect: _rectAnim3,
            child: GameLogo(
              logo: covers[3],
              index: 3,
            ),
          ),
          PositionedTransition(
            rect: _rectAnim4,
            child: GameLogo(
              logo: covers[4],
              index: 4,
            ),
          ),
          PositionedTransition(
            rect: _rectAnim5,
            child: GameLogo(
              logo: covers[5],
              index: 5,
            ),
          ),
          PositionedTransition(
            rect: _rectAnim6,
            child: GameLogo(
              logo: covers[6],
              index: 6,
            ),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: GestureDetector(
              onTap: () {
                _rectCtrl.reset();
                _rectCtrl.forward();
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
        ],
      ),
    );
  }

  void initAnim() {
    double p = 100.0;

    _rectCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _rotateCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _rectAnim0 = RelativeRectTween(
      begin: RelativeRect.fromLTRB(p * 3, p * 5.26, p * 3, p * 5.26),
      end: RelativeRect.fromLTRB(p * 1.5, p * 2.63, p * 1.5, p * 2.63),
    ).animate(_rectCtrl);

    _rectAnim1 = RelativeRectTween(
      begin: RelativeRect.fromLTRB(p * 2, p * 2, p * 2, p * 5),
      end: RelativeRect.fromLTRB(p, p, p * 2, p * 4.3),
    ).animate(_rectCtrl);

    _rectAnim2 = RelativeRectTween(
      begin: RelativeRect.fromLTRB(p * 2, 0.0, p, p * 5),
      end: RelativeRect.fromLTRB(p * 2.5, 0.0, p * .2, p * 5),
    ).animate(_rectCtrl);

    _rectAnim3 = RelativeRectTween(
      begin: RelativeRect.fromLTRB(p, p * 2, p * 2, p * 5),
      end: RelativeRect.fromLTRB(p * .2, 0.0, p * 2.8, p * 5.3),
    ).animate(_rectCtrl);

    _rectAnim4 = RelativeRectTween(
      begin: RelativeRect.fromLTRB(p * 2, p * 2, p * 2, p * 5),
      end: RelativeRect.fromLTRB(p * .1, p * 5.2, p * 2.9, p * .1),
    ).animate(_rectCtrl);

    _rectAnim5 = RelativeRectTween(
      begin: RelativeRect.fromLTRB(p, p, p, p),
      end: RelativeRect.fromLTRB(p * 2.6, p * 4, p * .1, p),
    ).animate(_rectCtrl);

    _rectAnim6 = RelativeRectTween(
      begin: RelativeRect.fromLTRB(p, p, p, p),
      end: RelativeRect.fromLTRB(p * 1.3, p * 4, p * 1.4, p),
    ).animate(_rectCtrl);

    _rectCtrl.forward();
    _rotateCtrl.repeat();

    _rotateAnim = CurvedAnimation(
      parent: _rotateCtrl,
      curve: Curves.easeInOut,
    ).drive(Tween(begin: 0, end: 0.1));
  }
}

class GameLogo extends StatelessWidget {
  const GameLogo({this.index, this.logo});

  final int index;
  final String logo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            pushName(context, dinosaur_run);
            break;
          case 1:
            pushName(context, flappy_bird);
            break;
          case 2:
            pushName(context, snake);
            break;
          case 3:
            pushName(context, game2048);
            break;
          case 4:
            pushName(context, tetris);
            break;
          case 5:
            pushName(context, sudoku);
            break;
          case 6:
            pushName(context, bejeweled);
            break;
          default:
        }
      },
      onLongPress: () {
        switch (index) {
          case 0:
            Toast.show('像素恐龙', context);
            break;
          case 1:
            Toast.show('像素鸟', context);
            break;
          case 2:
            Toast.show('经典贪吃蛇', context);
            break;
          case 3:
            Toast.show('2048小游戏', context);
            break;
          case 4:
            Toast.show('俄罗斯方块', context);
            break;
          case 5:
            Toast.show('数独', context);
            break;
          case 6:
            Toast.show('宝石迷阵', context);
            break;
          default:
        }
      },
      child: ClipOval(
        child: netPic(pic: logo, holder: Container()),
      ),
    );
  }
}
