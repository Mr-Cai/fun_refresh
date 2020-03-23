import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/page/routes/route_generator.dart';
import 'package:fun_refresh/tools/api.dart';
import '../model/data/local_asset.dart';
import '../tools/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisclaimerMsg extends StatefulWidget {
  const DisclaimerMsg({Key key, this.state}) : super(key: key);
  final State state;
  @override
  State<StatefulWidget> createState() => DisclaimerMsgState();
}

class DisclaimerMsgState extends State<DisclaimerMsg> {
  final _pref = SharedPreferences.getInstance();
  Future<bool> _unknow;
  bool _valBool = false;
  bool _readed = false;
  var agreementUrl;
  var privateUrl;
  var guideUrl;
  @override
  void initState() {
    _unknow = _pref.then(
      (SharedPreferences pref) => (pref.getBool(dialogPrefKey) ?? false),
    );
    _unknow.then((bool onValue) {
      _valBool = onValue;
      _readed = onValue;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      InkWell(onTap: () => showDisClaimerDialog(context), child: Container());

  showDisClaimerDialog(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: ListBody(
              children: [
                SelectableText(
                  disclaimerText,
                  scrollPhysics: BouncingScrollPhysics(),
                ),
                StreamBuilder(
                  stream: _checkRequest().asStream(),
                  builder: (context, snapshot) {
                    return Wrap(
                      runSpacing: 8.0,
                      children: [
                        slimTxT('《服务协议》', color: Colors.blue, onTap: () {
                          pushName(context, web_view,
                              args: {'url': agreementUrl});
                        }),
                        slimTxT('《隐私政策》', color: Colors.blue, onTap: () {
                          pushName(context, web_view,
                              args: {'url': privateUrl});
                        }),
                        slimTxT('《隐私保护指引》', color: Colors.blue, onTap: () {
                          pushName(context, web_view, args: {'url': guideUrl});
                        }),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        actions: [
          Container(
            width: 250.0,
            child: _buildSureItem(),
          ),
        ],
      ),
    );
  }

  Row _buildSureItem() {
    if (_readed) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '已阅读知晓',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: 10.0),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              tristate: false,
              value: _valBool,
              onChanged: (bool value) {
                if (mounted) {
                  setState(() => _valBool = value);
                }
                Navigator.of(context).pop();
                showDisClaimerDialog(context);
              },
            ),
            Text('不再自动提示')
          ],
        ),
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            '我知道了',
            style: TextStyle(
              fontSize: 16,
              color: !_valBool ? Theme.of(context).primaryColor : Colors.white,
            ),
          ),
          color: _valBool
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withAlpha(800),
          onPressed: () {
            _getPref(_valBool);
            Navigator.of(context).pop();
            Future.delayed(const Duration(milliseconds: 333),
                () => Navigator.of(context).pushReplacementNamed('/'));
          },
        )
      ],
    );
  }

  void _getPref(bool value) async {
    final SharedPreferences pref = await _pref;
    final bool unknow = value;
    if (mounted) {
      setState(() => _unknow =
          pref.setBool(dialogPrefKey, unknow).then((bool success) => unknow));
    }
  }

  Future<void> _checkRequest() async {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://www.google.com',
      connectTimeout: 999,
      receiveTimeout: 999,
    );
    Dio dio = Dio(options);
    try {
      await dio.get('/');
      agreementUrl = agreement1;
      privateUrl = private1;
      guideUrl = guide1;
    } on DioError catch (_) {
      agreementUrl = agreement;
      privateUrl = private;
      guideUrl = guide;
    }
  }
}
