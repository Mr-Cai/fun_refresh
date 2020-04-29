import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/pages/routes/route_generator.dart';
import 'package:fun_refresh/tools/api.dart';
import '../../components/top_bar.dart';
import '../../tools/global.dart';
import 'package:toast/toast.dart';

import '../export_page_pkg.dart';

class SignPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _phoneCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _scrollViewCtrl = ScrollController();

  bool isExpand = false;

  @override
  void initState() {
    _phoneCtrl.addListener(() => _scrollBTM());
    _pwdCtrl.addListener(() => _scrollBTM());
    super.initState();
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  void _scrollBTM() {
    _scrollViewCtrl.animateTo(
      _scrollViewCtrl.position.maxScrollExtent * .5,
      duration: Duration(microseconds: 555),
      curve: Curves.bounceInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      controller: _scrollViewCtrl,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 120.0),
        child: Container(
          height: sizeH(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.lightBlue,
                Colors.tealAccent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              TopBar(
                bgColor: Colors.transparent,
                themeColor: Colors.white,
                title: '登录 or 注册',
                actions: [
                  menuIcon(
                    context,
                    icon: 'info',
                    color: Colors.white,
                    size: 28.0,
                    onTap: () {
                      pushName(context, 'name', args: defaultArgs);
                    },
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 72.0, bottom: 32.0),
                child: ClipOval(
                  child: SvgPicture.asset(
                    path('user', 5),
                    width: 128.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  controller: _phoneCtrl,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: '手机｜邮箱｜网名',
                    hintStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.phone, color: Colors.greenAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.0 * 3),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  controller: _pwdCtrl,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.white,
                  cursorWidth: 2.0,
                  cursorRadius: Radius.circular(32.0),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white70),
                    hintText: '验证码｜密码',
                    icon: Icon(Icons.lock, color: Colors.limeAccent),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  validator: (value) => value.length < 6 ? '密码太短' : null,
                  onSaved: (value) => _pwdCtrl.text = value,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Spacer(),
                  FloatingActionButton.extended(
                    heroTag: 'send',
                    onPressed: () {},
                    label: Text('发送'),
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    icon: Icon(Icons.send),
                  ),
                  Spacer(),
                  FloatingActionButton.extended(
                    heroTag: 'register',
                    onPressed: () {},
                    label: Text(
                      '登录\t\t\t\t|\t\t\t\t注册',
                      textScaleFactor: 1.1,
                    ),
                  ),
                  Spacer(),
                  FlatButton(
                    shape: CircleBorder(),
                    autofocus: true,
                    child: Icon(
                      Icons.help,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Toast.show('忘记密码', context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(path('google', 5)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset(path('qq', 5)),
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 24.0,
                    icon: SvgPicture.asset(path('wechat', 5)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset(path('github', 5)),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 22.0),
              isExpand
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            path('finger_print', 5),
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          iconSize: 36.0,
                          icon: Icon(
                            Icons.face,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    )
                  : Container(),
              IconButton(
                icon: Icon(
                  isExpand
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 32.0),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    freeTxT('登录即同意"趣刷"', color: Colors.white.withOpacity(0.9)),
                    GestureDetector(
                      onTap: () {
                        pushName(
                          context,
                          web_view,
                          args: {'url': agreement},
                        );
                      },
                      child: freeTxT('《服务协议》', color: Colors.blue),
                    ),
                    freeTxT('和', color: Colors.white.withOpacity(0.9)),
                    GestureDetector(
                      onTap: () {
                        pushName(
                          context,
                          web_view,
                          args: {'url': private},
                        );
                      },
                      child: freeTxT('《隐私政策》', color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
