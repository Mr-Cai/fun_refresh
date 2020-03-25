import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import '../tools/api.dart';
import '../tools/global.dart';

BannerAd createBannerAd({@required AdSize size}) {
  return BannerAd(
    adUnitId: bannerUnit,
    size: size,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {},
  );
}

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
                child: tail ?? menuIcon(context, icon: 'next', size: 16.0),
              ),
            ],
          ),
        )
      ],
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

Widget netPic({
  String pic,
  BoxFit fit,
  Widget holder,
  Widget errorH,
}) {
  return CachedNetworkImage(
    imageUrl: pic,
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
