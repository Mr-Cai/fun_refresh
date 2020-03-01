import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:tencent_ad/native.dart';
import '../../components/video_item.dart';
import 'package:fun_refresh/tools/global.dart';
import '../../components/top_bar.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../model/mock/video/eye_video.dart';
import '../../model/i18n/i18n.dart';
import '../../tools/net_tool.dart';

class VideoPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final adKey = GlobalKey<NativeExpressAdState>();
  ScrollController _scrollCtrl;

  @override
  void initState() {
    _scrollCtrl = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 320.0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).video,
      ),
      body: RefreshIndicator(
        onRefresh: () => netool.pullEyeVideo(),
        child: StreamBuilder<EyeVideo>(
          stream: netool.pullEyeVideo().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListWheelScrollView(
                controller: _scrollCtrl,
                itemExtent: sizeH(context) * .25,
                physics: BouncingScrollPhysics(),
                children: List.generate(
                  snapshot.data.itemList.length,
                  (index) {
                    if (snapshot.data.itemList[index].type == 'textCard' ||
                        snapshot.data.itemList[index].type == 'banner') {
                      return NativeExpressAdWidget(config['nativeID'],
                          adKey: adKey, adEventCallback: (event, _) {
                        switch (event) {
                          case NativeADEvent.onADOpenOverlay:
                          case NativeADEvent.onRenderSuccess:
                          case NativeADEvent.onLayoutChange:
                          case NativeADEvent.onADClicked:
                            return NativeExpressAdWidget(
                              config['nativeID'],
                            );
                          case NativeADEvent.onNoAD:
                          case NativeADEvent.onADClosed:
                          case NativeADEvent.onRenderFail:
                            return errorLoad(
                              context,
                              height: sizeH(context) * .2,
                            );
                            break;
                          default:
                            return errorLoad(
                              context,
                              height: sizeH(context) * .2,
                            );
                        }
                      });
                    }
                    return VideoCover(
                      snapshot,
                      index,
                    );
                  },
                ),
                onSelectedItemChanged: (index) {
                  VideoItem(
                    image: snapshot
                        .data.itemList[index].data.content.data.cover.detail,
                    video:
                        snapshot.data.itemList[index].data.content.data.playUrl,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: RefreshProgressIndicator());
          },
        ),
      ),
    );
  }
}

class VideoCover extends StatelessWidget {
  const VideoCover(this.snapshot, this.index);

  final AsyncSnapshot<EyeVideo> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    final data = snapshot.data.itemList[index].data.content.data;
    return Stack(
      children: [
        VideoItem(
          image: data.cover.detail,
          video: data.playUrl,
        )
      ],
    );
  }
}
