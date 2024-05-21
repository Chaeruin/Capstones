import 'package:capstones/screens/chat.dart';
import 'package:capstones/screens/diary.dart';
import 'package:capstones/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:capstones/Music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            DefaultTextStyle(
              style: TextStyle(fontFamily: 'single_day'),
              child: Chat(),
            ),
            DefaultTextStyle(
              style: TextStyle(fontFamily: 'single_day'),
              child: Home(),
            ),
            DefaultTextStyle(
              style: TextStyle(fontFamily: 'single_day'),
              child: Diary(),
            ),
            DefaultTextStyle(
              style: TextStyle(fontFamily: 'single_day'),
              child: Music(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF98dfff),
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 75, 116, 149),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(
                    'lib/assets/images/messenger.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              label: '채팅',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(
                    'lib/assets/images/home.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(
                    'lib/assets/images/diary.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              label: '감정일기',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset(
                    'lib/assets/images/music.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              label: '음악추천',
            ),
          ],
        ),
      ),
    );
  }
}
