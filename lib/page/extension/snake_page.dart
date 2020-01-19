import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnakePage extends StatefulWidget {
  @override
  _SnakePageState createState() => _SnakePageState();
}

class _SnakePageState extends State<SnakePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('贪吃蛇'),
    );
  }
}