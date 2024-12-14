import 'package:ai_interview_prototype/core/voice_recognition/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

late final FlutterSoundRecorder audioRecorder;
final FlutterSoundPlayer audioPlayer = FlutterSoundPlayer();
const Codec codec = Codec.pcm16WAV;
const String audioFileName = "audio.wav";
const int sampleRate = 16000;

Future<String?> startRecording(String fileName) async {
  try {
    audioRecorder = FlutterSoundRecorder();
  } catch (_) {}
  await audioRecorder.openRecorder();
  PermissionStatus permissionStatus = await Permission.microphone.request();

  if (permissionStatus.isGranted) {
    debugPrint("Start Recording");
    String path = await getFilePath(fileName);
    debugPrint(path);

    await audioRecorder.startRecorder(
      codec: codec,
      sampleRate: sampleRate,
      toFile: path,
    );

    return path;
  } else {
    debugPrint("Permission Denied When Start Recording");
    return null;
  }
}

Future<String> stopRecording() async {
  debugPrint("Stop Recording");
  String? path = await audioRecorder.stopRecorder();
  await audioRecorder.closeRecorder();
  debugPrint(path!);
  return path;
}

Future<void> startPlayAudio(String fileName) async {
  await audioPlayer.openPlayer();

  await audioPlayer.startPlayer(
    fromURI: fileName,
    codec: Codec.mp3,
    whenFinished: () {},
  );

  debugPrint("Start Play Audio");
}

Future<void> stopPlayAudio() async {
  await audioPlayer.stopPlayer();
  debugPrint("Stop Play Audio");
}
