import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({this.args});

  final Map<String, String> args;

  @override
  State<StatefulWidget> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          VideoWindow(
            url: widget.args['url'],
          ),
        ],
      ),
    );
  }
}

class VideoWindow extends StatefulWidget {
  const VideoWindow({@required this.url});

  final String url;

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
    controller.play();
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
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(controller),
          CtrlPlayUI(controller),
        ],
      ),
    );
  }
}

class CtrlPlayUI extends StatelessWidget {
  const CtrlPlayUI(this.controller);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black12,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white70,
                      size: 48.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        controller.value.isPlaying ? Container() : buildCtrlOverlay(context),
      ],
    );
  }

  Widget buildCtrlOverlay(BuildContext context) {
    return Container(
      width: sizeW(context),
      height: sizeH(context),
      child: Stack(
        children: [
          backBTN(context),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: IconButton(
              icon: Icon(
                Icons.fullscreen,
                color: Colors.white,
              ),
              tooltip: '全屏',
              onPressed: () {
                
              },
            ),
          )
        ],
      ),
    );
  }
}
