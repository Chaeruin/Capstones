import 'package:flutter/material.dart';

//음악 추천-이미 입력한 내용

class Extant extends StatelessWidget {
  final String musicRecommendationUrl =
      'https://youtu.be/XEfle_XvYiw?si=sS2MryzR7k2d6z3w'; // 가상의 음악 추천 URL

  const Extant({super.key});

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
                        width: 220,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: const Text(
                          '오늘 당신의 기분에 \n어울리는 추천 음악은..',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'single_day',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 10),
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
                  const SizedBox(height: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/images/music.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 150),
                          InkWell(
                            onTap: () {
                              print('이동할 URL: $musicRecommendationUrl');
                            },
                            child: const Text(
                              '링크1',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF98DFFF),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/images/music.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 150),
                          InkWell(
                            onTap: () {
                              print('이동할 URL: $musicRecommendationUrl');
                            },
                            child: const Text(
                              '링크2',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF98DFFF),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                       const SizedBox(height: 50),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/images/music.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 150),
                          InkWell(
                            onTap: () {
                              print('이동할 URL: $musicRecommendationUrl');
                            },
                            child: const Text(
                              '링크3',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF98DFFF),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
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









