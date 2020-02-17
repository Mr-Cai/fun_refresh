import 'package:flutter/material.dart';
import 'package:fun_refresh/model/i18n/i18n.dart';
import '../../../components/common_app_bar.dart';

class SocialPage extends StatefulWidget {
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
        backColor: Colors.black,
        titleColor: Colors.black,
      ),
      body: Center(
        child: Text('人脉'),
      ),
    );
  }
}
