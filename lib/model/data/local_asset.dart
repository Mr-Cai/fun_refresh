import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/api.dart';
import 'package:fun_refresh/tools/pic_tool.dart';

import '../smash_model.dart';

const disclaimerText = '''
                    🔏 隐私政策条例
👉 该软件使用到的视频、文字、音频、图片归版权所有人。
👉 未经您的同意开发者不会获取、共享您的个人信息。
👉 您可以查询更正您的个人资料、注销个人资料。
👉 开发者不会因为您同意本隐私政策而采取强制捆绑收集信息。
👉 地理位置、通讯录、相机、麦克风等权限需明确授权才会开启，也不会因为您的授权在功能不需要的情况下收集信息。
''';

final Map<int, String> labelsMap = {
  1: '1000',
  2: '400',
  3: '800',
  4: '7000',
  5: '5000',
  6: '300',
  7: '2000',
  8: '100',
};

List<List<String>> get navIcons => [
      [iconX('game1'), iconX('game1')],
      [iconX('video0'), iconX('video1')],
      [iconX('extension0'), iconX('extension1')],
      [iconX('chat0'), iconX('chat1')]
    ];

List<String> get coverTitles => [
      '贪吃蛇',
      '数独',
      '俄罗斯方块',
      '开心消消乐',
      '2048',
      '颜值测算',
      '天气',
      '记事本',
      '美女',
    ];

List<String> get covers => [
      '$GIT_ASSET/2048.png',
      '$GIT_ASSET/snake.png',
      '$GIT_ASSET/tetris.png',
    ];

final config = defaultTargetPlatform == TargetPlatform.android
    ? {
        'appID': '1109716769',
        'bannerID': '9040882216019714',
        'nativeID': '4060287287437033',
        'intersID': '7080080247106780',
        'splashID': '7020785136977336',
        'bgPic': 'intelligent.fun_refresh:mipmap/splash_img'
      }
    : {
        'appID': '',
        'bannerID': '',
        'nativeID': '',
        'intersID': '',
        'splashID': '',
        'bgPic': 'LaunchImage'
      };

List<Choice> get choices => [
      Choice(title: '加好友', icon: Icons.person_add),
      Choice(title: '创建群', icon: Icons.people_outline),
    ];

get settingTxT => [
      '账号设置',
      '版本更新',
      '清除缓存',
      '',
    ];
