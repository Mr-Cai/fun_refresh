import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
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
  FixedExtentScrollController _scrollCtrl;
  GlobalKey<NativeExpressAdState> adKey;

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
                  final data =
                      snapshot.data.itemList[currentIndex].data.content.data;
                  pushName(
                    context,
                    video_detail,
                    args: {
                      'url': '${data.playUrl}',
                      'index': '$currentIndex',
                      'avatar': '${data.author.icon}',
                      'name': '${data.author.name}',
                      'slogan': '${data.author.description}',
                      'title': '${data.title}',
                      'desc': '${data.description}',
                      'id': data.id,
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
                                  adKey.currentState.refreshAd();
                                  break;
                                default:
                              }
                            },
                          ),
                          Positioned(
                            bottom: 4.0,
                            right: 24.0,
                            child: SvgPicture.asset(
                              path('ic_type', 5),
                              width: 24.0,
                            ),
                          )
                        ],
                      );
                    }
                    final data =
                        snapshot.data.itemList[index].data.content.data;
                    return CoverTile(data: data);
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
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: data.cover.detail,
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
          top: 8.0,
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
