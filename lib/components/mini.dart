import 'package:firebase_admob/firebase_admob.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/top_bar.dart';
import '../tools/api.dart';
import '../tools/global.dart';

BannerAd createBannerAd({@required AdSize size}) => BannerAd(
      adUnitId: bannerUnit,
      size: size,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );

Widget errorLoad(BuildContext context, {double height}) => Column(
      children: [
        Container(
          height: height ?? sizeH(context) * .6,
          child: FlareActor(
            path('404', 0),
            animation: 'idle',
          ),
        ),
        Text(
          '糟糕 ! 页面找不到了 !!!',
          textScaleFactor: 1.6,
        ),
      ],
    );

Widget $ItemTile(
  BuildContext context, {
  Widget title,
  Widget subtitle,
  Widget tail,
}) {
  return Row(
    children: <Widget>[
      Flexible(
        flex: 8,
        fit: FlexFit.tight,
        child: Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
        flex: 2,
        fit: FlexFit.loose,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            tail ?? forwardBTN(context, ''),
          ],
        ),
      )
    ],
  );
}
