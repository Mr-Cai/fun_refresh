import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../page/export_page_pkg.dart';
import '../tools/global.dart';
import '../tools/pic_tool.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({
    Key key,
    this.title,
    this.titleColor,
    this.actions,
    this.iconColor,
    this.fontSize,
    this.left,
    this.right,
    this.bgColor,
    this.top,
    this.bottom,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
    this.isMenu = false,
  }) : super(key: key);

  final String title;
  final Color titleColor;
  final Color iconColor;
  final Color bgColor;
  final double fontSize;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final List<Widget> actions;
  final bool isMenu;

  @override
  _TopBarState createState() => _TopBarState();

  @override
  final Size preferredSize;
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.top ?? sizeH$2(context),
        bottom: widget.bottom ?? 0.0,
      ),
      color: widget.bgColor ?? Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.isMenu
              ? menuBTN(context, color: widget.iconColor)
              : backBTN(context, color: widget.iconColor),
          Container(
            margin: EdgeInsets.only(
              left: widget.left ?? 0.0,
              right: widget.right ?? sizeW$15(context),
            ),
            child: Text(
              widget.title ?? '标题',
              style: TextStyle(
                fontSize: widget.fontSize ?? 24.0,
                color: widget.titleColor ?? Colors.white,
                fontWeight: FontWeight.values[0],
              ),
            ),
          ),
          widget.actions != null
              ? Container(
                  margin: EdgeInsets.only(right: sizeW$1(context) * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.actions,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

Widget backBTN(
  BuildContext context, {
  double height,
  double width,
  Color color,
}) {
  return Container(
    margin: EdgeInsets.all(12.0),
    width: width ?? sizeW$10(context),
    child: IconButton(
      icon: SvgPicture.asset(
        iconX('back'),
        color: color ?? Colors.white,
      ),
      iconSize: sizeW$8(context),
      onPressed: () => pop(context),
    ),
  );
}

Widget menuBTN(
  BuildContext context, {
  double height,
  double width,
  Color color,
}) {
  return Container(
    margin: EdgeInsets.all(12.0),
    width: width ?? sizeW$10(context),
    child: IconButton(
      icon: SvgPicture.asset(
        iconX('app'),
        color: color ?? Colors.white,
      ),
      iconSize: sizeW$8(context),
      onPressed: () {
        scaffoldKey.currentState.openDrawer();
      },
    ),
  );
}