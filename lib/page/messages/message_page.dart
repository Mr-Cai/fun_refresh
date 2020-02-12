import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/tools/pic_tool.dart';

class MessagePage extends StatefulWidget {
  @override
  createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) => MsgItem(),
        separatorBuilder: (context, index) =>
            Divider(indent: 42.0, height: 2.0),
      );
}

class MsgItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(iconX('github')),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
