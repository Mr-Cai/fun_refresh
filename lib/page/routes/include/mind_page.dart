import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/common_app_bar.dart';
import 'package:fun_refresh/model/i18n/i18n.dart';

class MindPage extends StatefulWidget {
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
