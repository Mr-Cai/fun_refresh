import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/i18n/i18n.dart';
import '../../model/event/drawer_nav_bloc.dart';
import '../../page/routes/route_generator.dart';
import '../../tools/global.dart';

class GamePage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).game,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 128.0,
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
      ),
    );
  }
}

class GameIcon extends StatelessWidget {
  final int index;

  GameIcon(this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNamed(context, '/reward');
        showSnackBar('text $index');
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.tealAccent,
            ),
            child: Center(
              child: SvgPicture.asset(
                path('ic_wheel', 5),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Text('幸运小转盘$index'),
          )
        ],
      ),
    );
  }
}
