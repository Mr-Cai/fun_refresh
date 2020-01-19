import 'package:flutter/material.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:fun_refresh/tools/global.dart';

Widget backBTN(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(12.0),
    alignment: Alignment.centerLeft,
    height: sizeH$15(context),
    width: double.infinity,
    child: IconButton(
      iconSize: 32.0,
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => pop(context),
    ),
  );
}
