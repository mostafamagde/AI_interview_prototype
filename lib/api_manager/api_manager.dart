import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static Future<String> gemiRequest(String req) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyB9GWJSEZwbAs1Lby-0azbq0jHmacj2J2Q",
    );
    final prompt = req;

    final response = await model.generateContent([Content.text(prompt)]);

    return response.text!;
  }


 static void uploadAudio() async {
   var data = FormData.fromMap({
     'files': [
       await MultipartFile.fromFile('/D:/sound1.wav', filename: '/D:/sound1.wav')
     ],

   });

   var dio = Dio();
   var response = await dio.request(
     'https://40d3-197-36-23-71.ngrok-free.app/intgerate-models',
     options: Options(
       method: 'POST',
     ),
     data: data,
   );

   if (response.statusCode == 200) {
     print(json.encode(response.data));
   }
   else {
     print(response.statusMessage);
   }
 }

}
