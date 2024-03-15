import 'package:capstones/screens/chat.dart';
import 'package:capstones/screens/diary.dart';
import 'package:capstones/screens/greeting.dart';
import 'package:capstones/screens/setting.dart';
import 'package:flutter/material.dart';

class LoginedMain extends StatefulWidget {
  const LoginedMain({super.key});

  @override
  State<LoginedMain> createState() => _LoginedMainState();
}

class _LoginedMainState extends State<LoginedMain> {
  int bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: bottomNavIndex,
          children: const [
            GreetingPage(),
            Chat(),
            Diary(),
            Setting(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: bottomNavIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              bottomNavIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈', //홈
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded), //채팅
              label: '채팅',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), //캘린더
              label: '다이어리',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '설정', //설정
            ),
          ],
        ),
      ),
    );
  }
}
