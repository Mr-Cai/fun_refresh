import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/mock/video/eye_related.dart';
import 'package:fun_refresh/model/mock/video/eye_video.dart';
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
  InnerData data;
  VideoPlayerController controller;
  @override
  void initState() {
    data = widget.args['data'];
    netool.pullEyeRelated(id: data.id).asStream();
    controller = VideoPlayerController.network(data.playUrl)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) => setState(() {}))
      ..pause();
    super.initState();
  }

  @override
  void dispose() {
    statusBar();
    portrait();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        portrait();
        return dirAxis(context) == Orientation.landscape ? false : true;
      },
      child: Scaffold(
        backgroundColor: dividerColor,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: dirAxis(context) == Orientation.landscape
              ? Container(
                  width: sizeW(context),
                  height: sizeH(context),
                  child: VideoWindow(
                    data: data,
                    controller: controller,
                  ),
                )
              : Column(
                  children: [
                    VideoWindow(
                      data: data,
                      controller: controller,
                    ),
                    Container(
                      height: sizeH(context),
                      child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          ProfileBar(
                            data: data,
                            controller: controller,
                          ),
                          _buildRelatedTile(context),
                          SizedBox(height: sizeH(context) * .3)
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildRelatedTile(BuildContext context) {
    return Container(
      height: sizeH(context),
      child: StreamBuilder<EyeRelated>(
          stream: netool.pullEyeRelated(id: data.id).asStream(),
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
                      return RelatedTile(item: snapshot.data.itemList[index]);
                    }
                    return Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Material(
                          color: index.isEven ? Colors.blueAccent : Colors.teal,
                          child: InkWell(
                            onTap: () {},
                            child: Center(
                              child: freeTxT(
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
  const RelatedTile({@required this.item});

  final RelatedItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        statusBar(status: 1, isHide: true);
        pushReplace(context, video_detail, args: {'data': item.data});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: item.data.cover.detail ?? picDemo,
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
              child: timeTxT(item.data.duration),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBar extends StatelessWidget {
  const ProfileBar({this.data, this.controller});
  final InnerData data;
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAuthorBar(context),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: data.description,
              style: TextStyle(color: Colors.black),
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthorBar(BuildContext context) {
    return InkWell(
      onTap: () {
        statusBar(status: 1, isHide: false);
        controller.pause();
        pushReplace(context, video_author, args: {'data': data});
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: Image.network(
                data.author.icon,
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
              freeTxT(data.author.name),
              SizedBox(height: 4.0),
              Container(
                width: sizeW(context) * .66,
                child: freeTxT(data.author.description, size: 13.0),
              ),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class VideoWindow extends StatefulWidget {
  const VideoWindow({Key key, this.data, this.controller}) : super(key: key);

  final InnerData data;
  final VideoPlayerController controller;

  @override
  State<StatefulWidget> createState() => _VideoWindowState();
}

class _VideoWindowState extends State<VideoWindow> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio < 16 / 12
          ? 16 / 9
          : widget.controller.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(widget.controller),
          CtrlPlayUI(
            widget.controller,
            data: widget.data,
          ),
        ],
      ),
    );
  }
}

class CtrlPlayUI extends StatefulWidget {
  const CtrlPlayUI(this.controller, {this.data});

  final VideoPlayerController controller;
  final InnerData data;

  @override
  State<StatefulWidget> createState() => _CtrlPlayUIState();
}

class _CtrlPlayUIState extends State<CtrlPlayUI> {
  double _opacity = 1.0;
  bool isLike = false;
  bool isPause = true;

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 2), (timer) {
      _opacity = 0.0;
      if (!widget.controller.value.isPlaying) {
        _opacity = 1.0;
      }
      timer.cancel();
    });
    statusBar(isHide: true);
    return Stack(
      children: [
        isPause
            ? netPic(pic: widget.data.cover.detail, fit: BoxFit.cover)
            : Container(),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? Opacity(
                  opacity: _opacity,
                  child: Container(
                    color: Colors.black38,
                    child: Align(
                      child: Container(
                        child: Icon(
                          Icons.pause,
                          color: Colors.white70,
                          size: 48.0,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  color: Colors.black38,
                  child: Align(
                    child: Container(
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
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
            setState(() {
              isPause = false;
            });
            statusBar(status: 1, isHide: true);
          },
          onVerticalDragStart: (_) {
            statusBar(status: 1, isHide: true);
          },
        ),
        widget.controller.value.isPlaying
            ? Container()
            : buildCtrlOverlay(
                context,
                data: widget.data,
                controller: widget.controller,
              ),
      ],
    );
  }

  Widget buildCtrlOverlay(
    BuildContext context, {
    InnerData data,
    VideoPlayerController controller,
  }) {
    return Container(
      width: sizeW(context),
      height: sizeH(context),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    onTap: () async => dirAxis(context) == Orientation.landscape
                        ? portrait()
                        : pop(context),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    top: dirAxis(context) == Orientation.landscape
                        ? sizeH(context) * .04
                        : sizeH(context) * .018,
                  ),
                  child: dirAxis(context) == Orientation.landscape
                      ? freeTxT(data.title, size: 22.0, color: Colors.white)
                      : Container(
                          alignment: Alignment.topCenter,
                          width: sizeW(context) * .7,
                          child: freeTxT(
                            data.title,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(top: 8.0),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 26.0,
                ),
                tooltip: '更多',
                onPressed: () {},
              )
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.thumb_up,
                    color: isLike
                        ? Colors.lightBlue
                        : Colors.white.withOpacity(0.9),
                  ),
                  iconSize: 24.0,
                  tooltip: '点赞',
                  onPressed: () async {
                    setState(() {
                      isLike = !isLike;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    dirAxis(context) == Orientation.landscape
                        ? Icons.fullscreen_exit
                        : Icons.fullscreen,
                    color: Colors.white.withOpacity(0.9),
                    size: 28.0,
                  ),
                  tooltip: '横屏',
                  onPressed: () {
                    dirAxis(context) == Orientation.landscape
                        ? portrait()
                        : landscape(isHide: true);
                  },
                ),
              ],
            ),
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
