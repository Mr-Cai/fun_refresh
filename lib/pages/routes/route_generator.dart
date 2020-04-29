import 'package:flutter/material.dart';
import '../export_page_pkg.dart';

class RouteGenerator {
  static Route<dynamic> generator(RouteSettings routeSettings) {
    final Object args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return _skipRoute(HomePage()); // 主页面
      case sign:
        return _skipRoute(SignPage()); // 注册登录页面
      case social:
        return _skipRoute(SocialPage()); // 社交人脉页面
      case mind:
        return _skipRoute(MindPage()); // 想法页面
      case reward:
        return _skipRoute(RewardPage()); // 抽奖游戏页面
      case settings:
        return _skipRoute(SettingsPage(true)); // 设置页面
      case profile:
        return _skipRoute(ProfilePage(args: args)); // 个人信息页面
      case search:
        return _skipRoute(SearchPanel()); // 关键词搜索页面
      case web_view:
        return _skipRoute(WebViewPage(args: args)); // 浏览器页面
      case photos:
        return _skipRoute(PhotoViewPage(args: args)); // 图片查看器
      // 小游戏模块:
      case game2048:
        return _skipRoute(Game2048()); // 2048小游戏
      case tetris:
        return _skipRoute(Tetris()); // 俄罗斯方块(像素风)
      case snake:
        return _skipRoute(SnakeGame()); // 贪吃蛇(像素风)
      case dinosaur_run:
        return _skipRoute(DinosaurRunGame()); // 恐龙快跑(像素风)
      case flappy_bird:
        return _skipRoute(FlappyBird()); // 飞翔的小鸟(像素风)
      case sudoku:
        return _skipRoute(SudokuGame()); // 数独
      case bejeweled:
        return _skipRoute(Bejeweled()); // 宝石迷阵
      // 插件APP:
      case weather:
        return _skipRoute(WeatherPage()); // 天气
      case vision:
        return _skipRoute(VisionPage()); // 相机识别
      default:
        return _skipRoute(ErrorPage(args: args)); // 出错页面
    }
  }
}

Route _skipRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return FadeTransition(
        opacity: animation,
        child: page,
      );
    },
  );
}

Future pushName(BuildContext context, String name, {Object args}) {
  return Navigator.of(context).pushNamed(
    '$name',
    arguments: args,
  );
}

Future pushReplace(BuildContext context, String name, {Object args}) {
  return Navigator.of(context).pushReplacementNamed(
    '$name',
    arguments: args,
  );
}

Future pushRemove(BuildContext context, String name, String modal,
    {Object args}) {
  return Navigator.of(context).pushNamedAndRemoveUntil(
    '$name',
    ModalRoute.withName('name'),
    arguments: args,
  );
}
