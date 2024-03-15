import 'package:flutter/material.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                '답답하고 힘든 마음, 기쁜 마음 모두 기룡이에게 털어 놓으세요.',
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset('lib/images/giryong.png'),
          ],
        ),
      ),
    );
  }
}
