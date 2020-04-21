import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/mock/video/tiktok_hot_week.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';
import 'package:video_player/video_player.dart';

class ShortVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShortVideoPageState();
}

class _ShortVideoPageState extends State<ShortVideoPage> {
  List<String> itemIDs = [];

  @override
  void initState() {
    statusBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '短视频',
        themeColor: Colors.black,
      ),
      body: StreamBuilder<List<TiktokHotWeek>>(
        stream: requestTiktokWeekHot().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                return requestTiktokWeekHot();
              },
              child: ListView(
                children: List.generate(
                  snapshot.data.length,
                  (index) {
                    return VlogItem(response: snapshot.data[index]);
                  },
                ),
              ),
            );
          }
          return Center(child: flareAnim(context));
        },
      ),
    );
  }

  Future<List<TiktokHotWeek>> requestTiktokWeekHot() async {
    await netool.requestTikTokItemIDs().then((value) => itemIDs.addAll(value));
    return Future.wait(
      List.generate(
        itemIDs.length ?? 0,
        (index) => netool.requestTiktokWeekHot(itemIDs[index]),
      ),
    );
  }
}

class VlogItem extends StatefulWidget {
  const VlogItem({this.response});

  final TiktokHotWeek response;

  @override
  State<StatefulWidget> createState() => _VlogItemState();
}

class _VlogItemState extends State<VlogItem> {
  VideoPlayerController controller;
  String playUrl;

  @override
  void initState() {
    playUrl = widget.response.itemList[0].video.playAddr.urlList[1];
    controller = VideoPlayerController.network(playUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..pause()
      ..setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeW(context),
      height: sizeH(context),
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(controller),
            GestureDetector(
              onTap: () {
                setState(() {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
