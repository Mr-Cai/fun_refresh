import 'package:flutter/material.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:fun_refresh/tools/global.dart';

Widget backBTN(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(12.0),
    height: sizeH$15(context),
    width: sizeW$10(context),
    child: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      iconSize: sizeW$8(context),
      onPressed: () => pop(context),
    ),
  );
}
