import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/i18n/i18n.dart';
import '../../components/top_bar.dart';
import '../../page/export_page_pkg.dart';
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
        title: I18n.of(context).profile,
        left: sizeW(context) * .16,
        actions: [
          Container(
            margin: const EdgeInsets.all(6.0),
            child: IconButton(
              icon: SvgPicture.asset(
                path('setting', 5),
                color: Colors.white,
              ),
              onPressed: () => pushName(context, setting),
            ),
          ),
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
