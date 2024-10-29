import 'package:ai_interview_prototype/api_manager/api_manager.dart';
import 'package:flutter/material.dart';

import 'core/routes_manager/route_generator.dart';
import 'core/routes_manager/routes_names.dart';

void main() {
  runApp(const MyApp());
  ApiManager.uploadAudio();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesNames.splashView,
      onGenerateRoute: RouteGenerator.generateRoutes,
      title: 'Ai interview prtotype',
    );
  }
}
