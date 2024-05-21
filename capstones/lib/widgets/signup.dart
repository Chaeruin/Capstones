import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/member_model.dart';
import 'package:capstones/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '환영합니다~',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'single_day',
              ),
            ),
            Image.asset(
              'lib/assets/images/giryong.png',
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(child: SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

enum Gender { male, female }

class _SignUpFormState extends State<SignUpForm> {
  String _email = '';
  String _password = '';
  String _nickname = '';
  String _gender = ''; // 'male', 'female'
  String _birthdate = '';
  bool focus = true;
  DateTime initialDay = DateTime.now();
  var gender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '아이디',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'single_day',
            ),
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Id',
              floatingLabelStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'single_day',
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF98dfff),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF98dfff),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            '비밀번호',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'single_day',
            ),
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              floatingLabelStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'single_day',
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF98dfff),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF98dfff),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            '닉네임',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'single_day',
            ),
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _nickname = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Nickname',
              floatingLabelStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'single_day',
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF98dfff),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF98dfff),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('성별',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'single_day',
              )),
          Column(
            children: [
              RadioListTile(
                activeColor: const Color(0xFF98dfff),
                title: const Text('남자'),
                value: Gender.male,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                    _gender = '남자';
                  });
                },
              ),
              RadioListTile(
                activeColor: const Color(0xFF98dfff),
                title: const Text('여자'),
                value: Gender.female,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                    _gender = '여자';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          //datepicker로
          const Text(
            '생년월일',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'single_day',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final DateTime? dateTime = await showDatePicker(
                  context: context,
                  initialDate: initialDay,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2200));
              if (dateTime != null) {
                setState(() {
                  initialDay = dateTime;
                  _birthdate =
                      DateFormat('yyyyMMdd').format(initialDay).toString();
                });
              }
            },
            child: Text(_birthdate),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF98dfff),
              fixedSize: const Size(400, 45),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onPressed: () async {
              // 회원가입 정보 생성
              Member newMember = Member(
                memberId: _email,
                password: _password,
                nickname: _nickname,
                gender: _gender,
                birthdate: _birthdate,
              );
              // 회원가입 정보 서버에 전송
              await saveUser(newMember); // saveUser 함수 호출을 await로 감싸기
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            child: const Text(
              '회원가입 하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'single_day',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
