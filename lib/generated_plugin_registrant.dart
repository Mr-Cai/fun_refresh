//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:audioplayers/audioplayers_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:soundpool_web/soundpool_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:video_player_web/video_player_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  AudioplayersPlugin.registerWith(registry.registrarFor(AudioplayersPlugin));
  FirebaseCoreWeb.registerWith(registry.registrarFor(FirebaseCoreWeb));
  SharedPreferencesPlugin.registerWith(registry.registrarFor(SharedPreferencesPlugin));
  SoundpoolPlugin.registerWith(registry.registrarFor(SoundpoolPlugin));
  UrlLauncherPlugin.registerWith(registry.registrarFor(UrlLauncherPlugin));
  VideoPlayerPlugin.registerWith(registry.registrarFor(VideoPlayerPlugin));
  registry.registerMessageHandler();
}
