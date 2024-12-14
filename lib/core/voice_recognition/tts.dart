import 'dart:convert';
import 'dart:io';
import 'package:ai_interview_prototype/core/voice_recognition/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String> recieveAudioFromServer(String text) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST', Uri.parse('http://${await getDeviceIP()}:5003/tts'));
  request.body = json.encode({"text": text});
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/generated_audio.mp3';

      var file = File(filePath);
      await file.writeAsBytes(await response.stream.toBytes());

      return filePath;
    } else {
      debugPrint("Error: ${response.statusCode}");
      return "Error";
    }
  } catch (e) {
    debugPrint("Exception: $e");
    return "Error";
  }
}
