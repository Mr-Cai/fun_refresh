import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:tencent_ad/tencent_ad.dart';
import '../../components/top_bar.dart';
import '../../model/i18n/i18n.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({this.args});

  final Map args;

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
            widget.args == null || widget.args['type'] == 'error'
                ? errorLoad(context)
                : widget.args['type'] == 'disconnect'
                    ? disconnect(context, netType: widget.args['netType'])
                    : Container(),
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
