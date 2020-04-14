import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import '../model/mock/smash_model.dart';
import '../model/event/drawer_nav_bloc.dart';
import '../components/radial_menu.dart';
import '../components/theme.dart';
import '../pages/routes/route_generator.dart';
import '../tools/global.dart';

class CollaplseDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CollaplseDrawerState();
}

class _CollaplseDrawerState extends State<CollaplseDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = sizeW(ctxKey.currentContext) * 0.63; // 展开宽度
  double minWidth = sizeW(ctxKey.currentContext) * 0.22; // 折叠宽度

  bool isCollapse = false; // 默认不展开

  AnimationController _animCtrl;
  Animation<double> _widthAnim;
  int currentIndex = 0;
  NavigationBloc bloc;

  List<ItemD> get drawerMenuItems => [
        ItemD(title: '人脉', iconPath: path('connection', 5)),
        ItemD(title: '想法', iconPath: path('idea', 5)),
        ItemD(title: '奖励', iconPath: path('reward', 5)),
        ItemD(title: '设置', iconPath: path('settings', 5))
      ];

  @override
  void initState() {
    _animCtrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 233));
    _widthAnim =
        Tween<double>(begin: maxWidth, end: minWidth).animate(_animCtrl);
    super.initState();
  }

  @override
  void dispose() {
    switch (currentIndex) {
      case 0:
        statusBar(status: 0);
        break;
      default:
        statusBar(status: 1);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    statusBar(status: 1);
    return AnimatedBuilder(
      animation: _animCtrl,
      builder: (context, child) {
        return _buildDrawerContent(context, child);
      },
    );
  }

  Widget _buildDrawerContent(context, child) => Container(
        width: _widthAnim.value,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.cyan,
              Colors.lightBlue,
              Colors.teal,
            ],
            stops: [
              0.1,
              0.6,
              1.0,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(child: SizedBox(height: 18.0)),
            CustomDrawerHeader(
              animationController: _animCtrl,
              maxWidth: maxWidth,
              minWidth: minWidth,
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: drawerMenuItems.length,
                itemBuilder: (context, index) => DrawerItem(
                  maxWidth: maxWidth,
                  minWidth: minWidth,
                  onTap: () => setState(() {
                    _animCtrl.forward();
                    bloc = BlocProvider.of<NavigationBloc>(context);
                    switch (index) {
                      case 0:
                        bloc.add(NavigationEvent.social);
                        break;
                      case 1:
                        bloc.add(NavigationEvent.mind);
                        break;
                      case 2:
                        bloc.add(NavigationEvent.reward);
                        break;
                      case 3:
                        bloc.add(NavigationEvent.setting);
                        break;
                    }
                    return currentIndex = index;
                  }),
                  isSelected: currentIndex == index,
                  title: drawerMenuItems[index].title,
                  iconPath: drawerMenuItems[index].iconPath,
                  animationController: _animCtrl,
                ),
              ),
            ),
            RadialMenu(),
            IconButton(
              icon: AnimatedIcon(
                size: 28.0,
                icon: AnimatedIcons.close_menu,
                progress: _animCtrl,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isCollapse = !isCollapse;
                  isCollapse ? _animCtrl.forward() : _animCtrl.reverse();
                });
              },
            ),
            SizedBox(height: 32.0),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white38,
                      customBorder: CircleBorder(),
                      child: Container(
                        margin: _widthAnim.value >= maxWidth
                            ? const EdgeInsets.all(16.0)
                            : const EdgeInsets.fromLTRB(20.0, 16.0, 16.0, 16.0),
                        child: SvgPicture.asset(
                          path('moon', 5),
                          width: 32.0,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  _widthAnim.value >= maxWidth
                      ? Material(
                          color: Colors.transparent,
                          shadowColor: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.white38,
                            customBorder: CircleBorder(),
                            child: Container(
                              margin: const EdgeInsets.all(16.0),
                              child: SvgPicture.asset(
                                path('help', 5),
                                width: 32.0,
                              ),
                            ),
                            onTap: () {},
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      );
}

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({
    this.animationController,
    this.maxWidth,
    this.minWidth,
  });

  final AnimationController animationController;
  final double maxWidth;
  final double minWidth;

  @override
  State<StatefulWidget> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  Animation<double> widthAnim, sizedBoxAnim;

  @override
  void initState() {
    super.initState();
    widthAnim = Tween<double>(
      begin: widget.maxWidth,
      end: widget.minWidth,
    ).animate(widget.animationController);

    sizedBoxAnim = Tween<double>(
      begin: 12.0,
      end: 0.0,
    ).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => pushName(context, sign),
          child: Container(
            margin: const EdgeInsets.fromLTRB(12.0, 0.0, 8.0, 0.0),
            width: widthAnim.value,
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    width: 68.0,
                    height: 68.0,
                    child: SvgPicture.asset(
                      path('user', 5),
                      fit: BoxFit.cover,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                ),
                SizedBox(width: sizedBoxAnim.value),
                widthAnim.value >= widget.maxWidth
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          freeTxT('用户名', color: Colors.white),
                          SizedBox(height: 8.0),
                          freeTxT('user@gmail.com', color: Colors.white),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0),
        widthAnim.value <= widget.minWidth
            ? Container(
                margin: const EdgeInsets.only(left: 8.0),
                alignment: Alignment.centerLeft,
                child: DropdownButton(
                  autofocus: true,
                  items: [Icons.more_vert, Icons.more_vert, Icons.more_vert]
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Icon(value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {},
                  underline: Container(),
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  widget.animationController.forward();
                },
                child: Container(
                  height: sizeH(context) * .04,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: DropdownButton(
                    autofocus: true,
                    items: [Icons.more_vert, Icons.more_vert, Icons.more_vert]
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Icon(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
                    underline: Container(),
                    icon: Icon(
                      Icons.ac_unit,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class DrawerItem extends StatefulWidget {
  DrawerItem({
    @required this.title,
    @required this.iconPath,
    @required this.animationController,
    this.isSelected = false,
    this.onTap,
    this.maxWidth,
    this.minWidth,
  });

  final String title;
  final String iconPath;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  final double maxWidth;
  final double minWidth;

  @override
  State<StatefulWidget> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  Animation<double> widthAnim, sizedBoxAnim;

  @override
  void initState() {
    super.initState();
    widthAnim = Tween<double>(begin: widget.maxWidth, end: widget.minWidth)
        .animate(widget.animationController);
    sizedBoxAnim =
        Tween<double>(begin: 8.0, end: 0.0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.fromLTRB(20.0, 8.0, 22.0, 8.0),
          decoration: BoxDecoration(
              color: widget.isSelected ? Colors.white30 : Colors.transparent,
              borderRadius: BorderRadius.circular(16.0)),
          child: Row(
            children: [
              SvgPicture.asset(widget.iconPath, width: 32.0, height: 32.0),
              SizedBox(width: sizedBoxAnim.value),
              widthAnim.value >= widget.maxWidth
                  ? Text(
                      widget.title,
                      style: widget.isSelected ? drawerTxT1 : drawerTxT0,
                    )
                  : Container()
            ],
          ),
        ),
      );
}
