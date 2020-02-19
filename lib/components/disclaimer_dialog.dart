import 'package:flutter/material.dart';
import '../model/data/local_asset.dart';
import '../tools/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DisclaimerMsg extends StatefulWidget {
  const DisclaimerMsg({Key key, this.state}) : super(key: key);
  final State state;
  @override
  DisclaimerMsgState createState() => DisclaimerMsgState();
}

class DisclaimerMsgState extends State<DisclaimerMsg> {
  final _pref = SharedPreferences.getInstance();
  Future<bool> _unknow;
  bool _valBool = false;
  bool _readed = false;
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
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => showDisClaimerDialog(context), child: Container());

  Future<void> showDisClaimerDialog(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ListBody(
            children: [
              SelectableText(disclaimerText),
              Row(
                children: [
                  Text('👉 前往查看完整版'),
                  GestureDetector(
                    child: Text(
                      '隐私政策',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onTap: () async {
                      const url =
                          'https://github.com/Mr-Cai/fun_refresh/blob/master/declaimer';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        actions: <Widget>[
          Container(
            width: 250.0,
            child: _buildSureItem(),
          )
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
            padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                () => Navigator.of(context).pushReplacementNamed(home));
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
}
