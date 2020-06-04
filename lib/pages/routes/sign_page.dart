import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/pages/routes/route_generator.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/net_tool.dart';
import 'package:toast/toast.dart';
import '../../components/top_bar.dart';
import '../../tools/global.dart';

import '../export_page_pkg.dart';

class SignPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _userNameCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _scrollViewCtrl = ScrollController();

  bool isExpand = false;

  @override
  void initState() {
    statusBar(status: 1);
    _userNameCtrl.addListener(() => _scrollBTM());
    _pwdCtrl.addListener(() => _scrollBTM());
    super.initState();
  }

  @override
  void dispose() {
    _userNameCtrl.dispose();
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
          padding: const EdgeInsets.only(top: 8.0),
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
                title: '欢迎来到小蔡写的趣刷APP',
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
                width: 220.0,
                height: 220.0,
                margin: const EdgeInsets.all(32.0),
                child: ClipOval(
                  child: netPic(
                    pic: dogSmile,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: _userNameCtrl,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: '手机｜邮箱｜网名',
                    hintStyle: TextStyle(color: Colors.white70),
                    icon: Icon(Icons.phone, color: Colors.greenAccent),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.white, width: 0.8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4.0 * 3),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(color: Colors.white, width: 0.8),
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
                    heroTag: 'sign',
                    isExtended: true,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      String password = _pwdCtrl.value.text;
                      String userNameInput = _userNameCtrl.value.text;

                      bool isPhone = validatePhoneNumber(userNameInput);

                      netool
                          .login(
                              nickName: isPhone ? '' : userNameInput,
                              phone: isPhone ? userNameInput : '',
                              password: password)
                          .then(
                        (value) {
                          Toast.show(value['result'], context);
                        },
                      );
                    },
                    label: Container(
                      width: sizeW(context) * .35,
                      alignment: Alignment.center,
                      child: Text(
                        '登录',
                        textScaleFactor: 1.5,
                      ),
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
              InkWell(
                onTap: () {
                  pushName(context, register);
                },
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  child: freeTxT(
                    '👈🏻 没有账号, 注册一个 👉🏻',
                    color: Colors.white,
                    size: 17.0,
                  ),
                ),
              ),
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

  bool validatePhoneNumber(String text) {
    RegExp exp = RegExp(
      r'(^(?:[+0]9)?[0-9]{10,12}$)',
    );
    return exp.hasMatch(text);
  }
}
