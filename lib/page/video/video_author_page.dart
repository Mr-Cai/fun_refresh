import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/model/mock/video/eye_channel.dart';
import 'package:fun_refresh/model/mock/video/eye_video.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class VideoAuthorPage extends StatefulWidget {
  const VideoAuthorPage({this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _VideoAuthorPageState();
}

class _VideoAuthorPageState extends State<VideoAuthorPage>
    with SingleTickerProviderStateMixin {
  InnerData data;

  @override
  void initState() {
    data = widget.args['data'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<EyeChannel>(
        stream: netool.pullEyeChannel(id: data.author.id).asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverCustomHeaderDelegate(
                    snapshot: snapshot,
                    title: snapshot.data.pgcInfo.name,
                    collapsedHeight: 40,
                    expandedHeight: 300,
                    paddingTop: MediaQuery.of(context).padding.top,
                    coverImgUrl: picDemo,
                  ),
                ),
                SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return buildVideoTile(context, snapshot, index);
                    },
                    childCount: snapshot.data.itemList.length,
                  ),
                  itemExtent: sizeH(context) * .18,
                ),
              ],
            );
          }
          return flareAnim(context, height: sizeH(context));
        },
      ),
    );
  }

  Widget buildVideoTile(
    BuildContext context,
    AsyncSnapshot<EyeChannel> snapshot,
    int index,
  ) {
    final releaseTime = DateTime.fromMillisecondsSinceEpoch(
      snapshot.data.itemList[index].data.releaseTime,
    );

    return InkWell(
      onTap: () {
        pushReplace(
          context,
          video_detail,
          args: {'data': snapshot.data.itemList[index].data},
        );
      },
      child: Container(
        height: sizeH(context) * .2,
        width: sizeW(context),
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: sizeW(context) * .7,
                child: netPic(
                  pic: snapshot.data.itemList[index].data.cover.detail,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    width: sizeW(context) * .25,
                    child: freeTxT(
                      snapshot.data.itemList[index].data.title,
                      isBold: true,
                      maxLines: 5,
                      size: 20.0,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    width: sizeW(context) * .25,
                    child: freeTxT('$releaseTime'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecentListPageState();
}

class _RecentListPageState extends State<RecentListPage> {
  @override
  Widget build(BuildContext context) {
    return Text('最近');
  }
}

class HotListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HotListPageState();
}

class _HotListPageState extends State<HotListPage> {
  @override
  Widget build(BuildContext context) {
    return Text('火爆');
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
    this.snapshot,
  });

  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;
  final AsyncSnapshot<EyeChannel> snapshot;

  String statusBarMode = 'dark';

  @override
  double get minExtent => collapsedHeight + paddingTop;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(double shrinkOffset) {
    if (shrinkOffset == 0.0) {
      statusBar(status: 1);
    }
    if (shrinkOffset > 50.0 && statusBarMode == 'dark') {
      statusBarMode = 'light';
      statusBar(status: 0);
    } else if (shrinkOffset <= 50.0 && statusBarMode == 'light') {
      statusBarMode = 'dark';
      statusBar(status: 1);
    }
  }

  Color makeStickyHeaderBgColor(double shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(double shrinkOffset, bool isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    updateStatusBarBrightness(shrinkOffset);
    return Container(
      height: maxExtent,
      width: sizeW(context),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(child: Image.network(coverImgUrl, fit: BoxFit.cover)),
          Positioned(
            left: 0,
            top: maxExtent / 2,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 1.0,
                        icon: SvgPicture.asset(
                          path('back', 5),
                          width: 22.0,
                          height: 22.0,
                          color: makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () {
                          pop(context);
                        },
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: makeStickyHeaderTextColor(shrinkOffset, false),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          shrinkOffset > 50.0
              ? Container()
              : Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: sizeW(context) * .2,
                      height: sizeW(context) * .2,
                      child: netPic(pic: snapshot.data.pgcInfo.icon),
                    ),
                  ),
                ),
          shrinkOffset > 10.0
              ? Container()
              : Container(
                  margin: EdgeInsets.only(bottom: sizeH(context) * .09),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${snapshot.data.pgcInfo.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
          shrinkOffset > 100.0
              ? Container()
              : Container(
                  width: sizeW(context) * .4,
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                    bottom: sizeH(context) * .07,
                    left: 32.0,
                    right: 32.0,
                  ),
                  child: freeTxT(
                    '${snapshot.data.pgcInfo.description}'.replaceAll('\n', ''),
                    color: Colors.white,
                    size: 14.0,
                  ),
                ),
          shrinkOffset > 200.0
              ? Container()
              : Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black26,
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildIcon(
                          snapshot: snapshot,
                          context: context,
                          text: '社交平台',
                          icon: Icons.link,
                        ),
                        buildIcon(
                          snapshot: snapshot,
                          context: context,
                          count: snapshot.data.pgcInfo.followCount,
                          text: ' 位订阅者',
                          icon: Icons.favorite_border,
                        ),
                        buildIcon(
                          snapshot: snapshot,
                          context: context,
                          count: snapshot.data.pgcInfo.videoCount,
                          text: ' 个视频',
                          icon: Icons.video_library,
                        ),
                        buildIcon(
                          snapshot: snapshot,
                          context: context,
                          count: snapshot.data.pgcInfo.shareCount,
                          text: ' 次分享',
                          icon: Icons.share,
                        ),
                        buildIcon(
                          snapshot: snapshot,
                          context: context,
                          count: snapshot.data.pgcInfo.collectCount,
                          text: ' 次收藏',
                          icon: Icons.collections_bookmark,
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildIcon({
    AsyncSnapshot<EyeChannel> snapshot,
    BuildContext context,
    String text,
    IconData icon,
    num count,
  }) {
    return InkWell(
      onTap: () {
        return snapshot.data.itemList[0].data.author.link.isEmpty
            ? tip('暂无相关链接', context)
            : pushName(
                context,
                web_view,
                args: {
                  'url': snapshot.data.itemList[0].data.author.link,
                },
              );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          freeTxT('${count ?? ''}$text', size: 14.0, color: Colors.white),
        ],
      ),
    );
  }
}
