import 'package:flutter/material.dart';
import 'package:fun_refresh/components/disclaimer_dialog.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/page/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:tencent_ad/banner.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../model/data/local_asset.dart' show config, settingTxT;
import '../../../components/theme.dart';

class SettingsPage extends StatefulWidget with NavigationState {
  const SettingsPage(this.isPush);

  final bool isPush;

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _bannerKey = GlobalKey<UnifiedBannerAdState>();
  bool _bannerClose = false;
  final dialogKey = GlobalKey<DisclaimerMsgState>();

  @override
  Widget build(BuildContext context) {
    statusBar(status: 1);
    return Scaffold(
      backgroundColor: dividerColor,
      appBar: TopBar(
        title: '设置',
        isSafeArea: false,
        isGradient: true,
        themeColor: Colors.white,
        isMenu: widget.isPush ? false : true,
        actions: [menuIcon(context, icon: 'info', color: Colors.white)],
      ),
      body: Stack(
        children: [
          DisclaimerMsg(state: this, key: dialogKey),
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              $HLine(),
              ItemTile(index: 0, isTrail: true),
              $HLine(),
              ItemTile(index: 1, isTrail: true),
              ItemTile(index: 2, isTrail: true),
              $HLine(),
              _buildBTN(),
            ],
          ),
          Align(
            alignment: Alignment(0.0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                slimTxT('《服务协议》', color: Colors.blue, onTap: () {
                  pushName(context, web_view, args: {'url': agreement});
                }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('|'),
                ),
                slimTxT('《隐私政策》', color: Colors.blue, onTap: () {
                  pushName(context, web_view, args: {'url': private});
                }),
              ],
            ),
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

  Widget _buildBTN() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: FlatButton(
        padding: const EdgeInsets.all(8.0),
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
}

class ItemTile extends StatelessWidget {
  const ItemTile({this.onTap, this.isTrail, this.index});

  final Function onTap;
  final bool isTrail;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        color: Colors.white,
        child: ListTile(
          dense: true,
          leading: Text(
            settingTxT[index],
            style: TextStyle(fontSize: 18.0),
          ),
          trailing: isTrail == true
              ? Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey.withOpacity(0.5),
                  size: 18.0,
                )
              : null,
        ),
      ),
    );
  }
}
