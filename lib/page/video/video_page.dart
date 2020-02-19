import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../components/video_item.dart';
import '../../model/video/eye_video.dart';
import '../../model/i18n/i18n.dart';
import '../../tools/net_tool.dart';

class VideoPage extends StatefulWidget with NavigationState{
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Orientation orientation;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.didChangeDependencies();
  }

  @override
  build(context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(I18n.of(context).video, textScaleFactor: 1.3),
        ),
        body: RefreshIndicator(
          onRefresh: () => netool.pullEyeVideo(),
          child: FutureBuilder<EyeVideo>(
            future: netool.pullEyeVideo(),
            builder: (context, snapshot) {
              orientation = MediaQuery.of(context).orientation;
              if (snapshot.hasData) {
                return orientation == Orientation.portrait
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 32.0),
                        itemCount: snapshot.data.itemList.length ?? 0,
                        itemBuilder: (context, index) =>
                            snapshot.data.itemList[index].type == 'textCard' ||
                                    snapshot.data.itemList[index].type ==
                                        'banner'
                                ? Container()
                                : VideoCover(snapshot, index),
                      )
                    : GridView.count(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        children: List.generate(
                          snapshot.data.itemList.length ?? 0,
                          (index) => snapshot.data.itemList[index].type ==
                                      'textCard' ||
                                  snapshot.data.itemList[index].type == 'banner'
                              ? Container()
                              : VideoCover(snapshot, index),
                        ),
                      );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
}

class VideoCover extends StatefulWidget {
  VideoCover(this.snapshot, this.index);
  final AsyncSnapshot<EyeVideo> snapshot;
  final int index;

  @override
  _VideoCoverState createState() => _VideoCoverState();
}

class _VideoCoverState extends State<VideoCover> {
  bool _visible = false;
  Widget _opacity = Icon(Icons.play_arrow, size: 48.0, color: Colors.white54);
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InnerData item =
        widget.snapshot.data.itemList[widget.index].data.content.data;
    return Stack(
      children: [
        VideoItem(
          image: item.cover.detail,
          video: item.playUrl,
        ),
        Positioned(
          left: .0,
          bottom: .0,
          top: .0,
          right: .0,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  Future.delayed(Duration(milliseconds: 555), () {
                    setState(() {
                      _opacity = Container();
                    });
                  });
                  return _opacity = Center(
                      child: Text(
                    I18n.of(context).tryHint,
                    style: TextStyle(color: Colors.white),
                  ));
                });
              },
              child: _opacity),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .1,
              color: Colors.transparent,
            ),
            onTap: () => setState(() => _visible = !_visible),
          ),
        ),
        Positioned(
          left: 0.0,
          top: 0.0,
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .25,
              color: Colors.transparent,
            ),
            onTap: () => setState(() => _visible = !_visible),
          ),
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * .4,
              height: MediaQuery.of(context).size.height * .25,
              color: Colors.transparent,
            ),
            onTap: () => setState(() => _visible = !_visible),
          ),
        ),
        Positioned(
          top: 12.0,
          right: 64.0,
          child: AnimatedOpacity(
            child: GestureDetector(
              onTap: () {},
              child: Text(
                item.title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            duration: Duration(milliseconds: 333),
            opacity: _visible ? 1.0 : 0.0,
          ),
        ),
        Positioned(
          top: 32.0,
          right: 64.0,
          child: AnimatedOpacity(
            child: GestureDetector(
              onTap: () {},
              child: Text(
                item.author.name,
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
            duration: Duration(milliseconds: 333),
            opacity: _visible ? 1.0 : 0.0,
          ),
        ),
        Positioned(
          right: 12.0,
          top: 12.0,
          child: GestureDetector(
            onTap: () {},
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 333),
              opacity: _visible ? 1.0 : 0.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(item.author.icon),
              ),
            ),
          ),
        ),
        Positioned(
          right: 8.0,
          bottom: 8.0,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 333),
            opacity: _visible ? 1.0 : 0.0,
            child: _visible
                ? IconButton(
                    icon: Icon(Icons.fullscreen),
                    onPressed: () {
                      Orientation orientation =
                          MediaQuery.of(context).orientation;
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          SystemChrome.setEnabledSystemUIOverlays(
                              [SystemUiOverlay.bottom]);
                          return WillPopScope(
                            child: RotatedBox(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: VideoItem(
                                  image: item.cover.detail,
                                  video: item.playUrl,
                                ),
                              ),
                              quarterTurns:
                                  orientation == Orientation.portrait ? 1 : 4,
                            ),
                            onWillPop: () {
                              Navigator.of(context).pop();
                              return SystemChrome.setEnabledSystemUIOverlays(
                                  SystemUiOverlay.values);
                            },
                          );
                        },
                      );
                    },
                    color: Colors.white,
                  )
                : Container(),
          ),
        ),
      ],
    );
  }
}
