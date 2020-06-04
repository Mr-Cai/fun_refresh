import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../model/data/local_asset.dart'
    show configID, defaultArgs, settingTxT;
import '../../../components/theme.dart';

class SettingsPage extends StatefulWidget with NavigationState {
  const SettingsPage(this.isPush);

  final bool isPush;

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _cacheSize = '';
  @override
  void initState() {
    _loadCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: divColor,
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
              ItemTile(
                index: 0,
                arrow: true,
                onTap: () {
                  HapticFeedback.selectionClick();
                },
                event: () {
                  HapticFeedback.selectionClick();
                },
              ),
              ItemTile(index: 1, arrow: true),
              divLine(),
              ItemTile(
                index: 2,
                arrow: true,
                icon: Icons.refresh,
                onTap: () async {
                  _clearCache();
                  HapticFeedback.selectionClick();
                },
                label: freeTxT(_cacheSize),
                event: () async {
                  _loadCache(isToast: true);
                  HapticFeedback.vibrate();
                },
              ),
              exitBTN(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 72.0,
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: NativeAdmob(
                adUnitID: configID['nativeID'],
                type: NativeAdmobType.banner,
                loading: flareAnim(context),
                controller: NativeAdmobController()
                  ..reloadAd(forceRefresh: true),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.78),
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

  Widget exitBTN() {
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

  Future<void> _loadCache({bool isToast = false}) async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _computeCacheSize(tempDir);
    setState(() {
      _cacheSize = _renderSize(value);
      if (isToast) {
        Toast.show(
          '正在更新缓存: ${_renderSize(value)}',
          context,
          gravity: Toast.CENTER,
          backgroundColor: Colors.orange,
        );
      }
    });
  }

  Future<double> _computeCacheSize(FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse('$length');
    }
    if (file is Directory) {
      final List<FileSystemEntity> fileEntities = file.listSync();
      double total = 0;
      if (fileEntities != null) {
        for (var item in fileEntities) {
          total += await _computeCacheSize(item);
        }
        return total;
      }
      return 0;
    }
    return 0.0;
  }

  String _renderSize(double value) {
    if (null == value) return '0';

    final unitArr = [
      '\rB',
      '\rK',
      '\rM',
      '\rG',
    ];

    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }

    String size = value.toStringAsFixed(2);
    return size += unitArr[index];
  }

  void _clearCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      await delDir(tempDir);
      await _loadCache();
      Toast.show(
        '清除缓存成功',
        context,
        gravity: Toast.CENTER,
        backgroundColor: Colors.orange,
      );
    } catch (e) {
      Toast.show('清除缓存失败 \n$e', context,
          gravity: Toast.CENTER, backgroundColor: Colors.orange);
    }
  }

  Future<void> delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    this.onTap,
    this.arrow,
    this.index,
    this.label,
    this.event,
    this.icon,
  });

  final Function onTap;
  final bool arrow;
  final int index;
  final Widget label;
  final Function event;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            dense: true,
            leading: InkWell(
              onTap: onTap,
              child: Container(
                width: sizeW(context) * .6,
                height: 42.0,
                alignment: Alignment.centerLeft,
                child: Text(
                  settingTxT[index],
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: label ?? Container(),
                ),
              ],
            ),
            trailing: arrow == true
                ? InkWell(
                    onTap: event,
                    child: Icon(
                      icon ?? Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22.0,
                    ),
                  )
                : null,
          ),
        ),
        divLine(color: divColor, height: 2.0)
      ],
    );
  }
}
