import 'dart:io';
import 'dart:convert';
import 'package:ai_interview_prototype/core/voice_recognition/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> sendAudioToServer(String filePath) async {
  final audioFile = File(filePath);
  bool isExist = await audioFile.exists();
  debugPrint(isExist.toString());

  late http.MultipartRequest request;

  request = http.MultipartRequest(
    'POST',
    Uri.parse('http://${await getDeviceIP()}:5003/stt'),
  );

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
