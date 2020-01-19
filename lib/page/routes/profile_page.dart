import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:http/http.dart' as http;

// ProfilePage
class ProfilePage extends StatefulWidget {
  ProfilePage({this.args});
  final args;
  @override
  createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nickNameC = TextEditingController();
  TextEditingController _fullNameC = TextEditingController();
  TextEditingController _phoneC = TextEditingController();
  TextEditingController _emailC = TextEditingController();
  TextEditingController _genderC = TextEditingController();
  _addData() async {
    http.post(
      '$LOCAL_SERVER/database/create',
      body: {
        'phone': _phoneC.text,
        'email': _emailC.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          TextFormField(
            controller: _nickNameC,
            decoration: InputDecoration(hintText: '昵称'),
          ),
          TextFormField(
            controller: _fullNameC,
            decoration: InputDecoration(hintText: '全名'),
          ),
          TextFormField(
            controller: _phoneC,
            decoration: InputDecoration(hintText: '手机号'),
          ),
          TextFormField(
            controller: _emailC,
            decoration: InputDecoration(hintText: '邮箱'),
          ),
          TextFormField(
            controller: _genderC,
            decoration: InputDecoration(hintText: '性别'),
          ),
          RaisedButton(
            child: Text('提交'),
            onPressed: () {
              _addData();
              Navigator.pop(context);
            },
          )
        ],
      );
}
