import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../page/export_page_pkg.dart';
import '../../components/disclaimer_dialog.dart';
import '../../model/i18n/i18n.dart';
import '../../tools/global.dart';
import '../../tools/pic_tool.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

// 闪屏页面
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _prefs = SharedPreferences.getInstance();
  Future<bool> _unknow;
  GlobalKey<DisclaimerMsgState> dialogKey;
  @override
  void initState() {
    if (dialogKey == null) {
      dialogKey = GlobalKey<DisclaimerMsgState>();
      // 获取偏好设置存储
      _unknow = _prefs.then((SharedPreferences prefs) {
        return (prefs.getBool(dialogPrefKey) ?? false);
      });
      _unknow.then((bool value) {
        if (!value) {
          dialogKey.currentState.showDisClaimerDialog(context);
        } else {
          Future.delayed(
            Duration(milliseconds: 666),
            () => pushReplace(context, home),
          );
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              DisclaimerMsg(state: this, key: dialogKey),
              Image.asset(
                Platform.isAndroid
                    ? picX('android_cover')
                    : picX('apple_cover'),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * .85,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                    child: SvgPicture.asset(
                      iconX('launch_icon'),
                      width: 58.0,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        I18n.of(context).appName,
                        textScaleFactor: 1.4,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        I18n.of(context).desc,
                        style: TextStyle(color: Colors.black45),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
