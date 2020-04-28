import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/event/drawer_nav_bloc.dart';
import 'package:fun_refresh/model/plugin/plugin_response.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class PluginPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _PluginPageState();
}

class _PluginPageState extends State<PluginPage> {
  String searchStr = '';
  List<Object> words;
  Widget titleWidget;

  TextEditingController _filterTxTCtrl;

  bool isMenu = true;
  bool isWidget = true;
  Function backEvent;

  List filterNames = List();
  List names = List();

  @override
  void initState() {
    initWidget();
    super.initState();
  }

  void initWidget() {
    buildTitle();
    _filterTxTCtrl = TextEditingController()
      ..addListener(() {
        if (_filterTxTCtrl.text.isEmpty) {
          searchStr = '';
          filterNames = names;
        } else {
          setState(() {
            searchStr = _filterTxTCtrl.text;
          });
        }
      });
    backEvent = () {
      setState(() {
        isMenu = true;
        buildTitle();
      });
    };
  }

  Widget buildTitle() {
    return titleWidget = Text(
      '插件',
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: isMenu,
        isWidget: isWidget,
        backEvent: backEvent,
        titleWidget: titleWidget,
        actions: [
          menuIcon(context, icon: 'search', onTap: () {
            setState(() {
              titleWidget = TextFormField(
                controller: _filterTxTCtrl,
                cursorWidth: 1.0,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                autocorrect: true,
                cursorRadius: Radius.circular(2.0),
                decoration: InputDecoration(
                  hintText: '请输入你想要的插件...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.all(8.0),
                ),
                onChanged: (value) {
                  print(value);
                },
              );
              isMenu = false;
            });
          }),
        ],
      ),
      body: StreamBuilder<PluginResponse>(
        stream: netool.pullPluginList().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(searchStr.isNotEmpty) {
              for (var item in filterNames) {
                if (item['name']) {
                  
                }
              }
            }
            return GridView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(12.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              children: List.generate(
                snapshot.data.pluginList.length,
                (index) => AppIcon(
                  item: snapshot.data.pluginList[index],
                  index: index,
                ),
              ),
            );
          }
          return Center(child: flareAnim(context));
        },
      ),
    );
  }
}

class AppIcon extends StatelessWidget {
  const AppIcon({this.item, this.index});

  final Item item;
  final num index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 1:
            pushName(context, weather);
            break;
          case 2:
            pushName(context, vision);
            break;
          default:
        }
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: 64.0,
                height: 64.0,
                child: netPic(pic: item.pic),
              ),
            ),
            freeTxT(item.name),
          ],
        ),
      ),
    );
  }
}
