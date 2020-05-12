import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:intl/intl.dart';
import 'package:tencent_ad/native_template.dart';
import '../../../model/event/drawer_nav_bloc.dart';
import '../../../components/top_bar.dart';

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
        title: '想法',
        themeColor: Colors.white,
        isMenu: true,
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: 30,
        itemBuilder: (context, index) {
          if (index != 0 && index % 6 == 0) {
            return NativeADWidget(posID: configID['nativeID']);
          }
          return PostTile(index: index);
        },
        separatorBuilder: (context, index) {
          return Divider(
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
  const PostTile({this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final time = DateFormat('yyyy-MM-dd kk:mm').format(now);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNameBar(time, context),
            _buildTitleBar(context),
            _buildPostPic(context),
            _buildActionBar(context),
          ],
        ),
      ],
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Container(
      width: sizeW(context) * .75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.comment),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.content_copy),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPostPic(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 300.0,
          height: 200.0,
          color: Colors.white,
          child: flareAnim(context),
        ),
      ),
    );
  }

  Widget _buildTitleBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      width: sizeW(context) * .75,
      child: freeTxT(
        'Hello' * 100,
        maxLines: 5,
      ),
    );
  }

  Widget _buildNameBar(String time, BuildContext context) {
    return Container(
      width: sizeW(context) * .75,
      child: Row(
        children: [
          freeTxT('昵称', size: 22.0),
          SizedBox(width: 32.0),
          freeTxT('$time', size: 16.0, color: Colors.white),
          SizedBox(width: 8.0),
          Spacer(),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 头像
  Widget _buildAvatar() {
    return Container(
      width: 64.0,
      height: 64.0,
      margin: const EdgeInsets.all(12.0),
      child: ClipOval(
        child: netPic(pic: dogSmile),
      ),
    );
  }
}
