import 'package:flutter_bloc/flutter_bloc.dart';
import '../../page/export_page_pkg.dart';

enum NavigationEvent {
  home,
  game,
  video,
  extend,
  message,
  social,
  mind,
  reward,
  setting
}

class NavigationState {}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => GamePage();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.home:
        yield HomePage();
        break;
      case NavigationEvent.game:
        yield GamePage();
        break;
      case NavigationEvent.video:
        yield VideoPage();
        break;
      case NavigationEvent.extend:
        yield ExtensionPage();
        break;
      case NavigationEvent.message:
        yield MessagePage();
        break;
      case NavigationEvent.social:
        yield SocialPage();
        break;
      case NavigationEvent.mind:
        yield MindPage();
        break;
      case NavigationEvent.reward:
        yield RewardPage();
        break;
      case NavigationEvent.setting:
        yield SettingPage(false);
        break;
    }
  }
}
