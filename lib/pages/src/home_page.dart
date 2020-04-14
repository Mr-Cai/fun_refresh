import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_refresh/components/circle_floating_menu.dart';
import 'package:fun_refresh/components/floating_button.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../components/anchor_bar.dart';
import '../../components/collapse_drawer.dart';
import '../../components/marquee.dart';
import '../../model/mock/smash_model.dart';
import '../../model/mock/weather/he_weather.dart';
import '../../tools/net_tool.dart';
import '../../tools/api.dart';
import '../../tools/global.dart';

class HomePage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNav = 0;
  final _marqueeController = MarqueeController();
  Orientation orientation;
  List<String> get navTexts => ['娱乐', '视频'];

  @override
  void initState() {
    statusBar();
    portrait();
    judgeShowPrivacy(context);
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
              floatingActionButton: Stack(
                children: [
                  CircleFloatingMenu(
                    startAngle: degToRad(-160.0),
                    endAngle: degToRad(-20.0),
                    menuSelected: (index) {},
                    floatingButton: FloatingButton(
                      icon: Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                    subMenus: [
                      FloatingButton(
                        icon: Icons.widgets,
                      ),
                      FloatingButton(
                        icon: Icons.translate,
                      ),
                    ],
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: AnchorBar(
                notchedShape: CircularNotchedRectangle(),
                items: _getNavItemsBTM,
                notchMargin: 6.0,
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

  List<NavItemBTM> get _getNavItemsBTM => [
        NavItemBTM(iconPath: _currentNavIcon(0), text: _navTitleBTM(0)),
        NavItemBTM(iconPath: _currentNavIcon(1), text: _navTitleBTM(1))
      ];

  String _navTitleBTM(index) => navTexts[index]; // 点击索引切换文字颜色

  String _currentNavIcon(currentIndex) => currentIndex == _currentNav
      ? navIcons[currentIndex][1]
      : navIcons[currentIndex][0];

  List<List<String>> get navIcons => [
        [path('confetti0', 5), path('confetti1', 5)],
        [path('video0', 5), path('video1', 5)],
      ];
}
