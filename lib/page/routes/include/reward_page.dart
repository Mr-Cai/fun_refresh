import 'package:flutter/material.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../components/wheel.dart';
import '../../../model/data/local_asset.dart';
import '../../../model/i18n/i18n.dart';
import '../../../tools/global.dart';
import 'package:tencent_ad/banner.dart';

class RewardPage extends StatefulWidget with NavigationState{
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  final _bannerKey = GlobalKey<UnifiedBannerAdState>();
  bool _bannerClose = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Roulette(),
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
          Positioned(
            top: 0.0,
            child: TopBar(
              title: I18n.of(context).reward,
              left: sizeW$30(context),
              isMenu: true,
            ),
          ),
        ],
      ),
    );
  }
}
