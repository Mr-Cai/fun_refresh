import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import '../tools/global.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({
    Key key,
    this.title,
    this.themeColor,
    this.actions,
    this.bgColor,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
    this.isMenu = false,
    this.isGradient,
    this.isSafeArea = true,
  }) : super(key: key);

  final String title;
  final Color themeColor;
  final Color bgColor;
  final List<Widget> actions;
  final bool isMenu;
  final bool isGradient;
  final bool isSafeArea;

  @override
  State<StatefulWidget> createState() => _TopBarState();

  @override
  final Size preferredSize;
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return widget.isSafeArea
        ? SafeArea(
            minimum: const EdgeInsets.symmetric(vertical: 12.0),
            child: buildTopBar(context),
          )
        : buildTopBar(context, isSafeArea: widget.isSafeArea);
  }

  Widget buildTopBar(BuildContext context, {bool isSafeArea = true}) {
    return Container(
      padding: EdgeInsets.only(
        top: !isSafeArea ? 22.0 : 0.0,
      ),
      decoration: BoxDecoration(
        color: widget.bgColor == null && widget.isGradient == false
            ? Colors.transparent
            : widget.bgColor,
        gradient: widget.isGradient == true
            ? LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Colors.lightBlueAccent,
                  Colors.cyan,
                  Colors.greenAccent,
                ],
                transform: GradientRotation(20.0),
              )
            : null,
      ),
      child: Stack(
        children: [
          Align(
            child: Text(
              widget.title ?? '标题',
              style: TextStyle(
                fontSize: 24.0,
                color: widget.themeColor ?? Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.actions ?? [Container()],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: menuIcon(
              context,
              icon: widget.isMenu ? 'finger_print' : 'back',
              color: widget.themeColor,
              size: widget.isMenu ? 32.0 : 26.0,
              onTap: () {
                setState(() {
                  statusBar(status: 1);
                });
                widget.isMenu
                    ? scaffoldKey.currentState.openDrawer()
                    : pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget menuIcon(
  BuildContext context, {
  @required String icon,
  Color color,
  Function onTap,
  double size,
}) {
  return InkWell(
    onTap: onTap ?? () => pop(context),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: Container(
      margin: const EdgeInsets.only(left: 16.0, top: 2.0),
      child: SvgPicture.asset(
        path('$icon', 5),
        color: color ?? Colors.black,
        width: size ?? 30.0,
        height: size ?? 30.0,
      ),
    ),
  );
}
