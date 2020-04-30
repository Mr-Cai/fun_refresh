import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/tools/global.dart';
import '../../components/top_bar.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({this.args});

  final Map args;

  @override
  State<StatefulWidget> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  
  @override
  void initState() {
    statusBar();
    super.initState();
  }

  @override
  void dispose() {
    statusBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        title: widget.args == null ? '错误' : widget.args['title'],
        isLightBar: widget.args['isLight'] ?? true,
      ),
      body: InkWell(
        onTap: () {},
        child: Column(
          children: [
            holderPage(
              context,
              args: widget.args ??
                  {
                    'name': '404',
                    'anim': 'idle',
                    'desc': '糟糕 ! 页面找不到了 !!!',
                  },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
