import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:tencent_ad/reward.dart';

class RewardVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RewardVideoPageState();
}

class _RewardVideoPageState extends State<RewardVideoPage> {
  RewardAD rewardAD;
  num money = 0.00;

  @override
  void initState() {
    rewardAD = RewardAD(
      posID: configID['rewardID'],
      adEventCallback: _adEventCallback,
    );
    rewardAD.loadAD();
    money = Random().nextDouble() + Random().nextInt(100);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        title: '吐钱视频',
      ),
      body: Center(
        child: Text('我的金币:${money.toStringAsFixed(2)} 元'),
      ),
    );
  }

  void _adEventCallback(RewardADEvent event, Map params) {
    switch (event) {
      case RewardADEvent.onADLoad:
        rewardAD.showAD();
        break;
      case RewardADEvent.onADClose:
      case RewardADEvent.onVideoComplete:
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: BorderRadius.circular(32.0),
                  child: Card(
                    child: Container(
                      width: 320.0,
                      height: 280.0,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text(
                        '恭喜你获得${money.toStringAsFixed(2)}元',
                        textScaleFactor: 2.1,
                      ),
                    ),
                  ),
                ),
              );
            });
        break;
      default:
    }
  }
}
