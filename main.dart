import 'package:flutter/material.dart';
import 'package:login/screens/chatroom.dart';
import 'package:login/screens/diary_screen.dart';
import 'package:login/screens/main_screen.dart';
import 'package:login/screens/setting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            MainHome(),
            ChatRoom(),
            DiaryHomeScreen(),
            SettingScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.amber,
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
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
