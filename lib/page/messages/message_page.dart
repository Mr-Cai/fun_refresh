import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../tools/global.dart';
import '../../page/export_page_pkg.dart';
import '../../components/top_bar.dart';
import '../../model/i18n/i18n.dart';
import '../../model/event/drawer_nav_bloc.dart';

class MessagePage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: true,
        title: I18n.of(context).msg,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return null;
        },
        displacement: 0.0,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) => MsgItem(),
          separatorBuilder: (context, index) {
            return Divider(indent: 42.0, height: 4.0);
          },
        ),
      ),
    );
  }
}

class MsgItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          pushNamed(context, 'name');
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                path('user', 5),
                width: 64.0,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('昵称111', style: TextStyle(fontSize: 20.0)),
                      SizedBox(height: 12.0),
                      Text('消息', style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50.0,
                child: Text(
                  '00:00',
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      );
}
