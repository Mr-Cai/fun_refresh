import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 32.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.tealAccent,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Center(
                  child: Text('xxx'),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
