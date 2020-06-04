import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/tools/global.dart';

import '../animations/shine_effect.dart';
import '../bloc/bloc_provider.dart';
import '../bloc/game_bloc.dart';
import '../game_widgets/double_curved_container.dart';
import '../game_widgets/game_level_button.dart';
import '../game_widgets/shadowed_text.dart';
import '../model/level.dart';
import '../pages/game_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  AudioPlayer audioPlayer;

  final bannerAd = createBannerAd(size: AdSize.mediumRectangle);

  @override
  void initState() {
    play();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() {
        if (mounted) setState(() {});
      });

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.6,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
    bannerAd
      ..load()
      ..show(anchorOffset: 380.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    statusBar();
    audioPlayer.release();
    if (mounted) bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context);
    statusBar(isHide: true);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: sizeW(context),
            height: sizeH(context),
            child: netPic(
              pic: 'https://pic.downk.cc/item/5ea27c35c2a9a83be539002f.jpg',
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                width: sizeW(context),
                height: sizeH(context),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: gameBloc.numberOfLevels,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.01,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GameLevelButton(
                      width: 80.0,
                      height: 60.0,
                      borderRadius: 50.0,
                      text: '关卡 ${index + 1}',
                      onTap: () async {
                        Level newLevel = await gameBloc.setLevel(index + 1);
                        audioPlayer.release();
                        // Open the Game page
                        Navigator.of(context).push(GamePage.route(newLevel));
                        try {
                          if (mounted) bannerAd?.dispose();
                        } catch (e) {
                          print(e);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            top: _animation.value * 250.0 - 150.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: DoubleCurvedContainer(
                width: sizeW(context) - 60.0,
                height: 150.0,
                outerColor: Colors.blue[700],
                innerColor: Colors.blue,
                child: Stack(
                  children: [
                    ShineEffect(
                      offset: Offset(100.0, 100.0),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ShadowedText(
                        text: '宝石迷阵',
                        color: Colors.white,
                        fontSize: 26.0,
                        shadowOpacity: 1.0,
                        offset: Offset(1.0, 1.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<int> play() async {
    audioPlayer = AudioPlayer();
    int result = await audioPlayer.play('https://www.joy127.com/url/6652.mp3');
    return result;
  }
}
