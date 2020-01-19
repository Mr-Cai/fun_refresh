import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignInAccount googleUser;
var isGoogleLoginSuccess = false;
final scaffoldKey = GlobalKey<ScaffoldState>();
final dialogPrefKey = 'disclaimer';
showSnackBar(String text) {
  final snackbar = SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 3),
  );
  scaffoldKey.currentState.showSnackBar(snackbar);
}

const targetingInfo = MobileAdTargetingInfo(
  childDirected: true,
  nonPersonalizedAds: true,
);
// 动态尺寸获取 $ <=> % ($50 == 50%)
// 常用宽度:
sizeW(context) => MediaQuery.of(context).size.width;
sizeW$1(context) => sizeW(context) * .01;
sizeW$5(context) => sizeW(context) * .05;
sizeW$50(context) => sizeW(context) * .50;
// 常用高度:
sizeH(context) => MediaQuery.of(context).size.height;
sizeH$1(context) => sizeH(context) * .01;
sizeH$5(context) => sizeH(context) * .05;
sizeH$10(context) => sizeH(context) * .10;
sizeH$15(context) => sizeH(context) * .15;
sizeH$20(context) => sizeH(context) * .20;
sizeH$25(context) => sizeH(context) * .25;
sizeH$50(context) => sizeH(context) * .50;
