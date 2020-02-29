import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/global.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../model/i18n/i18n.dart';
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
        title: I18n.of(context).social,
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
        child: Image.asset(
          path('header', 3, format: 'jpg'),
          width: 64.0,
          height: 64.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
