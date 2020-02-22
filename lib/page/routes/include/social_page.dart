import 'dart:math';

import 'package:flutter/material.dart';
import '../../../components/particle/ball.dart';
import '../../../components/particle/float_ball.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../model/i18n/i18n.dart';
import '../../../components/top_bar.dart';

class SocialPage extends StatefulWidget with NavigationState {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> with TickerProviderStateMixin {
  var _ballsF = <Ball>[];
  var _areaF = Rect.fromLTRB(0 + 20.0, 0, 370 + 20.0, 0 + 200.0);
  AnimationController controllerG; // 控制粒子贝塞尔轨迹
  Animation animation;

  @override
  void initState() {
    controllerG = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..addListener(() {
        _renderBezier();
      });
    animation = CurvedAnimation(parent: controllerG, curve: Curves.linear);
    animation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          controllerG.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.completed:
          controllerG.reverse();
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(
        title: I18n.of(context).social,
        themeColor: Colors.black,
        isMenu: true,
      ),
      body: InkWell(
        child: Container(
          width: double.infinity,
          height: 200,
          child: CustomPaint(
            painter: FloatBallView(_ballsF, _areaF),
          ),
        ),
        onTap: () {
          controllerG.forward();
        },
        onDoubleTap: () {
          controllerG.stop();
        },
      ),
    );
  }

  void _renderBezier() {
    setState(() {
      _ballsF.forEach((ball) {
        bezierPath(ball, animation.value);
      });
    });
  }

  //贝塞尔曲线路径
  void bezierPath(Ball ball, double t) {
    // (1 - t) * (1 - t) * p0 + 2 * t * (1 - t) * p1 + t * t * p2
    Offset p0 = Offset(ball.x, ball.y);
    Offset p1 = _randPosition(ball.id);

    Offset p2 = _randPosition(ball.id + 1);
    var bx =
        (1 - t) * (1 - t) * p0.dx + 2 * t * (1 - t) * p1.dx + t * t * p2.dx;
    var by =
        (1 - t) * (1 - t) * p0.dy + 2 * t * (1 - t) * p1.dy + t * t * p2.dy;
    ball.x = bx;
    ball.y = by;
  }

  //随机生成圆心坐标
  Offset _randPosition([int seed]) {
    var random;
    if (seed != null) {
      random = Random(seed);
    } else {
      random = Random();
    }

    var x = 36 + random.nextInt(339);
    var y = 16 + random.nextInt(169);
    return Offset(x.toDouble(), y.toDouble());
  }
}
