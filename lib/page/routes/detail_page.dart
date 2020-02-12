import 'package:flutter/material.dart';
import 'package:fun_refresh/components/custom_app_bar.dart';
import 'package:fun_refresh/model/data/local_asset.dart';
import 'package:fun_refresh/model/smash_model.dart';
import 'package:fun_refresh/tools/global.dart';
import '../export_page_pkg.dart';

class DetailPage extends StatefulWidget {
  DetailPage({this.args});
  final Map args;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  _onSelected(Choice choice) => setState(() => choices[0] = choice);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: GradientAppBar(
          context: context,
          title: widget.args['title'],
          actions: [
            widget.args['menu'] == true
                ? PopupMenuButton<Choice>(
                    icon: Icon(Icons.add),
                    onSelected: _onSelected,
                    itemBuilder: (context) {
                      return choices.map((Choice choice) {
                        return PopupMenuItem(
                          value: choice,
                          child: GestureDetector(
                            onTap: () {
                              switch (choice.title) {
                                case '加好友':
                                  return pushNamed(context, detail,
                                      args: {'title': '加好友'});
                                  break;
                                default:
                                  return null;
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(choice.icon),
                                Text(choice.title),
                              ],
                            ),
                          ),
                        );
                      }).toList();
                    },
                  )
                : Container(),
          ],
        ),
        body: _skipPage(widget.args['title']),
      );
  _skipPage(String title) {
    // 根据索引切换页面
    switch (title) {
      case '人脉':
        return SocialPage();
      case '想法':
        return MindPage();
      case '奖励':
        return RewardPage();
      case '设置':
        return SettingPage();
      case '贪吃蛇':
        return SnakePage();
      case '数独':
        return SudoKuPage();
      case '俄罗斯方块':
        return TetrisPage();
      case '开心消消乐':
        return EliminatePage();
      case '颜值测算':
        return VisionPage();
      case '天气':
        return WeatherPage();
      case '记事本':
        return NotePage();
      case '美女':
        return GirlPage();
      case '个人信息':
        return ProfilePage();
      default:
        return Center(child: Text('错误'));
    }
  }
}
