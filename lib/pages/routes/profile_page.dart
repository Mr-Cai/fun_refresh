import 'package:flutter/material.dart';
import '../../components/top_bar.dart';
import '../../pages/export_page_pkg.dart';
import '../../tools/global.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: TopBar(
        title: '资料',
        themeColor: Colors.white,
        actions: [
          menuIcon(
            context,
            color: Colors.white,
            onTap: () {
              pushName(context, settings);
            },
            icon: 'setting',
          )
        ],
      ),
      body: Container(
        width: sizeW(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 4.0, color: Colors.white),
                borderRadius: BorderRadius.circular(sizeW(context)),
              ),
              margin: const EdgeInsets.only(bottom: 32.0),
              child: ClipOval(
                child: Image.asset(
                  path('header', 3, format: 'jpg'),
                  height: sizeW(context) / 2,
                  width: sizeW(context) / 2,
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
                '\$32',
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
      ),
    );
  }
}
