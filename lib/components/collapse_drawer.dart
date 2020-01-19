import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/components/radial_menu.dart';
import 'package:fun_refresh/model/data/theme.dart';
import '../model/i18n/i18n.dart';
import '../model/i18n/lang_kv.dart';
import 'package:fun_refresh/model/smash_model.dart';
import 'package:fun_refresh/page/routes/route_generator.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/pic_tool.dart';

class CollaplseDrawer extends StatefulWidget {
  @override
  createState() => _CollaplseDrawerState();
}

class _CollaplseDrawerState extends State<CollaplseDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 256.0;
  double minWidth = 70.0;
  bool isCollapse = false;
  AnimationController _animationController;
  Animation<double> _widthAnim;
  int currentIndex = 0;
  get drawerMenuItems => [
        ItemD(
          title: I18n.of(context).social,
          iconPath: iconX('connection'),
        ),
        ItemD(
          title: I18n.of(context).mind,
          iconPath: iconX('idea'),
        ),
        ItemD(
          title: I18n.of(context).reward,
          iconPath: iconX('reward'),
        ),
        ItemD(
          title: I18n.of(context).setting,
          iconPath: iconX('settings'),
        )
      ];
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 233));
    _widthAnim = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => _buildDrawerContent(context, child),
      );

  _buildDrawerContent(context, child) => Container(
        width: _widthAnim.value,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.cyan[300],
          Colors.lightBlue[400],
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 48.0),
            CustomDrawerHeader(animationController: _animationController),
            Expanded(
              child: ListView.builder(
                itemCount: drawerMenuItems.length,
                itemBuilder: (context, index) => DrawerItem(
                  onTap: () => setState(() {
                    switch (index) {
                      case 0:
                        pushNamed(context, '/social');
                        break;
                      case 1:
                        pushNamed(context, '/mind');
                        break;
                      case 2:
                        pushNamed(context, '/reward');
                        break;
                      case 3:
                        pushNamed(context, '/setting');
                        break;
                    }

                    return currentIndex = index;
                  }),
                  isSelected: currentIndex == index,
                  title: drawerMenuItems[index].title,
                  iconPath: drawerMenuItems[index].iconPath,
                  animationController: _animationController,
                ),
              ),
            ),
            RadialMenu(),
            CupertinoButton(
              child: Text(I18n.of(context).zh),
              onPressed: () => i18nKey.currentState.toggleLanguage(chinese),
            ),
            CupertinoButton(
              child: Text(I18n.of(context).ja),
              onPressed: () => i18nKey.currentState.toggleLanguage(japanese),
            ),
            CupertinoButton(
              child: Text(I18n.of(context).en),
              onPressed: () => i18nKey.currentState.toggleLanguage(english),
            ),
            IconButton(
              icon: AnimatedIcon(
                size: 28.0,
                icon: AnimatedIcons.close_menu,
                progress: _animationController,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isCollapse = !isCollapse;
                  isCollapse
                      ? _animationController.forward()
                      : _animationController.reverse();
                });
              },
            ),
            SizedBox(height: 48.0),
          ],
        ),
      );
}

class CustomDrawerHeader extends StatefulWidget {
  final AnimationController animationController;
  CustomDrawerHeader({this.animationController});
  @override
  createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  Animation<double> widthAnim, sizedBoxAnim;

  @override
  void initState() {
    super.initState();
    widthAnim = Tween<double>(begin: 220.0, end: 70.0)
        .animate(widget.animationController);
    sizedBoxAnim =
        Tween<double>(begin: 8.0, end: 0.0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => pushNamed(context, '/sign'),
        borderRadius: BorderRadius.circular(32.0),
        child: Container(
          height: 124.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    width: widthAnim.value,
                    child: Row(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999.0)),
                          color: Colors.transparent,
                          elevation: 0.0,
                          child: Image.network(
                            isGoogleLoginSuccess == false
                                ? GIRL
                                : googleUser.photoUrl,
                            width: 52.0,
                            height: 52.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: sizedBoxAnim.value),
                        widthAnim.value >= 220.0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      isGoogleLoginSuccess == false
                                          ? I18n.of(context).userName
                                          : googleUser.displayName,
                                      style: whiteTxT),
                                  Text(
                                      isGoogleLoginSuccess == false
                                          ? 'xxxx@gmail.com'
                                          : googleUser.email,
                                      style: whiteTxT),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              widthAnim.value <= 70.0
                  ? IconButton(
                      icon: Icon(Icons.more_vert,
                          color: Colors.white, size: 28.0),
                      onPressed: () {},
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Icon(Icons.ac_unit, color: Colors.white),
                    ),
            ],
          ),
        ),
      );
}

class DrawerItem extends StatefulWidget {
  DrawerItem(
      {@required this.title,
      @required this.iconPath,
      @required this.animationController,
      this.isSelected = false,
      this.onTap});
  final String title;
  final String iconPath;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  @override
  createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  Animation<double> widthAnim, sizedBoxAnim;

  @override
  void initState() {
    super.initState();
    widthAnim = Tween<double>(begin: 220.0, end: 60.0)
        .animate(widget.animationController);
    sizedBoxAnim =
        Tween<double>(begin: 8.0, end: 0.0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: widget.onTap,
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          width: widthAnim.value,
          decoration: BoxDecoration(
              color: widget.isSelected
                  ? Colors.transparent.withOpacity(0.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16.0)),
          child: Row(
            children: [
              SvgPicture.asset(widget.iconPath, width: 32.0, height: 32.0),
              SizedBox(width: sizedBoxAnim.value),
              widthAnim.value >= 220.0
                  ? Text(widget.title,
                      style: widget.isSelected ? drawerTxT1 : drawerTxT0)
                  : Container()
            ],
          ),
        ),
      );
}
