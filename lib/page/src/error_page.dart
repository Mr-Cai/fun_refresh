import 'package:flutter/material.dart';
import '../../components/mini.dart';
import '../../components/top_bar.dart';
import '../../model/i18n/i18n.dart';

class ErrorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        themeColor: Colors.black,
        title: I18n.of(context).error,
      ),
      body: errorLoad(context),
    );
  }
}
