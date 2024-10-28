import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String> getFilePath(String fileName) async {
  Directory directory = await getApplicationDocumentsDirectory();
  if (Platform.isAndroid || Platform.isIOS) {
    return '${directory.path}/$fileName';
  }
  return '${directory.path}\\$fileName';
}

Future<String> recieveAudioFromServer(String text) async {
  var headers = {'text': text};

  var request;

  if (Platform.isWindows) {
    request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5001/tts'),
    );
  } else if (Platform.isAndroid || Platform.isIOS) {
    request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:5001/tts'),
    );
  }

  request.headers.addAll(headers);

  try {
    var response = await request.send();
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
