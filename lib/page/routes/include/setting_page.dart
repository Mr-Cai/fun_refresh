import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/components/common_app_bar.dart';
import 'package:fun_refresh/model/data/local_asset.dart' show settingTxT;
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/pic_tool.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: '设置',
        bgColor: Colors.white,
        backColor: Colors.black,
        titleColor: Colors.black,
        top: sizeH$2(context),
        right: sizeW$5(context),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              iconX('info'),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: settingTxT.length ?? 0,
        physics: BouncingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          if (index == 1) {
            return Divider(
              height: 8.0,
              color: Color(0xfff1f2f7),
              thickness: 10.0,
            );
          }
          return Divider(
            height: 0.0,
            color: Color(0xfff1f2f7),
            thickness: 1.0,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          if (index == settingTxT.length - 2) {
            return Container(
              color: Colors.white,
              child: ListTile(
                dense: true,
                leading: Text(
                  settingTxT[index],
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            );
          }
          if (index == settingTxT.length - 1) {
            return Container(
              margin: EdgeInsets.all(8.0),
              height: 40.0,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.red,
                child: Text(
                  '退出登录',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.values[0],
                  ),
                ),
                onPressed: () {},
              ),
            );
          }
          if (index != settingTxT.length - 1) {
            return Container(
              color: Colors.white,
              child: ListTile(
                dense: true,
                leading: Text(
                  settingTxT[index],
                  style: TextStyle(fontSize: 18.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.withOpacity(0.5),
                  size: 18.0,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
