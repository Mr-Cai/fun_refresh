import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('搜索面板'),
      ),
    );
  }
}
