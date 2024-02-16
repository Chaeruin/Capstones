import 'package:flutter/material.dart';
import 'package:login/src/screens/login_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  DateTime date = DateTime.now();
  List<String> genderList = ['남성', '여성'];
  String genderValue = '남성';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '회원가입',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Form(
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...[
                    TextFormField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'e-mail',
                        labelText: 'E-Mail',
                      ),
                      //onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        filled: true,
                        labelText: 'PASSWORD',
                      ),
                      obscureText: true,
                      //onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                          filled: true, labelText: 'NICKNAME'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownButton(
                      value: genderValue,
                      items: genderList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          genderValue = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('생년월일'),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                initialDate: date);
                            if (selectedDate != null) {
                              setState(() {
                                date = selectedDate;
                              });
                            }
                          },
                          child: Text(
                            "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const LogIn();
                                },
                              ),
                            );
                          }, //db에 정보 발송, 로그인창으로 이동
                          child: const Text(
                            '등록',
                            style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
