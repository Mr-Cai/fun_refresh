import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/model/data/theme.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:intl/intl.dart';
import 'package:tencent_ad/native.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';
import '../../../model/i18n/i18n.dart';

class MindPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _MindPageState();
}

class _MindPageState extends State<MindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.withOpacity(0.6),
      appBar: TopBar(
        title: I18n.of(context).mind,
        themeColor: Colors.white,
        isMenu: true,
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: 99,
        itemBuilder: (context, index) {
          return index % 9 == 0
              ? NativeExpressAdWidget(config['nativeID'])
              : PostTile(index: index);
        },
        separatorBuilder: (context, index) {
          return index == 0
              ? Container()
              : Divider(
                  height: 8.0,
                  color: Color(0xfff5f6f9),
                  thickness: 6.0,
                );
        },
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({
    this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final time = DateFormat('yyyy-MM-dd kk:mm').format(now);
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                radius: sizeW(context) * .08,
                backgroundImage: AssetImage(
                  path('header', 3, format: 'jpg'),
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  slimTxT('昵称', size: 22.0),
                  SizedBox(height: 8.0),
                  slimTxT('$time', size: 15.0, no: 2, color: Colors.white),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            text: 'Hello ',
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                  text:
                      'skaldfslkfdlksaflsafkasfksdfklsalkfjsakfjsalfasl;kfsadklfsladfjklsfd')
            ],
          ),
        )
      ],
    );
  }
}
