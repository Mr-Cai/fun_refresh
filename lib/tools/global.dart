import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';

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

void tip(String txt, BuildContext context) {
  Toast.show(txt, context);
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

/// 文件路径快速填写
/// `name`: 文件名称
/// `type`: 文件类型
/// 动画:0、音效:1、字体:2、图片:3、简谱:4、图标:5 ...
/// `format`: 文件格式(每种文件都有默认格式, 也可自选格式)
String path(String name, int type, {String format}) {
  switch (type) {
    case 0:
      return 'asset/animation/$name.${format ?? 'flr'}';
      break;
    case 1:
      return 'asset/audio/$name.${format ?? 'mp3'}';
      break;
    case 2:
      return 'asset/font/$name.${format ?? 'ttf'}';
      break;
    case 3:
      return 'asset/image/$name.${format ?? 'png'}';
      break;
    case 4:
      return 'asset/json/$name.${format ?? 'json'}';
      break;
    case 5:
      return 'asset/svg/$name.${format ?? 'svg'}';
      break;
    default:
      return '';
  }
}

String secToTime(num time) {
  String timeStr;
  num hour = 0;
  num minute = 0;
  num second = 0;
  if (time <= 0)
    return '00:00';
  else {
    minute = time / 60;
    if (minute < 60) {
      second = time % 60;
      timeStr = unitFormat(minute.toInt()) + ':' + unitFormat(second.toInt());
    } else {
      hour = minute / 60;
      if (hour > 99) return '99:59:59';
      minute = minute % 60;
      second = time - hour * 3600 - minute * 60;
      timeStr = unitFormat(hour.toInt()) +
          ':' +
          unitFormat(minute.toInt()) +
          ':' +
          unitFormat(second.toInt());
    }
  }
  return timeStr;
}

String unitFormat(num i) {
  String retStr;
  if (i >= 0 && i < 10)
    retStr = '0$i';
  else
    retStr = '$i';
  return retStr;
}

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
const web_view = '/web_view'; // 浏览器
const video_detail = '/video_detail'; // 视频详情

// 小游戏
const game2048 = '/game2048'; // 2048
const game_tetris = '/game_tetris'; // 俄罗斯方块
const game_snake = '/game_snake'; // 贪吃蛇
