import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pages/export_page_pkg.dart';

enum NavigationEvent { confetti, plugin, social, mind, reward, setting }

class NavigationState {}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => ConfettiPage();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.confetti:
        yield ConfettiPage();
        break;
      case NavigationEvent.plugin:
        yield PluginPage();
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
