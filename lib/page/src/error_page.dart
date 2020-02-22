import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/i18n/i18n.dart';
import 'package:fun_refresh/tools/global.dart';

class ErrorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(
          themeColor: Colors.black,
          title: I18n.of(context).error,
        ),
        body: Column(
          children: [
            Container(
              height: sizeH(context) * .6,
              child: FlareActor(
                'asset/animation/404.flr',
                animation: 'idle',
              ),
            ),
            Text(
              '糟糕 ! 页面找不到了 !!!',
              textScaleFactor: 1.6,
            )
          ],
        ));
  }
}
