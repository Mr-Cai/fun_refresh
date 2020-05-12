import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/model/event/drawer_nav_bloc.dart';
import 'package:fun_refresh/model/plugin/plugin_response.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class PluginPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _PluginPageState();
}

class _PluginPageState extends State<PluginPage> {
  var searchStr = '';
  var svgIcon = 'search';

  Widget titleWidget;

  TextEditingController filterTxTCtrl;

  bool isMenu = true;
  bool isWidget = true;

  Function backEvent;

  var keyWords = List<Item>();
  var filterWords = List<Item>();

  @override
  void initState() {
    initWidget();
    super.initState();
  }

  @override
  void dispose() {
    filterTxTCtrl.dispose();
    super.dispose();
  }

  void initWidget() {
    buildTitle();
    filterTxTCtrl = TextEditingController()
      ..addListener(() {
        setState(() {
          if (filterTxTCtrl.text.isEmpty) {
            searchStr = '';
            filterWords = keyWords;
          } else {
            searchStr = filterTxTCtrl.text;
          }
        });
      });
    backEvent = () {
      setState(() {
        isMenu = true;
        buildTitle();
        svgIcon = 'search';
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
      appBar: TopBar(
        themeColor: Colors.black,
        isMenu: isMenu,
        isWidget: isWidget,
        backEvent: backEvent,
        titleWidget: titleWidget,
        actions: [
          menuIcon(context, size: 26.0, icon: svgIcon, onTap: () {
            setState(() {
              titleWidget = TextFormField(
                controller: filterTxTCtrl,
                cursorWidth: 1.0,
                keyboardType: TextInputType.text,
                autofocus: true,
                textInputAction: TextInputAction.search,
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
                onChanged: (value) {},
              );
              isMenu = false;
              if (svgIcon == 'close') {
                svgIcon = 'search';
                titleWidget = buildTitle();
                isMenu = true;
                filterWords = keyWords;
                filterTxTCtrl.clear();
              } else {
                svgIcon = 'close';
                isMenu = false;
              }
            });
          }),
        ],
      ),
      body: StreamBuilder<PluginResponse>(
        stream: netool.pullPluginList().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var tempList = List<Item>();
            for (var item in snapshot.data.pluginList) {
              tempList.add(item);
            }
            Future.delayed(Duration(milliseconds: 100), () {
              setState(() {
                keyWords = tempList;
                filterWords = keyWords;
              });
            });
            if (searchStr.isNotEmpty) {
              var tempList = List<Item>();
              for (var item in filterWords) {
                if ('${item.name}'
                    .toLowerCase()
                    .contains(searchStr.toLowerCase())) {
                  tempList.add(item);
                }
              }
              filterWords = tempList;
              keyWords.shuffle();
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
                snapshot.data.pluginList.length == null
                    ? 0
                    : filterWords.length,
                (index) => AppIcon(
                  item: filterWords[index],
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
        pushName(context, item.route, args: defaultArgs);
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
