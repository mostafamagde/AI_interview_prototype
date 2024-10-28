import 'dart:io';
import 'dart:convert';
import 'package:record/record.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

const String audioFileName = "audio.wav";

Future<String> getFilePath(String fileName) async {
  Directory directory = await getApplicationDocumentsDirectory();
  if (Platform.isAndroid || Platform.isIOS) {
    return '${directory.path}/$fileName';
  }
  return '${directory.path}\\$fileName';
}

Future<String> sendAudioToServer(String fileName) async {
  final audioFile = File(await getFilePath(fileName));
  bool isExist = await audioFile.exists();
  debugPrint(isExist.toString());

  var request;

  if (Platform.isWindows) {
    request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5001/stt'),
    );
  } else if (Platform.isAndroid || Platform.isIOS) {
    request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:5001/stt'),
    );
  }

  request.files.add(
    await http.MultipartFile.fromPath('audio', audioFile.path),
  );

  var response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await response.stream.bytesToString();
    var jsonResponse = json.decode(responseData);
    debugPrint(jsonResponse['text']);

    return jsonResponse['text'];
  } else {
    debugPrint("Error");
    return "Error";
  }
}

final AudioRecorder audioRecord = AudioRecorder();
final AudioPlayer audioPlayer = AudioPlayer();

Future<void> startRecording(String fileName) async {
  if (await audioRecord.hasPermission()) {
    debugPrint("Start Recording");
    String path = await getFilePath(fileName);
    debugPrint(path);
    await audioRecord.start(const RecordConfig(encoder: AudioEncoder.wav, noiseSuppress: true, sampleRate: 16000), path: path);
  } else {
    debugPrint("Permission Denied When Start Recording");
  }
}

Future<void> stopRecording() async {
  if (await audioRecord.hasPermission()) {
    debugPrint("Stop Recording");
    String? path = await audioRecord.stop();
    debugPrint(path!);
  } else {
    debugPrint("Permission Denied When Stop Recording");
  }
}

Future<void> playRecording(String fileName) async {
  DeviceFileSource source = DeviceFileSource(await getFilePath(fileName));
  await audioPlayer.play(source);
  debugPrint("Play Finished");
}
