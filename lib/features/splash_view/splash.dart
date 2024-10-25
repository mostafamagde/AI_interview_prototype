import 'package:flutter/material.dart';

import '../../core/routes_manager/routes_names.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        Navigator.pushReplacementNamed(context, RoutesNames.homeView);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0D0F1B),
        child: Image(
      image: AssetImage("assests/images/spalsh.jpeg"),
      fit: BoxFit.contain,
    ));
  }
}
