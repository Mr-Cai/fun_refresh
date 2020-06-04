import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../components/wheel.dart';

class RewardPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Roulette(),
          Positioned(
            top: 6.0,
            left: 0.0,
            right: 0.0,
            child: TopBar(
              title: '奖励',
              isMenu: true,
              themeColor: Colors.white,
            ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
