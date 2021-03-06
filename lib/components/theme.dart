import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 文字样式
// 默认黑色小字
blackTxT(String text) => Text(
      text,
      style: TextStyle(color: Colors.black38),
      textScaleFactor: 0.8,
    );

Widget freeTxT(
  String text, {
  double width = .1,
  double height = .1,
  int maxLines = 1,
  bool isBold = false,
  double size = 16.0,
  bool isSlim = true,
  Color color = Colors.black,
  int fontValue = 2,
}) {
  return Text(
    text,
    maxLines: maxLines,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: isBold
          ? FontWeight.bold
          : isSlim ? FontWeight.values[fontValue] : FontWeight.normal,
    ),
  );
}

final whiteTxT = TextStyle(color: Colors.white);

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

/// 常用颜色
final divColor = Color(0xFFF1F2F7); // 分隔线颜色
