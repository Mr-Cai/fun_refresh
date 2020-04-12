import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pages/export_page_pkg.dart';

enum NavigationEvent { home, video, extend, social, mind, reward, setting }

class NavigationState {}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => ExtensionPage();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.home:
        yield HomePage();
        break;
      case NavigationEvent.video:
        yield VideoPage();
        break;
      case NavigationEvent.extend:
        yield ExtensionPage();
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
        yield SettingsPage(false);
        break;
    }
  }
}
