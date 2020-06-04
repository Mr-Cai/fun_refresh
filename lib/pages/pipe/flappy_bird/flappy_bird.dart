import 'package:firebase_admob/firebase_admob.dart';
import 'package:flame/assets_cache.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/tools/global.dart';
import './game/game.dart';

class FlappyBird extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlappyBirdState();
}

class _FlappyBirdState extends State<FlappyBird> {
  FlappyBirdGame game;

  final bannerAd = createBannerAd(size: AdSize.smartBanner);

  @override
  void initState() {
    bannerAd
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    game = null;
    statusBar();
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlappyBirdGame>(
      stream: initAsync().asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: snapshot.data.widget,
          );
        }
        return flareAnim(context);
      },
    );
  }

  Future<FlappyBirdGame> initAsync() async {
    // 初始化屏幕配置
    WidgetsFlutterBinding.ensureInitialized();
    Flame.audio.disableLog();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    var sprite = await Flame.images.loadAll(['flappy_bird/sprite.png']);
    var screenSize = await Flame.util.initialDimensions();
    Singleton.instance.screenSize = screenSize;
    game = FlappyBirdGame(sprite[0], screenSize);

    TapGestureRecognizer()..onTapDown = (event) => game.onTapCustom();
    return game;
  }
}

class Singleton {
  Size screenSize;
  Singleton._privateConstructor();
  static final Singleton instance = Singleton._privateConstructor();
}

class AssetLoad extends AssetsCache {
  @override
  Future<String> readFile(String fileName) {
    return super.readFile(fileName);
  }
}
