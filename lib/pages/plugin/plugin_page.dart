import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fun_refresh/components/mini.dart';
import 'package:fun_refresh/components/theme.dart';
import 'package:fun_refresh/components/top_bar.dart';
import 'package:fun_refresh/model/event/drawer_nav_bloc.dart';
import 'package:fun_refresh/model/plugin/plugin_response.dart';
import 'package:fun_refresh/pages/export_page_pkg.dart';
import 'package:fun_refresh/tools/global.dart';
import 'package:fun_refresh/tools/net_tool.dart';

class PluginPage extends StatefulWidget with NavigationState {
  @override
  State<StatefulWidget> createState() => _PluginPageState();
}

class _PluginPageState extends State<PluginPage> {
  FixedExtentScrollController _scrollCtrl;
  int currentIndex = 1;
  bool isShowTopBar = true;

  @override
  void initState() {
    _scrollCtrl = FixedExtentScrollController(initialItem: 1);
    _scrollCtrl.addListener(() async {
      if (_scrollCtrl.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          Future.delayed(Duration(milliseconds: 100), () {
            isShowTopBar = true;
          });
        });
      } else {
        setState(() {
          Future.delayed(Duration(milliseconds: 100), () {
            isShowTopBar = false;
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isShowTopBar
          ? TopBar(
              themeColor: Colors.black,
              isMenu: true,
              title: '插件',
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Container(),
            ),
      body: StreamBuilder<PluginResponse>(
        stream: netool.pullPluginList().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                toggleApp(currentIndex);
              },
              child: ListWheelScrollView(
                physics: BouncingScrollPhysics(),
                onSelectedItemChanged: (index) {
                  setState(() => currentIndex = index);
                },
                controller: _scrollCtrl,
                itemExtent: sizeH(context) * .25,
                children: List.generate(
                  snapshot.data.pluginList.length,
                  (index) {
                    return CoverCard(
                      item: snapshot.data.pluginList[index],
                    );
                  },
                ),
              ),
            );
          }
          return Center(child: flareAnim(context));
        },
      ),
    );
  }

  void toggleApp(int index) {
    switch (index) {
      case 0:
        pushName(context, girl); // 美女宝典
        break;
      case 2:
        pushName(context, weather); // 天气
        break;
      case 3:
        pushName(context, vision); // 相机
        break;
      default:
    }
  }
}

class CoverCard extends StatelessWidget {
  const CoverCard({this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            netPic(pic: item.pic),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: sizeW(context),
                height: sizeH(context) * .03,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black54,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: freeTxT(item.desc, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
