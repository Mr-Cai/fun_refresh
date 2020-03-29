import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:tencent_ad/native.dart';
import 'package:fun_refresh/tools/global.dart';
import '../../components/top_bar.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../model/mock/video/eye_video.dart';
import '../../model/i18n/i18n.dart';
import '../../tools/net_tool.dart';
import '../export_page_pkg.dart';

class VideoPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int currentIndex = 1;
  FixedExtentScrollController _scrollCtrl;
  GlobalKey<NativeExpressAdState> adKey;
  bool isADLoading = false;

  @override
  void initState() {
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
                  statusBar(status: 1, isHide: true);
                  pushName(
                    context,
                    video_detail,
                    args: {
                      'data': snapshot
                          .data.itemList[currentIndex].data.content.data,
                    },
                  );
                },
                child: ListWheelScrollView(
                  itemExtent: sizeH(context) * .25,
                  controller: _scrollCtrl,
                  physics: BouncingScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  children:
                      List.generate(snapshot.data.itemList.length, (index) {
                    if (snapshot.data.itemList[index].type == 'textCard' ||
                        snapshot.data.itemList[index].type == 'banner') {
                      return Stack(
                        children: [
                          NativeExpressAdWidget(
                            config['nativeID'],
                            adKey: adKey,
                            adEventCallback: (event, args) {
                              switch (event) {
                                case NativeADEvent.onNoAD:
                                case NativeADEvent.onRenderFail:
                                case NativeADEvent.onADCloseOverlay:
                                case NativeADEvent.onADClosed:
                                case NativeADEvent.onADLeftApplication:
                                  setState(() {
                                    adKey.currentState.refreshAd();
                                    return isADLoading = true;
                                  });
                                  break;
                                case NativeADEvent.onRenderSuccess:
                                  setState(() => isADLoading = false);
                                  break;
                                default:
                              }
                            },
                          ),
                          Align(
                            child: isADLoading
                                ? RefreshProgressIndicator()
                                : Container(),
                          ),
                        ],
                      );
                    }
                    return CoverTile(
                      data: snapshot.data.itemList[index].data.content.data,
                    );
                  }),
                ),
              );
            } else if (snapshot.hasError) {
              return holderPage(context);
            }
            return Center(
              child: flareAnim(context),
            );
          },
        ),
      ),
    );
  }
}

class CoverTile extends StatelessWidget {
  const CoverTile({@required this.data});

  final InnerData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: data.cover.detail,
              width: sizeW(context) * .96,
              placeholder: (_, __) => Center(
                child: RefreshProgressIndicator(),
              ),
              errorWidget: (_, __, ___) => holderPage(
                context,
                height: sizeH(context) * .2,
              ),
            ),
          ),
        ),
        Positioned(
          top: 12.0,
          left: 18.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.all(4.0),
              color: Colors.black.withOpacity(0.2),
              child: slimTxT(
                secToTime(data.duration),
                color: Colors.white,
                size: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
