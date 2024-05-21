import 'package:flutter/material.dart';
import 'package:capstones/Extant.dart';
import 'package:capstones/KeyWord.dart';

class Music extends StatefulWidget {
  final String? selectedEmotionFromDiary;
  const Music({super.key, this.selectedEmotionFromDiary});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  late String _selectedEmotionFromDiary;
  @override
  void setState(VoidCallback fn) {
    _selectedEmotionFromDiary = widget.selectedEmotionFromDiary!;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    print('selectedEmotionFromDiary: ${widget.selectedEmotionFromDiary}');
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
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: const Text(
                      '기룡이가 당신의 기분에 맞는 \n음악 추천을 해줄게요!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        fontFamily: 'single_day',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    width: 200,
                    child: Image.asset(
                      'lib/assets/images/giryong.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color(0xFF98dfff),
                      fixedSize: const Size(320, 85),
                    ),
                    onPressed: () {
                      // Extant 위젯으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Extant(
                              selectedEmotion: widget.selectedEmotionFromDiary!,
                            );
                          },
                        ),
                      );
                    },
                    child: const Text(
                      '이미 입력한 \n내용으로 받을게요!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'single_day',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color(0xFF98dfff),
                      fixedSize: const Size(320, 85),
                    ),
                    onPressed: () async {
                      final String? selectedEmotionFromKeyWord =
                          await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const KeyWord();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      '감정 키워드를 \n직접 고를게요!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'single_day',
                      ),
                    ),
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
