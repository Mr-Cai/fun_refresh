import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignInAccount googleUser;

bool isGoogleLoginSuccess = false;

final scaffoldKey = GlobalKey<ScaffoldState>(); // 页面框架键

final ctxKey = GlobalKey<NavigatorState>(); // 全局上下文

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
double sizeW$1(context) => sizeW(context) * .01;
double sizeW$5(context) => sizeW(context) * .05;
double sizeW$8(context) => sizeW(context) * .08;
double sizeW$9(context) => sizeW(context) * .09;
double sizeW$10(context) => sizeW(context) * .10;
double sizeW$15(context) => sizeW(context) * .15;
double sizeW$18(context) => sizeW(context) * .18;
double sizeW$20(context) => sizeW(context) * .20;
double sizeW$25(context) => sizeW(context) * .25;
double sizeW$30(context) => sizeW(context) * .30;
double sizeW$50(context) => sizeW(context) * .50;
double sizeW$60(context) => sizeW(context) * .60;
double sizeW$62(context) => sizeW(context) * .62;
double sizeW$63(context) => sizeW(context) * .63;
double sizeW$65(context) => sizeW(context) * .65;
double sizeW$70(context) => sizeW(context) * .70;
double sizeW$80(context) => sizeW(context) * .80;
double sizeW$90(context) => sizeW(context) * .90;
// 常用高度:
double sizeH(context) => MediaQuery.of(context).size.height;
double sizeH$1(context) => sizeH(context) * .01;
double sizeH$2(context) => sizeH(context) * .02;
double sizeH$3(context) => sizeH(context) * .03;
double sizeH$4(context) => sizeH(context) * .04;
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

// 页面名称:
const home = '/home'; // 首页
const detail = '/detail'; // 跳转详情
const sign = '/sign'; // 注册登录
const social = '/social'; // 社交
const mind = '/mind'; // 想法
const reward = '/reward'; // 奖励
const setting = '/setting'; // 设置
const chat = '/chat'; // 与人聊天
const profile = '/profile'; // 个人资料
const search = '/search'; // 搜索关键词
