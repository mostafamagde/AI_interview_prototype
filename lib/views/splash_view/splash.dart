import 'package:ai_interview_prototype/core/routes_manager/routes_names.dart';
import 'package:flutter/material.dart';

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
        if (mounted) {
          Navigator.pushReplacementNamed(context, RoutesNames.interviewRequirementsPage);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0F1B),
      child: const Image(
        image: AssetImage("assests/images/spalsh.jpeg"),
        fit: BoxFit.contain,
      ),
    );
  }
}
