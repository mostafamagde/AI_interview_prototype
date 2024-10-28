
import 'package:flutter/material.dart';

import 'api_manager/api_manager.dart';
import 'core/routes_manager/route_generator.dart';
import 'core/routes_manager/routes_names.dart';

void main() {
  runApp(const MyApp());
ApiManager.test("what do you know about egypt?");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:RoutesNames.splashView,
      onGenerateRoute: RouteGenerator.generateRoutes,
      title: 'Ai interview prtotype',


    );
  }
}
