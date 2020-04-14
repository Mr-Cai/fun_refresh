import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/global.dart';

class GirlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GirlPageState();
}

class _GirlPageState extends State<GirlPage> {
  @override
  void initState() {
    autoScreenDir();
    super.initState();
  }

  @override
  void dispose() {
    statusBar();
    portrait();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        title: '美女宝典',
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 146,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              pushName(context, photos, args: {'data': girlPhotos[index]});
            },
            child: Container(
              width: sizeW(context),
              height: sizeH(context),
              child: netPic(
                pic: girlPhotos[index],
                fit: dirAxis(context) == Orientation.landscape
                    ? BoxFit.contain
                    : BoxFit.fitWidth,
              ),
            ),
          );
        },
      ),
    );
  }

  List<String> get girlPhotos => [
        for (var i = 0; i < 145; i++)
          'https://qiniu.easyapi.com/photo/girl$i.jpg',
      ];
}
