import 'package:ai_interview_prototype/core/managers/file_manager.dart';
import 'package:ai_interview_prototype/core/managers/player_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecorderManager {
  RecorderManager(this._fileName, this._codec) {
    _playerManager = PlayerManager(_fileName, _codec);
  }

  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  final Codec _codec;
  final int _sampleRate = 16000;
  final FileManager _fileManager = const FileManager();
  final String _fileName;
  late final PlayerManager _playerManager;

  Future<String> startRecording() async {
    await _audioRecorder.openRecorder();
    final PermissionStatus permissionStatus = await Permission.microphone.request();

    if (permissionStatus.isGranted) {
      debugPrint("Start Recording");
      final String path = await _fileManager.getFullFilePath(_fileName);
      debugPrint(path);

      await _audioRecorder.startRecorder(
        codec: _codec,
        sampleRate: _sampleRate,
        toFile: path,
      );

      return path;
    } else {
      throw Exception("Permission Denied");
    }
  }

  Future<String> stopRecording() async {
    debugPrint("Stop Recording");
    String? path = await _audioRecorder.stopRecorder();
    await _audioRecorder.closeRecorder();
    debugPrint(path!);
    return path;
  }

  Future<void> startPlayAudio() async {
    await _playerManager.startPlayAudio();
  }

  Future<void> stopPlayAudio() async {
    await _playerManager.stopPlayAudio();
  }
}
