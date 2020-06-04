import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/swiper.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _phoneCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _nickNameCtrl = TextEditingController();

  SwiperController _controller;
  int currentIndex = 0;
  int swiperIndex = 0;

  @override
  void initState() {
    statusBar(status: 1);
    _controller = SwiperController()
      ..addListener(() {
        setState(() {
          currentIndex = _controller.index;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    statusBar(status: 1);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: TopBar(
        title: '注册',
        themeColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: currentIndex != 0 && currentIndex == swiperIndex
                  ? 0.0
                  : 240.0,
            ),
            currentIndex != 0 && currentIndex == swiperIndex
                ? Container(
                    width: 180.0,
                    height: 180.0,
                    margin: const EdgeInsets.all(32.0),
                    child: ClipOval(
                      child: netPic(pic: dogSmile),
                    ),
                  )
                : Container(),
            AspectRatio(
              aspectRatio: 8 / 2,
              child: Swiper(
                physics: NeverScrollableScrollPhysics(),
                autoStart: false,
                speed: -1,
                circular: false,
                controller: _controller,
                children: swiperList(),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  top: 12.0,
                  left: 16.0,
                  child: currentIndex != swiperIndex
                      ? Container()
                      : menuIcon(
                          context,
                          icon: 'back',
                          size: 20.0,
                          left: 12.0,
                          color: Colors.white,
                          onTap: () {
                            _controller.previousPage(
                              duration: Duration(milliseconds: 50),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                ),
                Align(
                  child: currentIndex == swiperIndex
                      ? FloatingActionButton.extended(
                          heroTag: 'next',
                          isExtended: true,
                          onPressed: () {
                            netool
                                .regist(
                              phone: _phoneCtrl.value.text,
                              nickName: _nickNameCtrl.value.text,
                              password: _pwdCtrl.value.text,
                            )
                                .then((value) {
                               Toast.show(value['result'], context);
                            });
                          },
                          backgroundColor: Colors.red,
                          label: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '开始注册',
                              textScaleFactor: 1.5,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: currentIndex == swiperIndex
                      ? Container()
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            currentIndex == 1
                                ? FloatingActionButton.extended(
                                    heroTag: 'prev',
                                    isExtended: true,
                                    onPressed: () {
                                      _controller.previousPage(
                                        duration: Duration(milliseconds: 50),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    backgroundColor: Colors.teal,
                                    label: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '上一步',
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(width: currentIndex == 1 ? 64.0 : 0.0),
                            FloatingActionButton.extended(
                              heroTag: 'next',
                              isExtended: true,
                              onPressed: () {
                                switch (currentIndex) {
                                  case 0:
                                    if (_phoneCtrl.value.text.isEmpty) {
                                       Toast.show('输入为空', context,
                                          gravity: Toast.CENTER);
                                    } else {
                                      _controller.nextPage(
                                        duration: Duration(milliseconds: 333),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                    break;
                                  case 1:
                                    if (_nickNameCtrl.value.text.isEmpty) {
                                       Toast.show('输入为空', context,
                                          gravity: Toast.CENTER);
                                      _controller.stop();
                                    } else {
                                      _controller.nextPage(
                                        duration: Duration(milliseconds: 333),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                    break;
                                  case 2:
                                    if (_pwdCtrl.value.text.isEmpty) {
                                       Toast.show('输入为空', context,
                                          gravity: Toast.CENTER);
                                      _controller.stop();
                                    }
                                    break;
                                  default:
                                }
                              },
                              backgroundColor: Colors.red,
                              label: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '下一步',
                                  textScaleFactor: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
            SizedBox(height: 128.0),
          ],
        ),
      ),
    );
  }

  List<Widget> swiperList() {
    List<Widget> widgets = [
      InputWidget(
        inputCtrl: _phoneCtrl,
        icon: Icons.phone_android,
        color: Colors.white,
        inputType: TextInputType.phone,
        hint: '请输入您的手机号码？',
        validator: (value) {
          if (value.length < 6) {
            return '密码太短';
          }
          if (value.length > 12) {
            return '密码不能超过12位';
          }
          return 'null';
        },
      ),
      InputWidget(
        inputCtrl: _nickNameCtrl,
        icon: Icons.text_rotation_angleup,
        color: Colors.white,
        inputType: TextInputType.text,
        hint: '请输入您的昵称？',
        validator: (value) {},
      ),
      InputWidget(
        inputCtrl: _pwdCtrl,
        icon: Icons.lock_open,
        color: Colors.white,
        hint: '请输入您的密码？',
        isPWD: true,
        validator: (value) {},
      ),
    ];
    swiperIndex = widgets.length - 1;
    return widgets;
  }
}

class InputWidget extends StatefulWidget {
  const InputWidget({
    this.formKey,
    this.inputCtrl,
    this.icon,
    this.color,
    this.hint,
    this.inputType,
    this.isPWD: false,
    this.validator,
  });

  final TextEditingController inputCtrl;
  final IconData icon;
  final Color color;
  final String hint;
  final TextInputType inputType;
  final bool isPWD;
  final Function(String) validator;
  final GlobalKey<FormState> formKey;

  @override
  State<StatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        key: widget.formKey,
        autofocus: true,
        obscureText: widget.isPWD,
        controller: widget.inputCtrl,
        focusNode: focusNode,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.white,
        keyboardType: widget.inputType,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.white70),
          icon: Icon(widget.icon, color: widget.color),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide(color: Colors.white, width: 0.8),
          ),
        ),
      ),
    );
  }
}

bool phoneValidator(String phone) {
  RegExp exp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  bool matched = exp.hasMatch(phone);
  return matched;
}
