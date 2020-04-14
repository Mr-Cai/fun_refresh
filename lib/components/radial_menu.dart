import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../tools/global.dart';
import 'package:vector_math/vector_math.dart' show radians;

class RadialMenu extends StatefulWidget {
  RadialMenu({this.size = 24.0});
  final double size;
  State<StatefulWidget> createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this)
          ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(iconWidth: widget.size, controller: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({this.iconWidth, this.controller})
      : translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.elasticOut),
        ),
        scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.7,
              curve: Curves.decelerate,
            ),
          ),
        );

  final AnimationController controller;
  final Animation<double> rotation;
  final Animation<double> translation;
  final Animation<double> scale;
  final double iconWidth;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          return Transform.rotate(
              angle: radians(rotation.value),
              child: Stack(alignment: Alignment.center, children: [
                _buildButton(-135, icon: 'china', index: 0),
                _buildButton(-90, icon: 'japan', index: 1),
                _buildButton(-45, icon: 'us', index: 2),
                // i18nKey.currentState.toggleLanguage(japanese)
                Transform.scale(
                  scale: scale.value - 1.5,
                  child: CupertinoButton(
                    child: SvgPicture.asset(
                      path('earth', 5),
                      width: iconWidth,
                    ),
                    onPressed: _close,
                  ),
                ),
                Transform.scale(
                  scale: scale.value,
                  child: InkWell(
                    onTap: _open,
                    child: SvgPicture.asset(
                      path('language', 5),
                      width: iconWidth,
                    ),
                  ),
                ),
              ]));
        });
  }

  _open() => controller.forward();

  _close() => controller.reverse();

  Widget _buildButton(double angle, {String icon, int index}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad),
        ),
      child: IconButton(
        icon: SvgPicture.asset(
          path(icon, 5),
          width: iconWidth,
        ),
        onPressed: () {},
      ),
    );
  }
}
