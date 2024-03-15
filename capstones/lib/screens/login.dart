import 'package:flutter/material.dart';

import '../widgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('로그인'),
            Image.asset(
              'lib/images/giryong.png',
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
      body: const LoginForm(),
    );
  }
}
