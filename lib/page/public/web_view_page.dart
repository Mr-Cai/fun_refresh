import 'dart:async';
import 'dart:developer';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:toast/toast.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({@required this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _webCtrl;
  String title;
  bool isLoading = true;
  num stackToView = 1;
  int progress = 0;
  Timer _timer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.values[0]]);
    _simulateProgress();
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        isGradient: true,
        title: title ?? '正在打开网页...',
      ),
      body: IndexedStack(
        index: stackToView,
        children: [
          WebView(
            initialUrl: widget.args['url'],
            onWebViewCreated: (controller) {
              Toast.show('正在加载... 请稍后..🧐', context);
              _webCtrl = controller;
            },
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (url) {
              setState(() => isLoading = true);
            },
            onPageFinished: (url) {
              setState(() {
                isLoading = false;
                stackToView = 0;
                Toast.show('加载完成✅', context);
              });
              _webCtrl.evaluateJavascript('document.title').then(
                    (value) => {
                      setState(() => title = value.replaceAll('\"', '')),
                    },
                  );
            },
            javascriptChannels: [
              JavascriptChannel(
                name: 'toast',
                onMessageReceived: (msg) {
                  log(msg.message, name: '😎');
                  if (msg.message == 'end') {
                    Toast.show('已阅读完毕', context, duration: 2);
                  }
                },
              ),
            ].toSet(),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 2.5,
                  child: LinearProgressIndicator(
                    value: isLoading ? progress / 100 : 1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: sizeH(context) * .3,
                  child: FlareActor(
                    path('loading', 0),
                    animation: 'Alarm',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 模拟异步加载
  Future _simulateProgress() async {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(milliseconds: 50), (time) {
        progress++;
        if (progress > 98) {
          _timer.cancel();
          _timer = null;
          return;
        } else {
          setState(() {});
        }
      });
    }
  }
}
