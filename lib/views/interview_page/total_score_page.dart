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
            Text("Total Score: ${(ModalRoute.of(context)?.settings.arguments as List)[0]}"),
            const SizedBox(height: 10),
            Text("Last Question Score: ${(ModalRoute.of(context)?.settings.arguments as List)[1]}"),
          ],
        ),
      ),
    );
  }
}
