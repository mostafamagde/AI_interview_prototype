import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class PlayerManager {
  PlayerManager(this._fileName, this._codec);

  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();
  final String _fileName;
  final Codec _codec;

  Future<void> startPlayAudio() async {
    await _audioPlayer.openPlayer();

    await _audioPlayer.startPlayer(
      fromURI: _fileName,
      codec: _codec,
      whenFinished: () {},
    );

    debugPrint("Start Play Audio");
  }

  Future<void> stopPlayAudio() async {
    await _audioPlayer.stopPlayer();
    debugPrint("Stop Play Audio");
  }
}
