import 'package:capstones/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  static const storage = FlutterSecureStorage();

  logout() async {
    await storage.delete(key: 'memberId');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyApp(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setting'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: TextButton(
          onPressed: logout,
          child: const Text('로그아웃'),
        ),
      ),
    );
  }
}
