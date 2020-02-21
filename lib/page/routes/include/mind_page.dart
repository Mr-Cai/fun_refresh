import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../model/i18n/i18n.dart';

class MindPage extends StatefulWidget with NavigationState {
  @override
  _MindPageState createState() => _MindPageState();
}

class _MindPageState extends State<MindPage> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: TopBar(
        title: I18n.of(context).mind,
        themeColor: Colors.white,
        isMenu: true,
      ),
      body: ListView.separated(
        itemCount: 9,
        itemBuilder: (context, index) {
          return Center(child: Text('标题 $index'));
        },
        separatorBuilder: (context, index) {
          return Center(child: Text('标题 $index'));
        },
      ),
    );
  }
}
