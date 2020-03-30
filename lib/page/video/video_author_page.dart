import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                SliverAppBar(
                  leading: IconButton(
                    iconSize: 1.0,
                    icon: SvgPicture.asset(
                      path('back', 5),
                      width: 22.0,
                      height: 22.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pop(context);
                    },
                  ),
                  floating: true,
                  elevation: 0.0,
                  flexibleSpace: Stack(
                    children: [
                      netPic(pic: picDemo),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                width: sizeW(context) * .2,
                                height: sizeW(context) * .2,
                                child: netPic(pic: data.author.icon),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '${snapshot.data.pgcInfo.name}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '${snapshot.data.pgcInfo.description}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          color: Colors.white,
                          iconSize: 26.0,
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  expandedHeight: sizeH(context) * .28,
                  backgroundColor: Colors.grey[50],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black38,
                          ],
                        ),
                      ),
                      child: Row(
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
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed(List.generate(
                    snapshot.data.itemList.length,
                    (index) {
                      return buildVideoTile(context, snapshot, index);
                    },
                  )),
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
    return GestureDetector(
      onTap: () {
        pushReplace(context, video_detail, args: {
          'data': snapshot.data.itemList[index].data
        });
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
                    child: freeTxT(
                      snapshot.data.itemList[index].data.releaseTime.toString(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
