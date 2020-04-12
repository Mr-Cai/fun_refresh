import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

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

void tip(
  String txt,
  BuildContext context, {
  int gravity,
  Color bgColor,
  Color textColor,
  double bgRadius,
  Border border,
}) {
  Toast.show(
    txt,
    context,
    gravity: gravity,
    backgroundColor: bgColor,
    textColor: textColor,
    backgroundRadius: bgRadius,
    border: border,
  );
}

// 动态尺寸获取 $ <=> % ($50 == 50%)
// 常用宽度:
double sizeW(context) => MediaQuery.of(context).size.width;
// 常用高度:
double sizeH(context) => MediaQuery.of(context).size.height;

/// 文件路径快速填写
/// `name`: 文件名称
/// `type`: 文件类型
/// 0:动画、1:音效、2:字体、3:图片、4:简谱、5:图标 ...
/// `format`: 文件格式(每种文件都有默认格式, 也可自选格式)
String path(String name, int type, {String format}) {
  switch (type) {
    case 0:
      return 'assets/animations/$name.${format ?? 'flr'}';
      break;
    case 1:
      return 'assets/audio/$name.${format ?? 'mp3'}';
      break;
    case 2:
      return 'assets/fonts/$name.${format ?? 'ttf'}';
      break;
    case 3:
      return 'assets/images/$name.${format ?? 'png'}';
      break;
    case 4:
      return 'assets/json/$name.${format ?? 'json'}';
      break;
    case 5:
      return 'assets/svg/$name.${format ?? 'svg'}';
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

/// `status` : { 0: dark, else: light }
/// `isHide` : { true: autoHide, false: visible default }
Future<void> statusBar({int status = 0, bool isHide = false}) async {
  if (isHide) {
    SystemChrome.setEnabledSystemUIOverlays([]); // 隐藏状态栏
  } else {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: status == 0 ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            status == 0 ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            status == 0 ? Brightness.dark : Brightness.light,
      ),
    );
  }
}

Orientation dirAxis(BuildContext context) {
  return MediaQuery.of(context).orientation;
}

void portrait() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

void autoScreenDir() {
  SystemChrome.setPreferredOrientations([]);
}

void landscape({bool isHide}) {
  statusBar(isHide: isHide ?? true);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
