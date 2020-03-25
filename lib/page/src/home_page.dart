import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../components/anchor_bar.dart';
import '../../components/circle_floating_menu.dart';
import '../../components/collapse_drawer.dart';
import '../../components/floating_button.dart';
import '../../components/marquee.dart';
import '../../model/data/local_asset.dart';
import '../../model/mock/smash_model.dart';
import '../../model/mock/weather/he_weather.dart';
import '../../tools/net_tool.dart';
import '../../model/i18n/i18n.dart';
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

  List<String> get navTexts => [
        '${I18n.of(context).game}',
        '${I18n.of(context).video}',
        '${I18n.of(context).more}',
        '${I18n.of(context).msg}',
      ];

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
              floatingActionButton: CircleFloatingMenu(
                menuSelected: (index) {},
                startAngle: degToRad(-160.0),
                endAngle: degToRad(-20.0),
                floatingButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {},
                ),
                subMenus: [
                  FloatingButton(
                    icon: Icons.widgets,
                  ),
                  FloatingButton(
                    icon: Icons.book,
                  ),
                  FloatingButton(
                    icon: Icons.translate,
                  ),
                  FloatingButton(
                    icon: Icons.alarm_add,
                  ),
                  FloatingButton(
                    icon: Icons.bluetooth,
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: AnchorBar(
                notchedShape: CircularNotchedRectangle(),
                items: _getNavItemsBTM,
                notchMargin: 8.0,
                onTabSelected: (index) => setState(() => _currentNav = index),
                color: Colors.black54,
                backgroundColor: Colors.white,
                selectedColor: Theme.of(context).accentColor,
                centerItem: InkWell(
                  splashColor: Colors.white38,
                  highlightColor: Colors.white38,
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 12.0),
                    height: 24.0,
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
                              fontSize: 10.0,
                              controller: _marqueeController,
                            );
                          }
                          return Center(child: slimTxT('暂无数据', size: 12.0));
                        }),
                  ),
                ),
              ),
            ),
          );
  }

  List<NavItemBTM> get _getNavItemsBTM => [
        NavItemBTM(iconPath: _currentNavIcon(0), text: _navTitleBTM(0)),
        NavItemBTM(iconPath: _currentNavIcon(1), text: _navTitleBTM(1)),
        NavItemBTM(iconPath: _currentNavIcon(2), text: _navTitleBTM(2)),
        NavItemBTM(iconPath: _currentNavIcon(3), text: _navTitleBTM(3))
      ];

  String _navTitleBTM(index) => navTexts[index]; // 点击索引切换文字颜色

  String _currentNavIcon(currentIndex) => currentIndex == _currentNav
      ? navIcons[currentIndex][1]
      : navIcons[currentIndex][0];
}
