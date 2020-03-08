import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fun_refresh/components/mini.dart';
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
    with KeepAliveParentDataMixin, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).more,
        titleTop: 20.0,
        preferredSize: Size.fromHeight(sizeH(context) * .055),
      ),
      body: CustomScrollView(
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
                child: Icon(
                  Icons.remove_red_eye,
                  size: 32.0,
                ),
                onTap: () {},
                splashColor: Colors.white,
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                _buildSwiperList(title: '火爆热搜'),
                _buildSwiperList(title: '个性推荐'),
                _buildSwiperList(title: '最近更新'),
                _buildSwipper(context),
                _buildSwiperList(title: '猜你喜欢'),
                _buildSwiperList(title: '休闲益智'),
                _buildSwiperList(title: '人气蹿升'),
                _buildSwiperList(title: '发现精彩'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipper(BuildContext context) {
    return Column(
      children: [
        $ItemTile(
          context,
          title: slimTxT('趣刷插件'),
        ),
        Container(
          height: sizeH(context) * .2,
          child: Swiper(
            indicator: CircleSwiperIndicator(),
            autoStart: true,
            children: [
              for (var i = 0; i < 9; i++)
                Container(
                  child: Image.asset(
                    path('header', 3, format: 'jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwiperList({@required String title}) {
    return Column(
      children: [
        $ItemTile(
          context,
          title: slimTxT(title ?? ''),
          isSlim: true,
        ),
        Container(
          height: sizeH(context) * .24,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return IconItem();
            },
          ),
        ),
      ],
    );
  }

  @override
  void detach() {}

  @override
  bool get keptAlive => true;

  @override
  bool get wantKeepAlive => true;
}

class IconItem extends StatelessWidget {
  const IconItem({
    this.icon,
  });

  final String icon;

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
              pushName(context, '');
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.asset(
                  icon ?? path('header', 3, format: 'jpg'),
                ),
              ),
            ),
          ),
          slimTxT('text'),
          slimTxT('text')
        ],
      ),
    );
  }
}

class RatioSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: MediaQuery.of(context).orientation == Orientation.landscape
          ? 3 / 1
          : 16 / 10,
      child: Swiper.builder(
        autoStart: true,
        circular: true,
        indicator: RectangleSwiperIndicator(
          itemHeight: 3.0,
          itemWidth: 8.0,
          itemActiveColor: Colors.white,
          padding: const EdgeInsets.only(
            bottom: 36.0,
          ),
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  pushName(context, game2048);
                  break;
                case 1:
                  pushName(context, game_tetris);
                  break;
                case 2:
                  pushName(context, game_snake);
                  break;
              }
            },
            child: CachedNetworkImage(
              imageUrl: covers[index],
              placeholder: (_, __) => Center(
                child: RefreshProgressIndicator(),
              ),
              errorWidget: (_, __, ___) => errorLoad(
                context,
                height: sizeH(context) * .2,
              ),
            ),
          );
        },
        childCount: covers.length ?? 0,
      ),
    );
  }
}
