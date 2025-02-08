import 'package:flutter/material.dart';
import 'core/routes_manager/route_generator.dart';
import 'core/routes_manager/routes_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
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
