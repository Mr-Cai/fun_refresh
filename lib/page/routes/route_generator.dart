import 'package:flutter/material.dart';
import '../../tools/global.dart';
import '../../model/i18n/i18n.dart';
import '../export_page_pkg.dart';

class RouteGenerator {
  static Route<dynamic> generator(RouteSettings settings) {
    final Object args = settings.arguments;
    switch (settings.name) {
      case '/':
        return _skipRoute(
          I18nContainer(
            key: i18nKey,
            child: HomePage(),
          ),
        ); // 主页面
      case sign:
        return _skipRoute(SignPage()); // 注册登录页面
      case social:
        return _skipRoute(SocialPage()); // 社交人脉页面
      case mind:
        return _skipRoute(MindPage()); // 想法页面
      case reward:
        return _skipRoute(RewardPage()); // 抽奖游戏页面
      case setting:
        return _skipRoute(SettingPage(true)); // 设置页面
      case chat:
        return _skipRoute(ChatPage()); // 聊天页面
      case profile:
        return _skipRoute(ProfilePage(args: args)); // 个人信息页面
      case search:
        return _skipRoute(SearchPanel()); // 关键词搜索页面
      case web_view:
        return _skipRoute(WebViewPage(args: args)); // 浏览器页面
      case video_detail:
        return _skipRoute(VideoDetailPage(args: args)); // 视频详情
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
        return _skipRoute(SudokuGame()); // 飞翔的小鸟(像素风)
      default:
        return _skipRoute(ErrorPage(args: args)); // 出错页面
    }
  }
}

Route<dynamic> _skipRoute(Widget page) {
  return MaterialPageRoute(
    builder: (context) => page,
    fullscreenDialog: true,
  );
}

void pop(BuildContext context, {dynamic result}) =>
    ctxKey.currentState.pop(result);

Future<dynamic> pushName(BuildContext context, String name, {Object args}) {
  return ctxKey.currentState.pushNamed(
    '$name',
    arguments: args,
  );
}

Future<dynamic> pushReplace(BuildContext context, String name, {Object args}) {
  return ctxKey.currentState.pushReplacementNamed(
    '$name',
    arguments: args,
  );
}
