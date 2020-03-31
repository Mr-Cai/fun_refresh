import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/model/mock/extension/extension_app.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/net_tool.dart';
import '../../components/theme.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import '../../tools/global.dart';
import '../../model/i18n/i18n.dart';
import '../../components/top_bar.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../components/custom_clipper.dart';
import '../../components/swiper.dart';
import '../../model/data/local_asset.dart';

class ExtensionPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _ExtensionPageState();
}

class _ExtensionPageState extends State<ExtensionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).more,
      ),
      body: StreamBuilder<ExtResponse>(
        stream: netool.pullExtAppData().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
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
                      onTap: () {},
                      splashColor: Colors.white,
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    List.generate(
                      snapshot.data.typeList.length ?? 0,
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
            );
          }
          return flareAnim(context, height: sizeH(context));
        },
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
                itemActiveColor: Colors.orange,
              ),
              autoStart: true,
              children: List.generate(
                data.length ?? 0,
                (index) => netPic(
                  pic: data[index].pic,
                  holder: flareAnim(context),
                  errorH: Image.asset(
                    path('404_error', 3),
                    fit: BoxFit.cover,
                  ),
                ),
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
          height: sizeH(context) * .24,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length ?? 0,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, indexIn) {
              return IconItem(
                indexOut: indexOut,
                indexIn: indexIn,
                icon: data[indexIn].pic,
                title: data[indexIn].title,
                desc: data[indexIn].desc,
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
    this.icon,
    this.title,
    this.desc,
    @required this.indexOut,
    @required this.indexIn,
  });

  final String icon;
  final String title;
  final String desc;
  final int indexIn;
  final int indexOut;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      onTap: () {
        toggleApp(context, indexOut: indexOut, indexIn: indexIn);
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
                  fit: BoxFit.fill,
                  pic: icon,
                  holder: flareAnim(context),
                ),
              ),
            ),
            SizedBox(height: 6.0),
            title == '' || title == null
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
                      freeTxT(title),
                      freeTxT(
                        desc,
                        size: 15.0,
                        color: Colors.lightBlue,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void toggleApp(BuildContext context, {@required int indexOut, int indexIn}) {
    Map defaultArgs = {
      'name': 'programmer',
      'anim': 'coding',
      'desc': '正在开发中...',
      'title': '敬请期待'
    };
    switch (indexOut) {
      case 0: // 火爆热搜
        switch (indexIn) {
          case 1:
            pushName(context, girl);
            break;
          case 3:
            pushName(context, web_view, args: {'url': article});
            break;
          default:
            pushName(context, null, args: defaultArgs);
        }
        break;
      case 1: // 个性推荐
        switch (indexIn) {
          case 0:
            pushName(context, dinosaur_run);
            break;
          case 1:
            pushName(context, web_view, args: {'url': timeIs});
            break;
          case 2:
            pushName(context, web_view, args: {'url': article});
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
                    'title': '敬请期待'
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
