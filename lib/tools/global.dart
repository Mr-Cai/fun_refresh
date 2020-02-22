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
// 常用高度:
double sizeH(context) => MediaQuery.of(context).size.height;

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

// 小游戏
const game2048 = '/game2048'; // 2048
const game_tetris = '/game_tetris'; // 俄罗斯方块
const game_snake = '/game_snake'; // 贪吃蛇
