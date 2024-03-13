import 'package:flutter/material.dart';

class KeyWord extends StatelessWidget {
  const KeyWord({super.key});

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: const Text(
                          '오늘 당신의 \n감성 키워드는 무엇인가요?',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'single_day',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        width: 100,
                        child: Image.asset(
                          'lib/assets/images/giryong.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}