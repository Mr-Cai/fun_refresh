import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/global.dart' show sizeH;
import 'package:video_player/video_player.dart';

import 'fade_animation.dart';
import 'mini.dart';

class VideoItem extends StatefulWidget {
  final String image;
  final String video;

  const VideoItem({this.image, this.video});

  @override
  State<StatefulWidget> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  var _videoStatusAnimation;
  Widget coverHolder;

  @override
  void initState() {
    super.initState();
    _videoStatusAnimation = Container();
    _controller = VideoPlayerController.network(widget.video);
    _controller.play();
    coverHolder = CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: widget.image,
      placeholder: (_, __) => Center(
        child: RefreshProgressIndicator(),
      ),
      errorWidget: (_, __, ___) => errorLoad(
        context,
        height: sizeH(context) * .2,
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 16 / 9,
        child: _controller.value.initialized
            ? _videoPlayer()
            : InkWell(
                onTap: () {
                  setState(() {
                    coverHolder = Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.black12),
                      ),
                    );
                  });
                  _controller
                    ..addListener(() {
                      bool isPlaying = _controller.value.isPlaying;
                      if (isPlaying != _isPlaying) {
                        setState(() => _isPlaying = isPlaying);
                      }
                    })
                    ..initialize().then((_) {
                      if (!mounted) return;
                      setState(() => _controller.play());
                    });
                },
                child: coverHolder,
              ),
      );

  _videoPlayer() => Stack(
        children: [
          _video(),
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(playedColor: Colors.white),
            ),
          ),
          Center(child: _videoStatusAnimation),
        ],
      );

  _video() => InkWell(
        child: VideoPlayer(_controller),
        onTap: () {
          if (!_controller.value.initialized) return;
          if (_controller.value.isPlaying) {
            _videoStatusAnimation = FadeAnimation(
                child: Icon(Icons.pause, size: 48.0, color: Colors.white));
            _controller.pause();
          } else {
            _videoStatusAnimation = FadeAnimation(
                child: Icon(Icons.play_arrow, size: 48.0, color: Colors.white));
            _controller.play();
          }
        },
      );
}
