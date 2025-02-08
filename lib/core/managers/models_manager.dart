import 'dart:convert';
import 'dart:io';
import 'package:ai_interview_prototype/core/constants.dart';
import 'package:ai_interview_prototype/core/managers/IP_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ModelsManager {
  const ModelsManager(this._sessionId);

  static const IPManager _ipManager = IPManager();
  final String _sessionId;

  Future<String> textToText(final String text) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final http.Request request = http.Request(
      'POST',
      Uri.parse("${await Constants.getBaseUrl(await _ipManager.getDeviceIP(), Constants.port)}/${Constants.tttEndPoint}"),
    );

    request.body = json.encode({
      "prompt": text,
      "sessionId": _sessionId,
    });
    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final String responseData = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = json.decode(responseData);
      debugPrint("data: ${jsonResponse['data']}");

      return jsonResponse['data'];
    } else {
      debugPrint("Error");
      return "Error";
    }
  }

  Future<String> textToVoice(final String text) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final http.Request request = http.Request(
      'POST',
      Uri.parse("${await Constants.getBaseUrl(await _ipManager.getDeviceIP(), Constants.port)}/${Constants.ttvEndPoint}"),
    );

    request.body = json.encode({"text": text});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final Directory directory = await getApplicationDocumentsDirectory();
        final String filePath = '${directory.path}/generated_audio.mp3';

        final File file = File(filePath);
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

  Future<String> voiceToText(final String voicePath) async {
    final File audioFile = File(voicePath);
    bool isExist = await audioFile.exists();
    debugPrint(isExist.toString());

    late http.MultipartRequest request;
    final String url = "${await Constants.getBaseUrl(await _ipManager.getDeviceIP())}/${Constants.vttEndPoint}";

    request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.files.add(
      await http.MultipartFile.fromPath('audio', audioFile.path),
    );

    final http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final String responseData = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = json.decode(responseData);
      debugPrint("data: ${jsonResponse['data']}");

      return jsonResponse['data'];
    } else {
      debugPrint("Error");
      return "Error";
    }
  }
}
