import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/page/routes/route_generator.dart';
import 'package:tencent_ad/native.dart';
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
  int currentIndex = 1;
  Widget holder;
  double height;

  final adKey = GlobalKey<NativeExpressAdState>();

  FixedExtentScrollController _scrollCtrl;

  @override
  void initState() {
    holder = NativeExpressAdWidget(
      config['nativeID'],
    );
    _scrollCtrl = FixedExtentScrollController(initialItem: 2);
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
              return GestureDetector(
                onTap: () {
                  final data =
                      snapshot.data.itemList[currentIndex].data.content.data;
                  pushName(
                    context,
                    video_detail,
                    args: {
                      'url': '${data.playUrl}',
                      'index': '$currentIndex',
                    },
                  );
                },
                child: ListWheelScrollView(
                  itemExtent: sizeH(context) * .25,
                  controller: _scrollCtrl,
                  physics: BouncingScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      currentIndex = index;
                      log('$currentIndex');
                    });
                  },
                  children:
                      List.generate(snapshot.data.itemList.length, (index) {
                    if (snapshot.data.itemList[index].type == 'textCard' ||
                        snapshot.data.itemList[index].type == 'banner') {
                      return holder;
                    }
                    final data =
                        snapshot.data.itemList[index].data.content.data;
                    return Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: data.cover.detail,
                          placeholder: (_, __) => Center(
                            child: RefreshProgressIndicator(),
                          ),
                          errorWidget: (_, __, ___) => errorLoad(
                            context,
                            height: sizeH(context) * .2,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: loadingAnim(context));
          },
        ),
      ),
    );
  }
}
