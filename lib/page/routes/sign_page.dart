import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_refresh/components/common_app_bar.dart';
import 'package:fun_refresh/model/smash_model.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/pic_tool.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    ProviderDetails providerInfo = ProviderDetails(userDetails.providerId);

    final providerData = List<ProviderDetails>();
    providerData.add(providerInfo);

    /* UserDetails details = UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    ); */
    return userDetails;
  }

  final _phoneCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _scrollViewCtrl = ScrollController();
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
    _scrollViewCtrl.dispose();
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
      body: SingleChildScrollView(
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
                    child: Image.network(
                      isGoogleLoginSuccess == false
                          ? GIRL
                          : googleUser.photoUrl,
                      fit: BoxFit.cover,
                      height: sizeW$50(context),
                      width: sizeW$50(context),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: sizeW$5(context)),
                  child: TextFormField(
                    controller: _phoneCtrl,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: '请输入手机号/邮箱/用户名:',
                      icon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(height: sizeH$1(context) * 3),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: sizeW$5(context)),
                  child: TextFormField(
                    controller: _pwdCtrl,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: '请输入密码:',
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(height: sizeH$1(context) * 3),
                CupertinoButton(
                  color: Colors.accents[5].withAlpha(96),
                  borderRadius: BorderRadius.circular(32.0),
                  minSize: 60,
                  pressedOpacity: .5,
                  onPressed: () {
                    _savedAccount(_phoneCtrl.text, _pwdCtrl.text);
                  },
                  child: Text('登录\t📍\t\t\t\t\t注册\t📌'),
                ),
                SizedBox(height: sizeH$1(context) * 2),
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
                    Container(width: 32.0),
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
      ),
    );
  }

  void _savedAccount(String account, String pwd) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('account', account);
    pref.setString('password', pwd);
  }
}
