import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/top_bar.dart';
import '../../page/export_page_pkg.dart';
import '../../tools/global.dart';
import '../../tools/pic_tool.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({this.args});

  final Map args;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: TopBar(
        title: '个人资料',
        top: sizeH$2(context),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              iconX('setting'),
              color: Colors.white,
            ),
            onPressed: () => pushNamed(context, setting),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(width: sizeW$1(context) * 2, color: Colors.white),
              borderRadius: BorderRadius.circular(
                sizeW$50(context),
              ),
            ),
            margin: EdgeInsets.only(
              bottom: sizeH$10(context) / 2,
            ),
            child: ClipOval(
              child: Image.asset(
                picX('android_cover'),
                height: sizeW$50(context),
                width: sizeW$50(context),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text('网名'),
          Text('签名'),
          Text('年龄'),
          Text('性别'),
          SizedBox(height: 32.0),
          FloatingActionButton.extended(
            heroTag: 'profile',
            label: Text(
              '       \$32   ',
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
            icon: Icon(
              Icons.supervised_user_circle,
              color: Colors.lightBlueAccent,
              size: 32.0,
            ),
            backgroundColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 4,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
