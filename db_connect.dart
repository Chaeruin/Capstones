import 'package:http/http.dart' as http;
import 'package:login/member/diary.dart';
import 'dart:convert';

import 'package:login/member/member.dart';
import 'package:login/member/signin.dart';

Future<bool> saveUser(Member member) async {
  try {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/members/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(member.toJson()),
    );

    //print('Response Status Code: ${response.statusCode}');
    //print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      //print("데이터가 성공적으로 전송되었습니다.");
      return true;
    } else {
      //print("데이터 전송에 실패했습니다.");
      return false;
    }
  } catch (e) {
    print("Failed to send post data: $e");
    return false;
  }
}

Future<Member?> loginUser(String id, String password) async {
  try {
    final loginData = LogIn(loginId: id, password: password);
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginData.toJson()),
    );

    //print('Response Status Code: ${response.statusCode}');
    //print('Response Body: ${utf8.decode(response.bodyBytes)}'); //인코딩 깨지는 부분 해결

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final Map<String, dynamic> userJson = responseData['user'];
      final String nickname = userJson['nickname'];
      return Member(
        memberId: userJson['memberId'],
        password: '', // 비밀번호는 서버에서 반환되지 않음
        nickname: nickname,
        gender: userJson['gender'],
        birthdate: userJson['birthdate'],
      );
    } else {
      //print("로그인 실패: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    //print("로그인 요청 실패: $e");
    return null;
  }
}

Future<bool> saveDiary(DiaryEntry diaryEntry) async {
  try {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8080/api/members/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(diaryEntry.toJson()),
    );

    if (response.statusCode == 200) {
      print("데이터가 성공적으로 전송되었습니다.");
      return true;
    } else {
      print("데이터 전송에 실패했습니다.");
      return false;
    }
  } catch (e) {
    print("Failed to send post data: $e");
    return false;
  }
}
