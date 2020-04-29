import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';

class SocialPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(
        title: '人脉',
        themeColor: Colors.black,
        isMenu: true,
      ),
      body: Stack(
        children: [
          SocialLogo(),
        ],
      ),
    );
  }
}

class SocialLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32.0,
      left: 32.0,
      child: ClipOval(
        child: Container(
          width: 64.0,
          height: 64.0,
          child: netPic(
            pic: 'https://api.superbed.cn/item/5ea227a5c2a9a83be5d609bd.jpg',
          ),
        ),
      ),
    );
  }
}
