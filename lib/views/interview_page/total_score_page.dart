import 'package:flutter/material.dart';

class TotalScorePage extends StatelessWidget {
  const TotalScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${(ModalRoute.of(context)?.settings.arguments as String)}"),
          ],
        ),
      ),
    );
  }
}
