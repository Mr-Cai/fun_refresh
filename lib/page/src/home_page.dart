import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/anchor_bar.dart';
import 'package:fun_refresh/components/circle_floating_menu.dart';
import 'package:fun_refresh/components/collapse_drawer.dart';
import 'package:fun_refresh/components/floating_button.dart';
import 'package:fun_refresh/components/marquee.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/model/smash_model.dart';
import 'package:fun_refresh/model/weather/he_weather.dart';
import 'package:fun_refresh/tools/net_tool.dart';
import '../../model/i18n/i18n.dart';
import 'package:fun_refresh/page/public/game_page.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import '../export_page_pkg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNav = 0;

  final _marqueeController = MarqueeController();

  InterstitialAd _interstitialAd;

  List<String> get navTexts => [
        '${I18n.of(context).game}',
        '${I18n.of(context).video}',
        '${I18n.of(context).more}',
        '${I18n.of(context).msg}',
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  MobileAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: intersUnit,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: CollaplseDrawer(),
        body: _skipPage(_currentNav),
        floatingActionButton: CircleFloatingMenu(
          menuSelected: (index) {},
          startAngle: degToRad(-160.0),
          endAngle: degToRad(-20.0),
          floatingButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _interstitialAd?.dispose();
              _interstitialAd = createInterstitialAd()..load();
              _interstitialAd?.show();
            },
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnchorBar(
          notchedShape: CircularNotchedRectangle(),
          items: _getNavItemsBTM,
          notchMargin: 8.0,
          onTabSelected: (index) => setState(() => _currentNav = index),
          color: Colors.black54,
          backgroundColor: Colors.white,
          selectedColor: Theme.of(context).accentColor,
          centerItem: GestureDetector(
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
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Marquee(
                        textList: [
                          '实时天气: ${snapshot.data[0].weather[0].now.condDesc}',
                          '实时温度: ${snapshot.data[1].weather[0].forecast[0].tempMax} ℃ ~ ${snapshot.data[1].weather[0].forecast[0].tempMax} ℃',
                          '当前室外: ${snapshot.data[2].weather[0].hourly[0].temp} ℃',
                          '生活建议: ${snapshot.data[3].weather[0].lifestyle[0].desc}',
                          '🌞 ${snapshot.data[1].weather[0].forecast[0].sunRise} ~ ${snapshot.data[1].weather[0].forecast[0].sunSet} 🌛'
                        ],
                        fontSize: 10.0,
                        controller: _marqueeController,
                      );
                    }
                    return Container();
                  }),
            ),
          ),
        ),
      );

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

  Widget _skipPage(index) {
    switch (index) {
      case 0:
        return GamePage();
      case 1:
        return VideoPage();
      case 2:
        return ExtensionPage();
      case 3:
        return MessagePage();
      default:
        return GamePage();
    }
  }
}
