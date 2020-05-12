import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fun_refresh/components/mini.dart';
import '../../model/confetti/confetti_response.dart';
import 'package:fun_refresh/tools/net_tool.dart';
import '../../components/theme.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import '../../tools/global.dart';
import '../../components/top_bar.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../components/custom_clipper.dart';
import '../../components/swiper.dart';
import '../../model/data/local_asset.dart';

class ConfettiPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _ConfettiPageState();
}

class _ConfettiPageState extends State<ConfettiPage> {
  final _controller = ScrollController();
  bool isShowTopBar = true;

  var searchStr = '';
  var svgIcon = 'search';

  Widget titleWidget;

  TextEditingController filterTxTCtrl;

  bool isMenu = true;
  bool isWidget = true;

  Function backEvent;

  var keyWords = List<Data>();
  var filterWords = List<Data>();

  @override
  void initState() {
    statusBar();
    initWidget();
    _controller.addListener(() async {
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
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
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowTopBar
          ? TopBar(
              themeColor: Colors.black,
              title: '娱乐',
              isMenu: isMenu,
              isWidget: isWidget,
              backEvent: backEvent,
              titleWidget: titleWidget,
              actions: [
                menuIcon(context, size: 26.0, icon: svgIcon, onTap: () {
                  setState(() {
                    titleWidget = TextFormField(
                      controller: filterTxTCtrl,
                      cursorWidth: 1.0,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      textCapitalization: TextCapitalization.words,
                      autocorrect: true,
                      cursorRadius: Radius.circular(2.0),
                      decoration: InputDecoration(
                        hintText: '请输入你想要的小游戏...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: const EdgeInsets.all(8.0),
                      ),
                      onChanged: (value) {},
                    );
                    isMenu = false;
                    if (svgIcon == 'close') {
                      svgIcon = 'search';
                      titleWidget = buildTitle();
                      isMenu = true;
                      filterWords = keyWords;
                      filterTxTCtrl.clear();
                    } else {
                      svgIcon = 'close';
                      isMenu = false;
                    }
                  });
                }),
              ],
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Container(),
            ),
      body: StreamBuilder<ConfettiResponse>(
        stream: pullRequest(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var tempList = List<Data>();
            for (var item in snapshot.data.typeList[1].data) {
              tempList.add(item);
            }
            Future.delayed(Duration(milliseconds: 100), () {
              setState(() {
                keyWords = tempList;
                filterWords = keyWords;
              });
            });
            if (searchStr.isNotEmpty) {
              var tempList = List<Data>();
              for (var item in filterWords) {
                if ('$item'.toLowerCase().contains(searchStr.toLowerCase())) {
                  tempList.add(item);
                }
              }
              filterWords = tempList;
              keyWords.shuffle();
            }
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                controller: _controller,
                slivers: [
                  SliverAppBar(
                    leading: Container(),
                    floating: true,
                    elevation: 0.0,
                    flexibleSpace: ClipPath(
                      child: RatioSwiper(),
                      clipper: BezierClipper(64.0),
                    ),
                    expandedHeight: sizeH(context) * .28,
                    backgroundColor: Colors.grey[50],
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(sizeH(context) * .1),
                      child: InkWell(
                        child: Icon(Icons.remove_red_eye, size: 32.0),
                        onTap: () {
                          pushName(context, vision);
                        },
                        splashColor: Colors.white,
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      List.generate(
                        snapshot.data.typeList.length == null
                            ? 0
                            : filterWords.length,
                        (index) {
                          if (index == 3) {
                            return _buildSwipper(
                              context,
                              title: snapshot.data.typeList[index].title,
                              data: snapshot.data.typeList[index].data,
                            );
                          }
                          return _buildSwiperList(
                            title: snapshot.data.typeList[index].title,
                            data: snapshot.data.typeList[index].data,
                            indexOut: index,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return flareAnim(context, height: sizeH(context));
        },
      ),
    );
  }

  Stream<ConfettiResponse> pullRequest() => netool.pullExtAppData().asStream();

  void initWidget() {
    buildTitle();
    filterTxTCtrl = TextEditingController()
      ..addListener(() {
        setState(() {
          if (filterTxTCtrl.text.isEmpty) {
            searchStr = '';
            filterWords = keyWords;
          } else {
            searchStr = filterTxTCtrl.text;
          }
        });
      });
    backEvent = () {
      setState(() {
        isMenu = true;
        buildTitle();
        svgIcon = 'search';
      });
    };
  }

  Widget buildTitle() {
    return titleWidget = Text(
      '娱乐',
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSwipper(BuildContext context,
      {@required String title, List<Data> data}) {
    return Column(
      children: [
        $ItemTile(context, title: freeTxT(title)),
        Container(
          height: sizeH(context) * .3,
          width: sizeW(context),
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          child: AspectRatio(
            aspectRatio: 20 / 9,
            child: Swiper(
              indicator: CircleSwiperIndicator(
                itemActiveColor: Colors.lightBlue,
                itemColor: Colors.grey.shade500,
              ),
              circular: true,
              autoStart: true,
              children: List.generate(
                data.length ?? 0,
                (index) {
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          break;
                        case 1:
                          break;
                        default:
                          pushName(context, null, args: defaultArgs);
                      }
                    },
                    child: Stack(
                      children: [
                        netPic(
                          pic: data[index].pic,
                          holder: flareAnim(context),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6.6),
                          alignment: Alignment.topCenter,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              color: Colors.black.withOpacity(0.4),
                              child: freeTxT(
                                data[index].desc,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwiperList({
    @required String title,
    @required List<Data> data,
    @required int indexOut,
  }) {
    return Column(
      children: [
        $ItemTile(
          context,
          title: freeTxT(title ?? '标题'),
          isSlim: true,
        ),
        Container(
          height: sizeH(context) * .23,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length ?? 0,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, indexIn) {
              return IconItem(
                indexOut: indexOut,
                indexIn: indexIn,
                data: data,
              );
            },
          ),
        ),
      ],
    );
  }
}

class IconItem extends StatelessWidget {
  const IconItem({
    @required this.indexOut,
    @required this.indexIn,
    @required this.data,
  });

  final List<Data> data;
  final int indexIn;
  final int indexOut;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      onTap: () {
        toggleApp(context, indexOut: indexOut, indexIn: indexIn, data: data);
      },
      child: Container(
        width: sizeW(context) * .4,
        height: sizeW(context) * .4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 12.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                width: sizeW(context) * .3,
                height: sizeW(context) * .3,
                child: netPic(
                  fit: BoxFit.cover,
                  pic: data[indexIn].pic,
                  holder: flareAnim(context),
                ),
              ),
            ),
            data[indexIn].title == '' || data[indexIn].title == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: sizeW(context) * .28,
                      height: sizeH(context) * .025,
                      child: LinearProgressIndicator(),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      freeTxT(data[indexIn].title),
                      freeTxT(
                        data[indexIn].desc,
                        size: 13.0,
                        color: Colors.lightBlue,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void toggleApp(
    BuildContext context, {
    @required int indexOut,
    int indexIn,
    @required List<Data> data,
  }) {
    switch (indexOut) {
      case 0: // 火爆热搜
        switch (indexIn) {
          case 0:
            pushName(context, dinosaur_run);
            break;
          case 1:
            pushName(context, bejeweled);
            break;
          case 2:
            pushName(context, sudoku);
            break;
          case 3:
            pushName(context, flappy_bird);
            break;
          case 4:
            pushName(context, snake);
            break;
          case 5:
            pushName(context, tetris);
            break;
          case 6:
            pushName(context, game2048);
            break;
          default:
            pushName(context, null, args: defaultArgs);
        }
        break;
      case 1: // 个性推荐
        switch (indexIn) {
          case 0:
            pushName(context, game2048);
            break;
          case 1:
            pushName(context, dinosaur_run);
            break;
          case 2:
            pushName(context, bejeweled);
            break;
          case 3:
            pushName(context, sudoku);
            break;
          case 4:
            pushName(context, flappy_bird);
            break;
          case 5:
            pushName(context, snake);
            break;
          case 6:
            pushName(context, tetris);
            break;
          default:
            pushName(context, null, args: defaultArgs);
        }
        break;
      case 2: // 最近更新
        switch (indexIn) {
          case 0:
            pushName(context, tetris);
            break;
          case 1:
            pushName(context, game2048);
            break;
          case 2:
            pushName(context, dinosaur_run);
            break;
          case 3:
            pushName(context, bejeweled);
            break;
          case 4:
            pushName(context, sudoku);
            break;
          case 5:
            pushName(context, flappy_bird);
            break;
          case 6:
            pushName(context, snake);
            break;
          default:
            pushName(context, null, args: defaultArgs);
        }
        break;
      case 4: // 猜你喜欢
        switch (indexIn) {
          case 0:
            pushName(context, dinosaur_run);
            break;
          case 1:
            pushName(context, snake);
            break;
          default:
            pushName(context, null, args: defaultArgs);
        }
        break;
      case 5: // 休闲益智
        switch (indexIn) {
          case 0:
            pushName(context, bejeweled);
            break;
          case 1:
            pushName(context, sudoku);
            break;
          case 2:
            pushName(context, flappy_bird);
            break;
          case 3:
            pushName(context, snake);
            break;
          case 4:
            pushName(context, tetris);
            break;
          case 5:
            pushName(context, game2048);
            break;
          case 6:
            pushName(context, dinosaur_run);
            break;
          default:
            pushName(context, null, args: defaultArgs);
        }
        break;
      case 6: // 人气蹿升
        switch (indexIn) {
          case 0:
            pushName(context, flappy_bird);
            break;
          case 1:
            pushName(context, bejeweled);
            break;
          case 2:
            pushName(context, sudoku);
            break;
          default:
            pushName(context, null, args: defaultArgs);
        }
        break;
      case 7: // 发现精彩
        switch (indexIn) {
          case 0:
            pushName(context, bejeweled);
            break;
          case 1:
            pushName(context, flappy_bird);
            break;
          case 2:
            pushName(context, sudoku);
            break;
          default:
            pushName(context, null, args: defaultArgs);
        }
        break;

      default:
        pushName(context, null, args: defaultArgs);
    }
  }
}

class RatioSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Swiper.builder(
        autoStart: true,
        circular: true,
        indicator: RectangleSwiperIndicator(
          itemHeight: 3.0,
          itemWidth: 8.0,
          itemActiveColor: Colors.white,
          padding: const EdgeInsets.only(bottom: 36.0),
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 0: // 恐龙快跑(像素风)
                  pushName(context, dinosaur_run);
                  break;
                case 1: // 飞翔的小鸟(��素风)
                  pushName(context, flappy_bird);
                  break;
                case 2: // 贪吃蛇(像素风)
                  pushName(context, snake);
                  break;
                case 3: // 2048
                  pushName(context, game2048);
                  break;
                case 4: // 俄罗斯方块(像素风)
                  pushName(context, tetris);
                  break;
                case 5: // 数独
                  pushName(context, sudoku);
                  break;
                case 6: // 宝石迷阵
                  pushName(context, bejeweled);
                  break;
                default:
                  pushName(context, null, args: {
                    'name': 'programmer',
                    'anim': 'coding',
                    'desc': '正在开发中...',
                    'title': '敬请期待',
                    'isLight': false,
                  });
              }
            },
            child: netPic(
              pic: covers[index],
              fit: BoxFit.fill,
              errorH: flareAnim(context, args: {
                'name': 'programmer',
                'anim': 'coding',
              }),
            ),
          );
        },
        childCount: covers.length ?? 0,
      ),
    );
  }
}
