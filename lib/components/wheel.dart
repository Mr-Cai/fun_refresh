import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/data/field.dart';
import '../tools/pic_tool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/spinning_wheel.dart';
import '../model/data/local_asset.dart';

class Roulette extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  final StreamController _dividerController = StreamController<int>.broadcast();
  final _wheelNotifier = StreamController<double>.broadcast();
  num coinsResult = 0;

  @override
  void dispose() {
    _dividerController.close();
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.cyan[300],
            Colors.lightBlue[600],
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            SpinningWheel(
              Image.asset(picX('wheel')),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 8,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage: Image.asset(picX('pointer')),
              secondaryImageHeight: 110,
              secondaryImageWidth: 110,
              shouldStartOrStop: _wheelNotifier.stream,
            ),
            SizedBox(height: 32),
            FloatingActionButton.extended(
              heroTag: 'wheel',
              icon: SvgPicture.asset(
                iconX('coins'),
                width: 32.0,
                height: 32.0,
              ),
              label: Text('开始抽奖'),
              onPressed: () {
                showDialog(
                  context: context,
                  child: StreamBuilder(
                    stream: _dividerController.stream.asBroadcastStream(),
                    builder: (context, snapshot) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      child: snapshot.hasData
                          ? Container(
                              height: 64.0,
                              child: CoinsPot(snapshot.data),
                            )
                          : Container(),
                    ),
                  ),
                );
                _wheelNotifier.sink.add(
                  _generateRandomVelocity(),
                );
              },
            ),
            SizedBox(height: 32),
            Stack(
              children: [
                SvgPicture.asset(
                  iconX('coins_bag'),
                  width: 128.0,
                  height: 128.0,
                ),
                Positioned.fill(
                  top: 32.0,
                  child: StreamBuilder(
                      stream: _dividerController.stream.asBroadcastStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _saveCoins(int.parse(labelsMap[snapshot.data]));
                          return Text(
                            '$coinsResult',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Text(
                            '300',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                            textAlign: TextAlign.center,
                          );
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;
  double _generateRandomAngle() => Random().nextDouble() * pi * 2;

  Future<void> _saveCoins(int result) async {
    final pref = await SharedPreferences.getInstance();
    coinsResult = pref.getInt(COINS);
    await pref.setInt(COINS, result);
  }
}

class CoinsPot extends StatelessWidget {
  CoinsPot(this.selected);
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('🎉🎉🎉🎉🎉', textScaleFactor: 3),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '恭喜你获得: ${labelsMap[selected]}',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 12.0),
            SvgPicture.asset(
              iconX('coins'),
              width: 32.0,
              height: 32.0,
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('🎉🎉🎉🎉🎉', textScaleFactor: 3),
        ),
      ],
    );
  }
}
