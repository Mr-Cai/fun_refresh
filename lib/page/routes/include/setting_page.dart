import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:tencent_ad/banner.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../model/data/local_asset.dart' show config, settingTxT;
import '../../../model/data/theme.dart';

class SettingPage extends StatefulWidget with NavigationState {
  const SettingPage(this.isPush);

  final bool isPush;

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _bannerKey = GlobalKey<UnifiedBannerAdState>();
  bool _bannerClose = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dividerColor,
      appBar: TopBar(
        title: '设置',
        bgColor: Colors.white,
        themeColor: Colors.black,
        left: sizeW(context) * 0.15,
        isMenu: widget.isPush ? false : true,
        actions: [
          Container(
            margin: const EdgeInsets.all(6.0),
            child: IconButton(
              icon: SvgPicture.asset(
                path('info', 5),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
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
                  margin: const EdgeInsets.all(8.0),
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
          Positioned(
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            child: Container(
              height: _bannerClose == true ? 0 : 64.0,
              child: UnifiedBannerAd(
                config['bannerID'],
                key: _bannerKey,
                refreshOnCreate: true,
                adEventCallback: (event, args) {
                  if (event == BannerEvent.onAdClosed) {
                    _bannerClose = true;
                    _bannerKey.currentState.loadAD();
                  }
                  if (event == BannerEvent.onNoAD) {
                    _bannerKey.currentState.loadAD();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
