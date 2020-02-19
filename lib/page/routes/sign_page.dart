import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/top_bar.dart';
import '../../model/mock/smash_model.dart';
import '../../tools/api.dart';
import '../../tools/global.dart';
import '../../tools/pic_tool.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tencent_kit/tencent_kit.dart';
import 'package:toast/toast.dart';

class SignPage extends StatefulWidget {
  @override
  createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googlSignIn = GoogleSignIn();

  GoogleSignInAuthentication googleAuth;

  Future<FirebaseUser> _signIn(BuildContext context) async {
    googleUser = await _googlSignIn.signIn();
    googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final userDetails = authResult.user;

    final providerData = List<ProviderDetails>();
    providerData.add(ProviderDetails(userDetails.providerId));

    return userDetails;
  }

  final _phoneCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _scrollViewCtrl = ScrollController();

  StreamSubscription<TencentLoginResp> _login;

  Tencent _tencent = Tencent()..registerApp(appId: tencentID);
  TencentLoginResp _loginResp;

  @override
  void initState() {
    _phoneCtrl.addListener(() => _scrollBTM());
    _pwdCtrl.addListener(() => _scrollBTM());
    _login = _tencent.loginResp().listen(_listenLogin);
    super.initState();
  }

  void _listenLogin(TencentLoginResp resp) {
    _loginResp = resp;
    String content = 'login: ${resp.openid} - ${resp.accessToken}';
    print(content);
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _pwdCtrl.dispose();
    _scrollViewCtrl.dispose();
    if (_login != null) {
      _login.cancel();
    }
    super.dispose();
  }

  void _scrollBTM() {
    _scrollViewCtrl.animateTo(
      _scrollViewCtrl.position.maxScrollExtent,
      duration: Duration(microseconds: 555),
      curve: Curves.bounceInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: getAvatar().asStream(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                      backBTN(context),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: sizeH$10(context) / 2,
                        ),
                        child: ClipOval(
                          child: snapshot.data == null
                              ? SvgPicture.asset(
                                  iconX('user'),
                                  width: sizeW$50(context),
                                )
                              : Image.network(
                                  snapshot.data.toString(),
                                  height: sizeW$50(context),
                                  width: sizeW$50(context),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: sizeW$5(context)),
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
                      SizedBox(height: sizeH$1(context) * 3),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: sizeW$5(context)),
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
                          validator: (value) =>
                              value.length < 6 ? '密码太短' : null,
                          onSaved: (value) => _pwdCtrl.text = value,
                        ),
                      ),
                      SizedBox(height: sizeH$5(context)),
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
                            onPressed: () {
                              _savedAccount(_phoneCtrl.text, _pwdCtrl.text);
                            },
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
                      SizedBox(height: sizeH$5(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(iconX('google')),
                            onPressed: () => _signIn(context).then((user) {
                              googleAuth.accessToken == null
                                  ? isGoogleLoginSuccess = false
                                  : isGoogleLoginSuccess = true;
                            }).catchError((e) => print(e)),
                          ),
                          SizedBox(width: sizeW$5(context)),
                          IconButton(
                            icon: SvgPicture.asset(iconX('qq')),
                            onPressed: () {
                              _tencent.login(
                                scope: [TencentScope.GET_SIMPLE_USERINFO],
                              );
                            },
                          ),
                          SizedBox(width: sizeW$5(context)),
                          IconButton(
                            iconSize: sizeW$9(context) - 2,
                            icon: SvgPicture.asset(iconX('wechat')),
                            onPressed: () {},
                          ),
                          SizedBox(width: sizeW$5(context)),
                          IconButton(
                            icon: SvgPicture.asset(iconX('github')),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<String> getAvatar() async {
    TencentUserInfoResp userInfo = await _tencent.getUserInfo(
      appId: tencentID,
      openid: _loginResp.openid,
      accessToken: _loginResp.accessToken,
    );
    return userInfo.headImgUrl();
  }

  void _savedAccount(String account, String pwd) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('account', account);
    pref.setString('password', pwd);
  }
}
