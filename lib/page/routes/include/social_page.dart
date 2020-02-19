import 'package:flutter/material.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../model/i18n/i18n.dart';
import '../../../components/top_bar.dart';

class SocialPage extends StatefulWidget with NavigationState {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(
        title: I18n.of(context).social,
        iconColor: Colors.black,
        titleColor: Colors.black,
        isMenu: true,
      ),
      body: Center(
        child: Text('人脉'),
      ),
    );
  }
}
