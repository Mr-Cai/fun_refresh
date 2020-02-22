import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../page/export_page_pkg.dart';
import '../tools/global.dart';
import '../tools/pic_tool.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({
    Key key,
    this.title,
    this.themeColor,
    this.actions,
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
  final Color themeColor;
  final Color bgColor;
  final double fontSize;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final List<Widget> actions;
  final bool isMenu;

  @override
  State<StatefulWidget> createState() => _TopBarState();

  @override
  final Size preferredSize;
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.top ?? 16.0,
        bottom: widget.bottom ?? 0.0,
      ),
      color: widget.bgColor ?? Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.isMenu
              ? menuBTN(context, color: widget.themeColor)
              : backBTN(context, color: widget.themeColor),
          Container(
            margin: EdgeInsets.only(
              top: 4.0,
              left: widget.left ?? 0.0,
              right: widget.right ?? sizeW(context) * .16,
              bottom: 2.0,
            ),
            child: Text(
              widget.title ?? '标题',
              style: TextStyle(
                fontSize: widget.fontSize ?? 24.0,
                color: widget.themeColor ?? Colors.white,
                fontWeight: FontWeight.values[0],
              ),
            ),
          ),
          widget.actions != null
              ? Container(
                  margin: EdgeInsets.only(right: 8.0),
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
    color: Colors.transparent,
    margin: EdgeInsets.all(12.0),
    child: IconButton(
      icon: SvgPicture.asset(
        iconX('back'),
        color: color ?? Colors.white,
        width: 26.0,
        height: 26.0,
      ),
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
    margin: const EdgeInsets.fromLTRB(18.0, 16.0, 0.0, 12.0),
    child: IconButton(
      icon: Icon(Icons.fingerprint, size: 32.0, color: color),
      onPressed: () {
        scaffoldKey.currentState.openDrawer();
      },
    ),
  );
}
