import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../tools/global.dart';

const String disclaimerText = '''
            🔏  服务协议与隐私政策
👉 该软件使用到的视频、文字、音频、图片归版权所有人: 蔡凯歌。
👉 未经您的同意开发者不会获取、共享您的个人信息。
👉 您可以查询更正您的个人资料、注销个人资料。
👉 开发者不会因为您同意本隐私政策而采取强制捆绑收集信息。
👉 地理位置、通讯录、相机、麦克风等隐私权限需明确授权才会开启，且不会因为您的授权在功能不需要的情况下收集信息。
👉 请阅读:    👇👇👇👇👇👇👇👇
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
      [path('game1', 5), path('game1', 5)],
      [path('video0', 5), path('video1', 5)],
      [path('extension0', 5), path('extension1', 5)],
      [path('chat0', 5), path('chat1', 5)]
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
      'https://pic.downk.cc/item/5e6e7132e83c3a1e3a1b5d1c.jpg', // 恐龙快跑(像素风)
      'https://pic.downk.cc/item/5e6f2d55e83c3a1e3a65ed53.jpg', // 飞翔的小鸟(像素风)
      'https://pic.downk.cc/item/5e6e058de83c3a1e3aef1326.png', // 贪吃蛇(像素风)
      'https://pic.downk.cc/item/5e6e11d8e83c3a1e3af405d7.jpg', // 2048
      'https://pic.downk.cc/item/5e6e70e5e83c3a1e3a1b3462.jpg', // 俄罗斯方块(像素风)
      'https://pic.downk.cc/item/5e70d91fe83c3a1e3a4ab3f1.jpg', // 数独
    ];

Map<String, String> get config =>
    defaultTargetPlatform == TargetPlatform.android
        ? {
            'appID': '1109716769',
            'bannerID': '9040882216019714',
            'nativeID': '8040483237917481',
            'intersID': '7080080247106780',
            'splashID': '7020785136977336',
            'bgPic': 'intelligent.fun_refresh:mipmap/white'
          }
        : {
            'appID': '',
            'bannerID': '',
            'nativeID': '',
            'intersID': '',
            'splashID': '',
            'bgPic': 'LaunchImage'
          };

List<String> get settingTxT => [
      '账号设置',
      '版本更新',
      '清除缓存',
      '',
    ];
