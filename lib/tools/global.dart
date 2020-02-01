import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignInAccount googleUser;
var isGoogleLoginSuccess = false;
final scaffoldKey = GlobalKey<ScaffoldState>();
final dialogPrefKey = 'disclaimer';
void showSnackBar(String text) {
  final snackbar = SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 666),
  );
  scaffoldKey.currentState.showSnackBar(snackbar);
}

const targetingInfo = MobileAdTargetingInfo(
  childDirected: true,
  nonPersonalizedAds: true,
);
// 动态尺寸获取 $ <=> % ($50 == 50%)
// 常用宽度:
double sizeW(context) => MediaQuery.of(context).size.width;
double sizeW1(context) => sizeW(context) * .01;
double sizeW$5(context) => sizeW(context) * .05;
double sizeW10(context) => sizeW(context) * .10;
double sizeW15(context) => sizeW(context) * .15;
double sizeW20(context) => sizeW(context) * .20;
double sizeW$50(context) => sizeW(context) * .50;
// 常用高度:
double sizeH(context) => MediaQuery.of(context).size.height;
double sizeH$1(context) => sizeH(context) * .01;
double sizeH$5(context) => sizeH(context) * .05;
double sizeH$10(context) => sizeH(context) * .10;
double sizeH$12(context) => sizeH(context) * .12;
double sizeH$15(context) => sizeH(context) * .15;
double sizeH$16(context) => sizeH(context) * .16;
double sizeH$17(context) => sizeH(context) * .17;
double sizeH$18(context) => sizeH(context) * .18;
double sizeH$20(context) => sizeH(context) * .20;
double sizeH$25(context) => sizeH(context) * .25;
double sizeH$50(context) => sizeH(context) * .50;
