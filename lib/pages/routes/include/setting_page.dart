import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../model/data/local_asset.dart' show defaultArgs, settingTxT;
import '../../../components/theme.dart';

class SettingsPage extends StatefulWidget with NavigationState {
  const SettingsPage(this.isPush);

  final bool isPush;

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    statusBar(status: 1);
    super.initState();
  }

  @override
  void dispose() {
    statusBar(status: 1);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dividerColor,
      appBar: TopBar(
        title: '设置',
        isSafeArea: false,
        isGradient: true,
        themeColor: Colors.white,
        isMenu: widget.isPush ? false : true,
        actions: [
          menuIcon(
            context,
            icon: 'info',
            color: Colors.white,
            size: 28.0,
            onTap: () {
              pushName(context, 'name', args: defaultArgs);
            },
          )
        ],
      ),
      body: Stack(
        children: [
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
                GestureDetector(
                  child: freeTxT('《服务协议》', color: Colors.blue),
                  onTap: () {
                    pushName(context, web_view, args: {'url': agreement});
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('|'),
                ),
                GestureDetector(
                  child: freeTxT(
                    '《隐私政策》',
                    color: Colors.blue,
                  ),
                  onTap: () {
                    pushName(context, web_view, args: {'url': private});
                  },
                ),
              ],
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
