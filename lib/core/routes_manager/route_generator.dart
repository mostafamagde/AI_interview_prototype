import 'package:ai_interview_prototype/core/routes_manager/routes_names.dart';
import 'package:ai_interview_prototype/views/interview_page/interview_page.dart';
import 'package:ai_interview_prototype/views/interview_requirements_page/interview_requirements_page.dart';
import 'package:ai_interview_prototype/views/splash_view/splash.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.interviewPage:
        return MaterialPageRoute(
          builder: (context) => const InterviewPage(),
          settings: settings,
        );

      case RoutesNames.interviewRequirementsPage:
        return MaterialPageRoute(
          builder: (context) => const InterviewRequirementsPage(),
          settings: settings,
        );

      case RoutesNames.splashView:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
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
