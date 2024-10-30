import 'package:google_generative_ai/google_generative_ai.dart';

class ApiManager {
  static Future<String> gemiRequest(String req) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyB9GWJSEZwbAs1Lby-0azbq0jHmacj2J2Q",
    );
    final prompt = req;

    final response = await model.generateContent([Content.text(prompt)]);
print(response.text);
    return response.text!;
  }
}
