import 'package:flutter/material.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../components/wheel.dart';

class RewardPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Roulette(),
          Positioned(
            top: 6.0,
            left: 0.0,
            right: 0.0,
            child: TopBar(
              title: '奖励',
              isMenu: true,
              themeColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}