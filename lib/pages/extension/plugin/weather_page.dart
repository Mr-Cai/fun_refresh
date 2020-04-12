import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/mock/weather/he_weather.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    statusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '深圳天气',
        themeColor: Colors.black,
        actions: [
          menuIcon(
            context,
            icon: 'edit',
            onTap: () {
              showDialog(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return Dialog(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Container(
                      height: sizeH(context) * .3,
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: TextField(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.accents[9],
      body: StreamBuilder<List<HeWeather>>(
        stream: Future.wait([
          netool.pullWeather('$now'),
          netool.pullWeather('$forecast'),
          netool.pullWeather('$hourly'),
          netool.pullWeather('$lifestyle'),
        ]).asStream(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: flareAnim(
                        context,
                        args: {
                          'name': 'weather',
                          'anim': 'wind',
                        },
                        height: sizeH(context) * .2,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(
                        top: sizeH(context) * .06,
                        right: sizeW(context) * .06,
                      ),
                      child: freeTxT(
                        '当前实时',
                        size: 26.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                        top: sizeH(context) * .07,
                        left: sizeW(context) * .06,
                      ),
                      child: freeTxT(
                        '${DateFormat('MM-dd').format(DateTime.now())}',
                        size: 26.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                        top: sizeH(context) * .14,
                        right: sizeW(context) * .2,
                      ),
                      child: freeTxT(
                        '${snapshot.data[0].weather[0].now.temp}',
                        size: 180.0,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                        right: sizeW(context) * .2,
                        bottom: sizeH(context) * .5,
                      ),
                      child: freeTxT('℃', size: 72.0),
                    ),
                    Align(
                      child: Container(
                        height: 120.0,
                        width: sizeW(context),
                        child: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(32.0),
                              child: Row(
                                children: [
                                  TabBar(
                                    indicator: CircleTabIndicator(
                                      color: Colors.white,
                                      radius: 4.0,
                                      offset: 2.0,
                                    ),
                                    indicatorWeight: 0,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    isScrollable: true,
                                    tabs: [
                                      _buildTab(context, '今日实时'),
                                      _buildTab(context, '明日实时'),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildTab(context, '未来7天'),
                                      menuIcon(
                                        context,
                                        icon: 'next',
                                        left: 0.0,
                                        size: 18.0,
                                        onTap: () {
                                          pushName(
                                            context,
                                            weather_detail,
                                            args: {},
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            body: TabBarView(
                              children: [
                                Container(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 9,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Icon(Icons.delete);
                                    },
                                  ),
                                ),
                                Container(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 9,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Icon(Icons.delete);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(child: flareAnim(context));
        },
      ),
    );
  }

  Widget _buildTab(BuildContext context, String txt) {
    return Container(
      height: sizeH(context) * .08,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: freeTxT(txt, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class WeatherDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
    );
  }
}
