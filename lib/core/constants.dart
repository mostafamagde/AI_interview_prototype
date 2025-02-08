final class Constants {
  static const String intergrateEndPoint = "api/v1/gemini/integrate-models";
  static const String vttEndPoint = "api/v1/gemini/voice-text";
  static const String ttvEndPoint = "api/v1/gemini/text-voice";
  static const String tttEndPoint = "api/v1/gemini/text-text";
  static const int port = 3000;
  static Future<String> getBaseUrl(final String deviceIP, [int port = Constants.port]) async {
    return 'http://$deviceIP:$port';
  }
}
