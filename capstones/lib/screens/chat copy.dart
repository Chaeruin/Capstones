// ignore_for_file: avoid_print, prefer_const_declarations, use_super_parameters, no_logic_in_create_state
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, this.memberId});

  final String? memberId; // memberId 추가

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String? memberId;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    String? value = await storage.read(key: 'memberId');
    if (value != null) {
      setState(() {
        memberId = value;
      });
    } else {
      print('Error: memberId not found in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: memberId != null
          ? ChatScreen(memberId: memberId!)
          : const Scaffold(
              body: Center(
                child: Text('로그인이 필요합니다.'),
              ),
            ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String? memberId; // memberId를 인자로 추가

  const ChatScreen({Key? key, required this.memberId})
      : super(key: key); // 생성자 수정

  @override
  State createState() =>
      ChatScreenState(memberId: memberId); // 생성자 호출 시 memberId 전달
}

class ChatScreenState extends State<ChatScreen> {
  //사용자가 입력한 텍스트 읽는 컨트롤러
  final TextEditingController _textController = TextEditingController();
  //채팅 메세지 저장
  final List<ChatMessage> _messages = <ChatMessage>[];
  late String? memberId; // memberId 필드 추가
  int chatId = 0; // 일단 0으로 초기화
  bool _isLoading = false;

  ChatScreenState({this.memberId}); // 생성자 수정

  @override
  void initState() {
    super.initState();
    memberId = widget.memberId; // widget에서 memberId 값을 가져와 초기화
    // ★ 채팅방에 입장하면 스프링에 채팅방 생성 요청 보내기 ★
    enterChatRoom();
  }

  // 채팅방에 입장하는 함수
  Future<void> enterChatRoom() async {
    // 스프링 서버에 채팅방 생성 요청을 보내는 코드

    final String springUrl = 'http://54.79.110.239:8080/api/chat/newChatRoom';

    // 요청 본문에 담을 데이터
    // POST 요청 보내기
    final http.Response response = await http.post(
      Uri.parse(springUrl),
      body: {'flutterRequest': '채팅방 요청'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      setState(() {
        chatId = responseData['chatId']; // chatId를 상태 변수에 저장
      });
      print('채팅방이 생성되었습니다. chatId: $chatId');
    } else {
      print('채팅방 생성에 실패했습니다. 에러 코드: ${response.statusCode}');
    }
  }

  //사용자가 입력한 메세지 처리
  void _handleSubmitted(String text) {
    _textController.clear();
    //사용자 입력
    ChatMessage message = ChatMessage(
      text: text,
      isUser: true,
    );
    setState(() {
      //사용자가 보낸 가장 최신의 메시지가 리스트 맨 위에 표시
      _messages.insert(0, message);
      // 사용자가 입력한 메시지를 서버에 전송
      sendMessage(chatId, text, memberId!); // ★
      //상대가 보내는 메세지-> 안녕하세요!를 임의로 넣음 // (민주) 여기부분 일단 생략해놓음..!!
      // _messages.insert(
      //     0,
      //     const ChatMessage(
      //       text: '안녕하세요!',
      //       //사용자가 아닌 상대를 나타냄
      //       isUser: false,
      //     ));
    });
  }

  // ★ 메시지를 전송하는 함수 ★
  Future<void> sendMessage(int chatId, String message, String? memberId) async {
    // memberId가 null인 경우 처리
    if (memberId == null) {
      print('Error: memberId is null');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Spring 서버에 메시지를 전송하는 요청
    final String springUrl =
        'http://54.79.110.239:8080/api/chat/requestMessageFromFlutter/$chatId';

    // 전송할 데이터를 Map 형태로 생성
    final Map<String, dynamic> chat = {
      'chatId': chatId.toString(),
      'memberId': memberId,
      'chatContent': message,
    };

    // HTTP POST 요청을 보내서 데이터 전송
    final http.Response response = await http.post(Uri.parse(springUrl),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(chat));

    // Spring 서버 응답 처리
    print('Spring 서버 응답 Status Code: ${response.statusCode}');
    print(
        'Spring 서버 응답 Body: ${utf8.decode(response.bodyBytes)}'); //인코딩 깨지는 부분 해결

    if (response.statusCode == 200) {
      print('Spring으로 메세지가 성공적으로 전달되었습니다');
      // Spring 서버로부터의 응답을 처리하여 메시지를 추가
      final springResponseBody = jsonDecode(utf8.decode(response.bodyBytes));
      final receivedMessage =
          springResponseBody['response']; //여기는 사실 Flask로부터 온 응답임

      setState(() {
        // 상대방이 보낸 메시지를 리스트 맨 위에 추가
        _messages.insert(
          0,
          ChatMessage(
            text: receivedMessage,
            isUser: false, // 상대방이 보낸 메시지이므로 isUser를 false로 설정
          ),
        );
        _isLoading = false;
      });
    } else {
      print('Spring으로 메세지 전송에 실패했습니다. Error: ${response.reasonPhrase}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // 여기까지 채팅 FLASK랑 연동부분 추가했어! 밑에는 은하가 만든 부분 그대로야!

  //채팅 메세지 표시하는 부분->디자인
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF98DFFF),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              //메세지 수
              itemCount: _messages.length,
              //메세지 생성
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          // 메세지와 입력창을 구분하는 가로 선
          const Divider(height: 1.0),
          //입력창과 전송 버튼 포함된 부분
          const SizedBox(height: 20,),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.only(left: 12.0), // 왼쪽에만 여백 추가
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Container(
                    height: 40.0,
                    width: 100.0,
                    color: Colors.white, // 배경색을 흰색으로 설정
                    child: const SpinKitThreeBounce(
                    color: Colors.black, // 점의 색을 검은색으로 설정
                    size: 10.0, // 기존과 동일한 점의 크기 유지
                  ),
                ),)
                ],
                
              ),
            ),


            const SizedBox(width: 8, height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  //입력창 생성->디자인
  Widget _buildTextComposer() {
    return Builder(
      builder: (BuildContext context) {
        return IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration:
                        const InputDecoration.collapsed(hintText: '메시지를 입력하세요'),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'single_day',
                    ),
                    keyboardAppearance: Brightness.light,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}



//체팅 메세지 처리하는 부분
class ChatMessage extends StatelessWidget {
  //메세지
  final String text;
  //메세지의 주인 여부
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});
  //채팅 메세지 디자인 부분
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              if (!isUser)
                Container(
                  margin: const EdgeInsets.only(
                      right: 10.0, left: 10.0, bottom: 10),
                  child: const CircleAvatar(
                    backgroundImage:
                        AssetImage('lib/assets/images/giryong.png'),
                    radius: 20,
                  ),
                ),
              if (isUser)
                Container(
                  margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: const Text('나'),
                ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.5,
                ),
                margin: const EdgeInsets.only(right: 10.0, left: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'single_day',
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
