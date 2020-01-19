import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/marquee.dart';
import '../model/i18n/i18n.dart';
import 'package:fun_refresh/tools/global.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  GradientAppBar(
      {this.bottom,
      this.dy: 2.0,
      @required this.context,
      this.title,
      this.actions,
      this.showBTN,
      bool centerTitle});
  final Widget bottom;
  final double dy;
  final BuildContext context;
  final String title;
  final List<Widget> actions;
  final bool showBTN;
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(bottom: dy),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.cyan[300],
            Colors.lightBlue[500],
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              showBTN == null
                  ? Navigator.pop(context)
                  : scaffoldKey.currentState.openDrawer();
            },
            icon:
                Icon(showBTN == null ? CupertinoIcons.back : Icons.fingerprint),
          ),
          centerTitle: true,
          titleSpacing: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          bottom: bottom,
          title: title != null
              ? Text(
                  title,
                  textScaleFactor: 0.7,
                )
              : SearchView(),
          actions: actions ??
              [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera, color: Colors.white),
                ),
              ],
        ),
      );

  @override
  get preferredSize => Size.fromHeight(MediaQuery.of(context).padding.top * dy);
}

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
        elevation: 0.0,
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Icon(CupertinoIcons.search, color: Colors.black45),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 3,
                child: Marquee(
                  textColor: Colors.black,
                  textList: [
                    I18n.of(context).searchHint,
                    I18n.of(context).searchHint,
                    I18n.of(context).searchHint,
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
