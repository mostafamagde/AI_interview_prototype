import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getFilePath(String fileName) async {
  Directory directory = await getApplicationDocumentsDirectory();
  if (Platform.isAndroid || Platform.isIOS) {
    return '${directory.path}/$fileName';
  }
  return '${directory.path}\\$fileName';
}

Future<String> getDeviceIP() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

      bool isEmulator = androidInfo.isPhysicalDevice == false ||
          androidInfo.model.toLowerCase().contains("sdk") ||
          androidInfo.manufacturer.toLowerCase().contains("google") ||
          androidInfo.hardware.toLowerCase().contains("goldfish") ||
          androidInfo.fingerprint.contains("generic");

      if (isEmulator) {
        return '10.0.2.2';
      } else {
        return '192.168.1.32';
      }
    } else if (Platform.isWindows || Platform.isMacOS) {
      return '127.0.0.1';
    } else {
      return '0.0.0.0';
    }
  } catch (_) {
    return '0.0.0.0';
  }
}
