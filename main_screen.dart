import 'package:flutter/material.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFffe3ee),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    '심리 케어 기룡이',
                    style: TextStyle(
                      color: Color(0xFFdf999c),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 400,
                    width: 300,
                    child: Image.asset(
                      'lib/src/image/giryong.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF98dfff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      color: Color(0xFF84bdf3),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {}, //json 전송 후 성공시 화면전환 >> sign_in.dart
                  child: const Text(
                    '회원가입',
                    style: TextStyle(
                      color: Color(0xFF84bdf3),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
