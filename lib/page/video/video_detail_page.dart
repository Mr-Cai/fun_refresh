import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/mock/video/eye_related.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void dispose() {
    statusBar();
    super.dispose();
  }

  @override
  void initState() {
    statusBar(status: 1, isHide: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dividerColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            VideoWindow(url: widget.args['url'], args: widget.args),
            Container(
              height: sizeH(context),
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  ProfileBar(
                    avatar: widget.args['avatar'],
                    name: widget.args['name'],
                    slogan: widget.args['slogan'],
                    desc: widget.args['desc'],
                    isLike: false,
                  ),
                  _buildRelatedTile(context),
                  SizedBox(height: sizeH(context) * .3)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedTile(BuildContext context) {
    return Container(
      height: sizeH(context),
      child: StreamBuilder<EyeRelated>(
          stream: netool.pullEyeRelated(id: widget.args['id']).asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.zero,
                  primary: true,
                  shrinkWrap: true,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 6,
                  itemCount: snapshot.data.itemList.length ?? 0,
                  itemBuilder: (context, index) {
                    if (snapshot.data.itemList[index].type ==
                        'videoSmallCard') {
                      return RelatedTile(
                        item: snapshot.data.itemList[index],
                        img: snapshot.data.itemList[index].data.cover.detail,
                      );
                    }
                    return Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Material(
                          color: index.isEven ? Colors.blueAccent : Colors.teal,
                          child: InkWell(
                            onTap: () {},
                            child: Center(
                              child: slimTxT(
                                index.isEven ? '为你推荐👉' : '查看更多👇',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, 1.7);
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return holderPage(context);
            }
            return Container(
              margin: EdgeInsets.only(bottom: sizeH(context) * .5),
              child: flareAnim(context, height: sizeH(context) * .1),
            );
          }),
    );
  }
}

class RelatedTile extends StatelessWidget {
  const RelatedTile({@required this.item, this.img});

  final Item item;
  final String img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushReplace(context, video_detail, args: {
          'url': item.data.playUrl,
          'avatar': item.data.author.icon,
          'name': item.data.author.name,
          'slogan': item.data.author.description,
          'title': item.data.title,
          'desc': item.data.description,
          'id': item.data.id,
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: img ?? picDemo,
              placeholder: (_, __) => Center(
                child: RefreshProgressIndicator(),
              ),
              errorWidget: (_, __, ___) {
                return holderPage(context);
              },
            ),
            Positioned(
              top: 4.0,
              right: 3.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  color: Colors.black.withOpacity(0.2),
                  child: slimTxT(
                    secToTime(item.data.duration),
                    color: Colors.white,
                    size: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBar extends StatelessWidget {
  const ProfileBar({
    this.avatar,
    this.name,
    this.slogan,
    this.title,
    this.desc,
    this.isLike,
  });

  final String avatar;
  final String name;
  final String slogan;
  final String title;
  final String desc;
  final bool isLike;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAuthorBar(context),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: desc,
              style: TextStyle(color: Colors.black),
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorBar(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.network(
              avatar,
              width: 64.0,
              height: 64.0,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            slimTxT(name),
            SizedBox(height: 4.0),
            Container(
              width: sizeW(context) * .66,
              child: slimTxT(slogan, size: 13.0),
            ),
          ],
        ),
        Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: isLike ? Colors.red : Colors.grey.shade500,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class VideoWindow extends StatefulWidget {
  const VideoWindow({@required this.url, this.args});

  final String url;
  final Map args;

  @override
  State<StatefulWidget> createState() => _VideoWindowState();
}

class _VideoWindowState extends State<VideoWindow> {
  VideoPlayerController controller;
  @override
  void initState() {
    controller = VideoPlayerController.network(widget.url);
    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((value) => setState(() {}));
    controller.pause();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio < 16 / 12
          ? 16 / 9
          : controller.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(controller),
          CtrlPlayUI(
            controller,
            args: widget.args,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 8.0,
              child: VideoProgressIndicator(
                controller,
                allowScrubbing: true,
                colors: VideoProgressColors(playedColor: Colors.lightBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CtrlPlayUI extends StatelessWidget {
  const CtrlPlayUI(this.controller, {this.args});

  final VideoPlayerController controller;
  final Map args;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? Center(
                child: Icon(
                    Icons.pause,
                    color: Colors.white70,
                    size: 48.0,
                  ),
              )
              : Container(
                  color: Colors.black38,
                  child: Align(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white70,
                        size: 48.0,
                      ),
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
            statusBar(status: 1, isHide: true);
          },
          onVerticalDragStart: (_) {
            statusBar(status: 1, isHide: true);
          },
        ),
        controller.value.isPlaying
            ? Container()
            : buildCtrlOverlay(context, args: args),
      ],
    );
  }

  Widget buildCtrlOverlay(BuildContext context, {Map args}) {
    return Container(
      width: sizeW(context),
      height: sizeH(context),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.only(left: 12.0, top: 16.0, right: 20.0),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: menuIcon(
                    context,
                    icon: 'back',
                    color: Colors.white,
                    size: 22.0,
                    onTap: () => pop(context),
                  ),
                ),
              ),
              slimTxT(args['title'], color: Colors.white),
              Spacer(),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /* IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.white70,
                  ),
                  iconSize: 16.0,
                  tooltip: '点赞',
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.fullscreen,
                    color: Colors.white70,
                  ),
                  tooltip: '��屏',
                  onPressed: () {},
                ), */
              ],
            ),
          )
        ],
      ),
    );
  }
}
