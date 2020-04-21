import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const String disclaimerText = '''

👉 您好，欢迎使用小蔡开发的趣刷App！

👉 使用之前请审慎阅读以下政策内容。

👉 受上架审核影响，App必须有保护用户隐私的政策。

👉 用户有个人隐私的权利，主动权掌握在您手中。

👉 该软件使用到的视频、文字、音频、图片归版权所有人。

👉 未经您的同意开发者不会获取、共享您的个人信息。

👉 您可以查询更正您的个人资料、注销个人资料。

👉 开发者不会因为您同意本隐私政策而采取强制捆绑收集信息。

👉 地理位置、通讯录、相机、麦克风等隐私权限需明确授权才会开启，
且不会因为您的授权在功能不需要的情况下收集信息。

👉 请您详细阅读:  👇👇👇👇👇👇
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

Map defaultArgs = {
  'name': 'programmer',
  'anim': 'coding',
  'desc': '正在开发中...',
  'title': '敬请期待'
};

const picHome = 'https://pic.downk.cc/item';

List<String> get covers => [
      '$picHome/5e6e7132e83c3a1e3a1b5d1c.jpg', // 恐龙快跑(像素风)
      '$picHome/5e6f2d55e83c3a1e3a65ed53.jpg', // 飞翔的小鸟(像素风)
      '$picHome/5e6e058de83c3a1e3aef1326.png', // 贪吃蛇(像素风)
      '$picHome/5e6e11d8e83c3a1e3af405d7.jpg', // 2048
      '$picHome/5e6e70e5e83c3a1e3a1b3462.jpg', // 俄罗斯方块(像素风)
      '$picHome/5e70d91fe83c3a1e3a4ab3f1.jpg', // 数独
      '$picHome/5e7108d9e83c3a1e3a65d279.png', // 宝石迷阵
    ];

Map<String, String> get config {
  return defaultTargetPlatform == TargetPlatform.android
      ? {
          'appID': '1109716769',
          'bannerID': '9040882216019714',
          'nativeID': '8040483237917481',
          'intersID': '7080080247106780',
          'splashID': '7020785136977336',
          'bgPic': 'intelligent.fun_refresh:mipmap-xhdpi/white.jpg'
        }
      : {
          'appID': '',
          'bannerID': '',
          'nativeID': '',
          'intersID': '',
          'splashID': '',
          'bgPic': 'LaunchImage'
        };
}

List<String> get settingTxT => [
      '账号设置',
      '版本更新',
      '清除缓存',
      '',
    ];
