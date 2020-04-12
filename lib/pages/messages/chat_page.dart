import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({this.args});
  final Map args;
  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args['name']),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
                Text('asfsafsadf'),
              ],
            ),
          ),
          Spacer(),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Container(child: TextFormField())),
              RaisedButton(
                onPressed: () {},
                child: Text('发送'),
              )
            ],
          )
        ],
      ),
    );
  }
}
