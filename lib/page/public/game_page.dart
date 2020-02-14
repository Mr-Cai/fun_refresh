import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/page/routes/route_generator.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/pic_tool.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          height: sizeH$20(context),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return GameIcon(index);
            },
          ),
        ),
      ],
    );
  }
}

class GameIcon extends StatelessWidget {
  final int index;

  GameIcon(this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNamed(context, '/reward');
        showSnackBar('text $index');
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            width: sizeH$15(context),
            height: sizeH$15(context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.tealAccent,
            ),
            child: Center(
              child: SvgPicture.asset(
                iconX('ic_wheel'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text('幸运小转盘$index'),
          )
        ],
      ),
    );
  }
}
