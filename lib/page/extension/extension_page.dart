import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/model/mock/extension/extension_app.dart';
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

class _ExtensionPageState extends State<ExtensionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).more,
        titleTop: 8.0,
        preferredSize: Size.fromHeight(sizeH(context) * .055),
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
        $ItemTile(context, title: slimTxT(title)),
        Container(
          height: sizeH(context) * .3,
          width: sizeW(context),
          child: AspectRatio(
            aspectRatio: 16 / 9,
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

  Widget _buildSwiperList({@required String title, List<Data> data}) {
    return Column(
      children: [
        $ItemTile(
          context,
          title: slimTxT(title ?? '标题'),
          isSlim: true,
        ),
        Container(
          height: sizeH(context) * .24,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length ?? 0,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return IconItem(
                icon: data[index].pic,
                title: data[index].title,
                desc: data[index].desc,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class IconItem extends StatelessWidget {
  const IconItem({this.icon, this.title, this.desc});

  final String icon;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW(context) * .4,
      height: sizeW(context) * .4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            onTap: () {
              pushName(context, null, args: {
                'name': 'programmer',
                'anim': 'coding',
                'desc': '正在开发中...',
                'title': '敬请期待'
              });
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 12.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                width: sizeW(context) * .3,
                height: sizeW(context) * .3,
                child: netPic(
                  fit: BoxFit.fill,
                  pic: icon,
                  holder: flareAnim(context),
                ),
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
                    slimTxT(title),
                    slimTxT(
                      desc,
                      size: 15.0,
                      color: Colors.lightBlue,
                    ),
                  ],
                ),
        ],
      ),
    );
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
                case 0: // ���龙快跑(像素风)
                  pushName(context, dinosaur_run);
                  break;
                case 1: // 飞翔的小鸟(像素风)
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
