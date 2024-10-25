import 'package:ai_interview_prototype/core/routes_manager/routes_names.dart';
import 'package:flutter/material.dart';

import '../../features/home_page/home_page.dart';
import '../../features/speech_to_text/speech_to_text.dart';
import '../../features/splash_view/splash.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.homeView:
        return MaterialPageRoute(
          builder: (context) =>  HomePage(),
          settings: settings,
        );

      case RoutesNames.splashView:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
          settings: settings,
        );

      case RoutesNames.speechView:
        return MaterialPageRoute(
          builder: (context) => const SpeechtoText(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
          settings: settings,
        );
    }
  }
}
