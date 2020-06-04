import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/tools/global.dart';

class RewardVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RewardVideoPageState();
}

class _RewardVideoPageState extends State<RewardVideoPage> {
  num money = 0.00;

  @override
  void initState() {
    money = Random().nextDouble() + Random().nextInt(100);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        title: '奖励视频',
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('幸运币:${money.toStringAsFixed(2)}'),
            SvgPicture.asset(
              path('coins', 5),
              width: 32.0,
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
