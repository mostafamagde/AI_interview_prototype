import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/gemi_model.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static Future<GemiModel> getGemiResponse(String req) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "contents": [
        {
          "parts": [
            {"text": req}
          ]
        }
      ]
    });
    var dio = Dio();
    var response = await dio.request(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=AIzaSyB9GWJSEZwbAs1Lby-0azbq0jHmacj2J2Q',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return GemiModel.fromJson(response.data);
    } else {
      throw Exception(response.statusCode);
    }
  }

  static Future<GemiModel> test(String req) async {
    var url = Uri.https(
        "generativelanguage.googleapis.com",
        "/v1beta/models/gemini-1.5-flash-latest:generateContent",
        {"key": "AIzaSyB9GWJSEZwbAs1Lby-0azbq0jHmacj2J2Q"});
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "contents": [
            {
              "parts": [
                {"text": req}
              ]
            }
          ]
        },
      ),
    );
    if (response.statusCode == 200) {
      return GemiModel.fromJson(jsonDecode(response.body));

    }else {
      throw Exception("Failed to get response: ${response.statusCode}");
    }
  }
}
