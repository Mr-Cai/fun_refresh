import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../tools/global.dart';

/// 文字样式
// 默认黑色小字
blackTxT(String text) => Text(
      text,
      style: TextStyle(color: Colors.black38),
      textScaleFactor: 0.8,
    );

// 默认黑色细体
slimTxT(String text, {double size, Color color, int no}) => Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size ?? 18.0,
        fontWeight: FontWeight.values[no ?? 0],
      ),
    );

final whiteTxT = TextStyle(color: Colors.white);

final dividerColor = Color(0xFFF1F2F7); // 分隔线颜色

final drawerTxT0 = TextStyle(
  color: Colors.white70,
  fontSize: 20.0,
  fontWeight: FontWeight.values[0],
);

final drawerTxT1 = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.values[0],
);

/// 迷你微件
// 关闭图标
Widget get xClose {
  return InkWell(
    borderRadius: BorderRadius.circular(32.0),
    onTap: () => scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('不感兴趣?'),
      backgroundColor: Colors.cyan[200],
      duration: Duration(milliseconds: 666),
      action: SnackBarAction(
        label: '屏蔽关键词,减少推荐',
        onPressed: () {},
      ),
    )),
    child: Container(
      width: 24.0,
      height: 24.0,
      child: Icon(
        Icons.close,
        color: Colors.black12,
        size: 16.0,
      ),
    ),
  );
}
