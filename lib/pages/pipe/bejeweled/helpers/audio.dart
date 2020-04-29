import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';

class Audio {
  static AudioCache player = AudioCache();

  //
  // Initialization.  We pre-load all sounds.
  //
  static Future<dynamic> init() async {
    await player.loadAll([
      'audio/bejeweled/swap.wav',
      'audio/bejeweled/move_down.wav',
      'audio/bejeweled/bomb.wav',
      'audio/bejeweled/game_start.wav',
      'audio/bejeweled/win.wav',
      'audio/bejeweled/lost.wav',
    ]);
  }

  static play() async {
    AudioPlayer player = AudioPlayer();
    await player.play('assets/bejeweled/audio/swap.wav', isLocal: true);
  }

  static playAsset(AudioType audioType) {
    player.play('audio/bejeweled/${describeEnum(audioType)}.wav');
  }
}

enum AudioType {
  swap,
  move_down,
  bomb,
  game_start,
  win,
  lost,
}
