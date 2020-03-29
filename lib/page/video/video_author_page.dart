import 'package:flutter/material.dart';

class VideoAuthorPage extends StatefulWidget {
  const VideoAuthorPage({this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _VideoAuthorPageState();
}

class _VideoAuthorPageState extends State<VideoAuthorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${widget.args}'),
      ),
    );
  }
}
