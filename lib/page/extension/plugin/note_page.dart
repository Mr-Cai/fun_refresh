import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('笔记本'),
    );
  }
}
