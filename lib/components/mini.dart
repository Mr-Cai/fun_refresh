import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../tools/global.dart';

Widget holderPage(
  BuildContext context, {
  Map args,
  double width,
  double height,
}) {
  return Column(
    children: [
      Container(
        width: width ?? sizeW(context),
        height: height ?? sizeH(context) * .6,
        child: FlareActor(
          path(args['name'], 0),
          animation: args['anim'],
        ),
      ),
      Text(
        args['desc'],
        textScaleFactor: 1.6,
      ),
    ],
  );
}

Widget flareAnim(
  BuildContext context, {
  double width,
  double height,
  Map args,
}) {
  if (args == null) {
    args = const {
      'name': 'loading',
      'anim': 'Alarm',
    };
  }
  return Container(
    width: width ?? sizeW(context),
    height: height ?? sizeH(context) * .3,
    child: FlareActor(
      path(args['name'], 0),
      animation: args['anim'],
    ),
  );
}

Widget $ItemTile(
  BuildContext context, {
  Widget title,
  Widget subtitle,
  Widget tail,
  String route,
  bool isSlim = false,
}) {
  return InkWell(
    onTap: () {
      if (route == null) return;
      pushName(context, route);
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: sizeH(context) * .015),
      child: Row(
        children: [
          Flexible(
            flex: isSlim ? 1 : 7,
            fit: FlexFit.tight,
            child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title ??
                      Placeholder(
                        fallbackHeight: 32.0,
                        color: Colors.black,
                        strokeWidth: 1.0,
                      ),
                  subtitle ?? Container(),
                ],
              ),
            ),
          ),
          Flexible(
            flex: isSlim == null ? 1 : isSlim ? 4 : 1,
            fit: FlexFit.loose,
            child: Row(
              mainAxisAlignment: isSlim == null
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  child: tail ??
                      menuIcon(
                        context,
                        icon: 'next',
                        size: 16.0,
                        onTap: () {},
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget $HLine({double height, double thick}) {
  return Divider(
    height: height ?? 8.0,
    color: Color(0xfff1f2f7),
    thickness: thick ?? 10.0,
  );
}

Widget bank(BuildContext context) {
  return Scaffold(
    body: Center(
      child: flareAnim(context, height: sizeH(context)),
    ),
  );
}

Widget assetPic({
  String pic,
  BoxFit fit,
  bool isSvg = false,
}) {
  return isSvg
      ? SvgPicture.asset(path(pic, 5))
      : Image.asset(path(pic, 3), fit: fit ?? BoxFit.fill);
}

Widget netPic({
  String pic,
  BoxFit fit,
  Widget holder,
  Widget errorH,
}) {
  return CachedNetworkImage(
    imageUrl: pic ?? '',
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: fit ?? BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) => Center(
      child: holder ?? RefreshProgressIndicator(),
    ),
    errorWidget: (context, url, error) =>
        errorH ??
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            path('404_error', 3, format: 'jpg'),
            fit: BoxFit.fill,
          ),
        ),
  );
}

Widget timeTxT(num time) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: Container(
      padding: const EdgeInsets.all(4.0),
      color: Colors.black.withOpacity(0.5),
      child: freeTxT(
        secToTime(time ?? 0.0),
        color: Colors.white,
        size: 14.0,
      ),
    ),
  );
}

class CircleTabIndicator extends Decoration {
  CircleTabIndicator({
    @required Color color,
    @required double radius,
    this.offset,
  }) : _painter = _CirclePainter(color, radius, offset);

  final BoxPainter _painter;
  final double offset;
  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  _CirclePainter(
    Color color,
    this.radius,
    this.margin,
  ) : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  final Paint _paint;
  final double radius;
  final double margin;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset +
        Offset(cfg.size.width / 2, cfg.size.height - radius - margin ?? 8.0);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

ShapeBorder corner({double radius}) {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius ?? 16.0),
  );
}

Future<void> showPrivacyDialog(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  return showDialog(
    context: context,
    barrierColor: Colors.white,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: Container(
          height: sizeH(context) * .666,
          child: Stack(
            children: [
              flareAnim(
                context,
                width: sizeW(context) * 1.8,
                height: sizeH(context),
              ),
              CupertinoAlertDialog(
                title: Center(child: freeTxT('服务协议与隐私政策')),
                content: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: WillPopScope(
                    onWillPop: () {
                      return Future.value(false);
                    },
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SelectableText(
                            '$disclaimerText',
                            style: TextStyle(height: 1.4),
                            textAlign: TextAlign.start,
                            scrollPhysics: BouncingScrollPhysics(),
                          ),
                          Wrap(
                            spacing: 48.0,
                            runAlignment: WrapAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pushName(
                                    context,
                                    web_view,
                                    args: {'url': agreement},
                                  );
                                },
                                child: freeTxT(
                                  '《服务协议》',
                                  color: Colors.blue,
                                  size: 13.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pushName(
                                    context,
                                    web_view,
                                    args: {'url': private},
                                  );
                                },
                                child: freeTxT(
                                  '《隐私政策》',
                                  color: Colors.blue,
                                  size: 13.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pushName(
                                    context,
                                    web_view,
                                    args: {'url': guide},
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 12.0),
                                  child: freeTxT(
                                    '《隐私保护指引》',
                                    color: Colors.blue,
                                    size: 13.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  FlatButton(
                    child: Text('同意并进入'),
                    onPressed: () async {
                      await prefs.setBool(disclaimer, false);
                      statusBar();
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('取消并退出'),
                    onPressed: () {
                      SystemNavigator.pop();
                      exit(1);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> judgeShowPrivacy(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  bool isShow = prefs.getBool(disclaimer) ?? true;
  if (isShow) {
    await Future.delayed(Duration(milliseconds: 50));
    statusBar(isHide: true);
    showPrivacyDialog(context);
  }
}
