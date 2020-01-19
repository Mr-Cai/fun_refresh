import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';

BannerAd createBannerAd({@required AdSize size}) => BannerAd(
      adUnitId: bannerUnit,
      size: size,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {},
    );
