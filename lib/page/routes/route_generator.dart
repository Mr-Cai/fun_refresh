import 'package:flutter/material.dart';
import 'package:fun_refresh/tools/global.dart';
import '../../model/i18n/i18n.dart';
import '../export_page_pkg.dart';

class RouteGenerator {
  static Route<dynamic> generator(RouteSettings settings) {
    final Object args = settings.arguments;

    switch (settings.name) {
      case '/':
        return _skipRoute(SplashPage());
      case home:
        return _skipRoute(I18nContainer(key: i18nKey, child: HomePage()));
      case sign:
        return _skipRoute(SignPage());
      case social:
        return _skipRoute(SocialPage());
      case mind:
        return _skipRoute(MindPage());
      case reward:
        return _skipRoute(RewardPage());
      case setting:
        return _skipRoute(SettingPage());
      case chat:
        return _skipRoute(ChatPage());
      case profile:
        return _skipRoute(ProfilePage(args: args));
      case search:
        return _skipRoute(SearchPanel());
      default:
        return errorRoutes();
    }
  }

  static Route<dynamic> errorRoutes() {
    return _skipRoute(Scaffold(body: Center(child: Text('跳转错误'))));
  }
}

Route<dynamic> _skipRoute(Widget page) {
  return MaterialPageRoute(
    builder: (context) => page,
    fullscreenDialog: true,
  );
}

void pop(BuildContext context) => Navigator.of(context).pop();

Future<dynamic> pushNamed(BuildContext context, String name, {Object args}) {
  return Navigator.of(context).pushNamed(
    '$name',
    arguments: args,
  );
}

Future<dynamic> pushReplace(BuildContext context, String name, {Object args}) {
  return Navigator.of(context).pushReplacementNamed(
    '$name',
    arguments: args,
  );
}
