import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../components/anchor_bar.dart';
import '../../components/collapse_drawer.dart';
import '../../components/marquee.dart';
import '../../model/smash_model.dart';
import '../../model/weather/he_weather.dart';
import '../../tools/net_tool.dart';
import '../../tools/api.dart';
import '../../tools/global.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNav = 0;
  final _marqueeController = MarqueeController();
  Orientation orientation;
  bool isToggle = false;
  InkWell centerFace;

  @override
  void initState() {
    statusBar();
    portrait();
    judgeShowPrivacy(context);
    centerFace = initCenterFace(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape
        ? bank(context)
        : BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.white,
              drawer: CollaplseDrawer(),
              body: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  return state as Widget;
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: centerFace,
              bottomNavigationBar: AnchorBar(
                notchedShape: CircularNotchedRectangle(),
                notchMargin: -3.0,
                items: _getNavItemsBTM,
                onTabSelected: (index) => setState(() => _currentNav = index),
                color: Colors.black54,
                backgroundColor: Colors.white,
                selectedColor: Theme.of(context).accentColor,
                centerItem: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    pushName(context, weather);
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: sizeH(context) * .04,
                        child: StreamBuilder<List<HeWeather>>(
                            stream: Future.wait([
                              netool.pullWeather('$now'),
                              netool.pullWeather('$forecast'),
                              netool.pullWeather('$hourly'),
                              netool.pullWeather('$lifestyle'),
                            ]).asStream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Marquee(
                                  textList: [
                                    '${snapshot.data[0].weather[0].now.condDesc ?? ''}',
                                    '${snapshot.data[1].weather[0].forecast[0].tempMax}℃~${snapshot.data[1].weather[0].forecast[0].tempMax}℃',
                                    '${snapshot.data[2].weather[0].hourly[0].temp} ℃',
                                    '🌞${snapshot.data[1].weather[0].forecast[0].sunRise} ~ ${snapshot.data[1].weather[0].forecast[0].sunSet}🌛'
                                  ],
                                  fontSize: 11.0,
                                  controller: _marqueeController,
                                );
                              }
                              return Center(child: freeTxT('暂无数据', size: 12.0));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget initCenterFace(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
            context: context,
            builder: (context) {
              return Container(
                height: sizeH(context) * .12,
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          freeTxT('我的'),
                          Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ),
                          freeTxT(isToggle ? '历史' : '收藏'),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 26.0, bottom: 4.0, left: 12.0),
                        child: ListView.builder(
                          itemCount: 12,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FavoriteItem(
                              icon: isToggle ? dinoLogo : dogSmile,
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          centerFace.onTap();
                          setState(() {
                            isToggle = !isToggle;
                          });
                        },
                        borderRadius: BorderRadius.circular(32.0),
                        child: Container(
                          margin: const EdgeInsets.all(3.0),
                          child: Icon(Icons.transform),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        padding: const EdgeInsets.only(top: 6.0),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8.0, top: 3.0),
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 3.0,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.center,
              child: Icon(Icons.keyboard_arrow_up),
            ),
            Container(
              padding: const EdgeInsets.only(right: 8.0, top: 3.0),
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 3.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<NavItemBTM> get _getNavItemsBTM => [
        NavItemBTM(iconPath: _currentNavIcon(0), text: _navTitleBTM(0)),
        NavItemBTM(iconPath: _currentNavIcon(1), text: _navTitleBTM(1))
      ];

  String _navTitleBTM(index) => ['娱乐', '插件'][index]; // 点击索引切换文字颜色

  String _currentNavIcon(currentIndex) => currentIndex == _currentNav
      ? navIcons[currentIndex][1]
      : navIcons[currentIndex][0];

  List<List<String>> get navIcons => [
        [path('confetti0', 5), path('confetti1', 5)],
        [path('plugin0', 5), path('plugin1', 5)],
      ];
}

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.0,
      height: 64.0,
      margin: const EdgeInsets.all(6.0),
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(12.0),
        child: netPic(pic: icon),
      ),
    );
  }
}
