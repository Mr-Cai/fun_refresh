import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/plugin/girl_gank.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class GirlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GirlPageState();
}

class _GirlPageState extends State<GirlPage> {
  int currentIndex = 0;
  ScrollController _controller = ScrollController();
  bool isShowTopBar = true;

  @override
  void initState() {
    autoScreenDir();
    hideTopBar(_controller);
    super.initState();
  }

  void hideTopBar(ScrollController controller) {
    controller.addListener(() async {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          Future.delayed(Duration(milliseconds: 100), () {
            isShowTopBar = true;
          });
        });
      } else {
        setState(() {
          Future.delayed(Duration(milliseconds: 100), () {
            isShowTopBar = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    statusBar();
    portrait();
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowTopBar
          ? TopBar(
              themeColor: Colors.black,
              title: '美女宝典',
              actions: [
                InkWell(
                  child: Icon(
                    Icons.more_vert,
                    size: 28.0,
                  ),
                )
              ],
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Container(),
            ),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: [
          buildGirlPicGank(), // 0 干货妹子图
          buildGirlPicHot(), // 1 火辣妹纸图
          buildGirlBigBoobs(), // 2 大胸妹子图
        ],
      ),
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.search_ellipsis,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                if (currentIndex == 0) Navigator.of(context).pop();
                setState(() => currentIndex = 0);
              },
            ),
          ),
          buildSpeedDialChild(
            pic: gankGirlIcon,
            label: '干货妹子图',
            index: 0,
          ),
          buildSpeedDialChild(
            pic: hotGirlIcon,
            label: '火辣妹纸图',
            index: 1,
          ),
          buildSpeedDialChild(
            pic: girlIcon,
            label: '大胸妹纸图',
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget buildGirlPicGank() {
    return StreamBuilder<GirlGank>(
      stream: netool.getGirlPicGank(page: 1, count: 50).asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            controller: _controller,
            itemCount: snapshot.data.data.length,
            scrollDirection: dirAxis(context) == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  pushName(context, photos, args: {
                    'data': snapshot.data.data[index].url,
                  });
                },
                child: Container(
                  width: dirAxis(context) == Orientation.landscape
                      ? sizeW(context) * .3
                      : sizeW(context),
                  height: sizeH(context),
                  child: Stack(
                    children: [
                      netPic(
                        pic: snapshot.data.data[index].url,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        width: sizeW(context),
                        height: dirAxis(context) == Orientation.landscape
                            ? sizeH(context) * .24
                            : sizeH(context) * .10,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.bottomRight,
                              child: freeTxT(
                                '${snapshot.data.data[index].publishedAt}'
                                    .substring(5, 10),
                                color: Colors.white,
                                size: dirAxis(context) == Orientation.landscape
                                    ? 20.0
                                    : 24.0,
                              ),
                            ),
                            freeTxT(
                              '${snapshot.data.data[index].desc}'
                                  .replaceAll('\n', ' '),
                              maxLines: 3,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Center(child: flareAnim(context));
      },
    );
  }

  SpeedDialChild buildSpeedDialChild({String pic, String label, int index}) {
    return SpeedDialChild(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: netPic(pic: pic),
      ),
      backgroundColor: Colors.red,
      label: label,
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () {
        setState(() => currentIndex = index);
      },
    );
  }

  Widget buildGirlPicHot() {
    List<String> girlPhotos = [
      for (var i = 0; i <= 145; i++)
        'https://qiniu.easyapi.com/photo/girl$i.jpg',
    ];
    return ListView.builder(
      itemCount: 146,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            print(index);
            pushName(context, photos, args: {'data': girlPhotos[index]});
          },
          child: Container(
            width: sizeW(context),
            height: sizeH(context),
            child: netPic(
              pic: girlPhotos[index],
              fit: dirAxis(context) == Orientation.landscape
                  ? BoxFit.contain
                  : BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }

  Widget buildGirlBigBoobs() {
    List<String> girlPhotos = [
      'https://img.cct58.com/caiji/mm/201710/0118/20171001182903_414.jpg'
    ];
    return ListView.builder(
      itemCount: girlPhotos.length,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            pushName(context, photos, args: {'data': girlPhotos[index]});
          },
          child: Container(
            width: sizeW(context),
            height: sizeH(context),
            child: netPic(
              pic: girlPhotos[index],
              fit: dirAxis(context) == Orientation.landscape
                  ? BoxFit.contain
                  : BoxFit.fitWidth,
            ),
          ),
        );
      },
    );
  }
}
