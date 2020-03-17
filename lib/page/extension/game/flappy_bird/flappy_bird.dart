import 'package:flame/assets_cache.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './game/game.dart';

class FlappyBird extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FlappyBirdState();
}

class _FlappyBirdState extends State<FlappyBird> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlappyBirdGame>(
      stream: initAsync().asStream(),
      builder: (context, snapshot) {
        return Scaffold(
          body: snapshot.data.widget,
        );
      },
    );
  }

  Future<FlappyBirdGame> initAsync() async {
    FlappyBirdGame game;
    // 初始化屏幕配置
    WidgetsFlutterBinding.ensureInitialized();
    Flame.audio.disableLog();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    var sprite = await Flame.images.loadAll(['sprite.png']);
    var screenSize = await Flame.util.initialDimensions();
    Singleton.instance.screenSize = screenSize;
    game = FlappyBirdGame(sprite[0], screenSize);

    Flame.util.addGestureRecognizer(
      TapGestureRecognizer()..onTapDown = (event) => game.onTap(),
    );
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
