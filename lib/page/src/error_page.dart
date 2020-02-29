import 'package:flutter/material.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:tencent_ad/tencent_ad.dart';
import '../../components/mini.dart';
import '../../components/top_bar.dart';
import '../../model/i18n/i18n.dart';

class ErrorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  final _bannerKey = GlobalKey<UnifiedBannerAdState>();
  bool _bannerClose = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        title: I18n.of(context).error,
      ),
      body: InkWell(
        onTap: () {},
        child: Column(
          children: [
            errorLoad(context),
            Spacer(),
            Container(
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
          ],
        ),
      ),
    );
  }
}
