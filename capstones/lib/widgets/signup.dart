import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/member_model.dart';
import 'package:capstones/screens/login.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('환영합니다~'),
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

  final TextEditingController _birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('아이디'),
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
          const Text('비밀번호'),
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
          const Text('닉네임'),
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
          const Text('성별', style: TextStyle(fontSize: 16)),
          ListTile(
            selectedColor: Colors.blue,
            title: const Text('남성'),
            leading: Radio(
              value: Gender.male,
              groupValue: _gender,
              onChanged: (value) {
                _gender = value.toString();
              },
            ),
          ),
          ListTile(
            selectedColor: Colors.blue,
            title: const Text('여성'),
            leading: Radio(
              value: Gender.female,
              groupValue: _gender,
              onChanged: (value) {
                _gender = value.toString();
              },
            ),
          ),
          const SizedBox(height: 20),
          //datepicker로
          const Text('생년월일'),
          TextFormField(
            controller: _birthdateController,
            onChanged: (value) {
              setState(() {
                _birthdate = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'YYYYMMDD',
              floatingLabelStyle: TextStyle(
                color: Colors.grey,
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
                birthDate: _birthdate,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
