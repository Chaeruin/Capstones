import 'package:capstones/screens/chat.dart';
import 'package:capstones/screens/diary.dart';
import 'package:capstones/screens/greeting.dart';
import 'package:capstones/screens/setting.dart';
import 'package:capstones/Music.dart';
import 'package:capstones/screens/statistics.dart';
import 'package:flutter/material.dart';

class LoginedMain extends StatefulWidget {
  final String memberId;
  const LoginedMain({super.key, required this.memberId});

  @override
  State<LoginedMain> createState() => _LoginedMainState();
}

class _LoginedMainState extends State<LoginedMain> {
  late String memberId;

  @override
  void initState() {
    super.initState();
    memberId = widget.memberId;
  }

  int bottomNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: bottomNavIndex,
          children: [
            const DefaultTextStyle(
              style: TextStyle(fontFamily: 'single_day'),
              child: Chat(),
            ),
            const DefaultTextStyle(
              style: TextStyle(fontFamily: 'single_day'),
              child: GreetingPage(),
            ),
            const DefaultTextStyle(
              style: TextStyle(fontFamily: 'single_day'),
              child: Diary(),
            ),
            const DefaultTextStyle(
              style: TextStyle(fontFamily: 'single_day'),
              child: Music(),
            ),
            // DefaultTextStyle(
            //   style: TextStyle(fontFamily: 'single_day'),
            //   child: Setting(),
            // ),
            DefaultTextStyle(
              style: const TextStyle(fontFamily: 'single_day'),
              child: Statistics(
                memberId: memberId,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF98dfff),
          currentIndex: bottomNavIndex,
          selectedItemColor: const Color.fromARGB(255, 75, 116, 149),
          unselectedItemColor: Colors.black,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              bottomNavIndex = index;
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
            const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 24, width: 24, child: Icon(Icons.calculate)),
              ),
              label: '통계',
            ),
          ],
        ),
      ),
    );
  }
}
