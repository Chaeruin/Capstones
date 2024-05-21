import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/diary_model.dart';
import 'package:flutter/material.dart';
import 'package:capstones/music.dart';

enum Emotion {
  joy,
  hope,
  anger,
  anxiety,
  neutrality,
  sadness,
  tiredness,
  regret,
}

class EditDiaries extends StatefulWidget {
  final Diaries diary;

  const EditDiaries({
    super.key,
    required this.diary,
  });

  @override
  State<EditDiaries> createState() => _EditDiariesState();
}

class _EditDiariesState extends State<EditDiaries> {
  late Future<Diaries> _diaryFuture;
  bool _isEditing = false;
  late TextEditingController _textEditingController;
  late String _content;
  String _emotionType = '';
  late String _selectedImage = 'lib/assets/images/giryong.png';

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: (widget.diary.content));
    _content = '';
    _emotionType = widget.diary.emotionType;
    _diaryFuture = readDiarybyDiaryId(widget.diary.diaryId);
    _selectedImage = 'lib/assets/images/${widget.diary.emotionType}.png';
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = 'lib/assets/images/joy.png';
                    _emotionType = Emotion.joy.toString().split('.').last;
                  });
                  Navigator.pop(context);
                },
                child: const Text('기쁨'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = 'lib/assets/images/hope.png';
                    _emotionType = Emotion.hope.toString().split('.').last;
                  });
                  Navigator.pop(context);
                },
                child: const Text('희망'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = 'lib/assets/images/anger.png';
                    _emotionType = Emotion.anger.toString().split('.').last;
                  });
                  Navigator.pop(context);
                },
                child: const Text('분노'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = 'lib/assets/images/anxiety.png';
                    _emotionType = Emotion.anxiety.toString().split('.').last;
                  });
                  Navigator.pop(context);
                },
                child: const Text('불안'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = 'lib/assets/images/neutrality.png';
                    _emotionType =
                        Emotion.neutrality.toString().split('.').last;
                  });
                  Navigator.pop(context);
                },
                child: const Text('중립'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = 'lib/assets/images/sadness.png';
                    _emotionType = Emotion.sadness.toString().split('.').last;
                  });
                  Navigator.pop(context);
                },
                child: const Text('슬픔'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = 'lib/assets/images/tiredness.png';
                    _emotionType = Emotion.tiredness.toString().split('.').last;
                  });
                  Navigator.pop(context);
                },
                child: const Text('피곤'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedImage = 'lib/assets/images/regret.png';
                    _emotionType = Emotion.regret.toString().split('.').last;
                  });
                  Navigator.pop(context);
                },
                child: const Text('후회'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CADE4),
        centerTitle: true,
        title: Text(
          (widget.diary.writeDate),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: 'single_day',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // 일기 삭제 기능 구현
              bool isDeleted =
                  await deleteDiary(widget.diary.diaryId.toString());
              if (isDeleted) {
                Navigator.pop(context);
              } else {
                // 삭제 실패 처리
                print("일기 삭제에 실패했습니다.");
              }
            },
            icon: Image.asset(
              'lib/assets/images/delete.png',
              width: 35,
              height: 35,
            ),
          ),
          IconButton(
            onPressed: () async {
              //백엔드 요청
              Diaries newPage = Diaries(
                diaryId: widget.diary.diaryId,
                memberId: widget.diary.memberId,
                writeDate: widget.diary.writeDate,
                content: _content,
                emotionType: _emotionType,
              );
              await updateDiary(newPage, widget.diary.diaryId);
              setState(() {
                _isEditing = false; // 저장 버튼을 누르면 수정 모드 종료
              });
              Navigator.pop(context);
              Navigator.push(
                context,
                //music.dart에 감정 전송
                MaterialPageRoute(
                  builder: (context) => Music(
                    selectedEmotionFromDiary: _emotionType,
                  ),
                ),
              );
            },
            icon: Image.asset(
              'lib/assets/images/month.png',
              width: 35,
              height: 35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Diaries>(
          future: _diaryFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            } else {
              // 데이터가 로드되었을 때의 UI를 표시
              return Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        _showImagePicker(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF98DFFF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '저를 클릭해서 당신의 \n기분을 선택하세요!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'single_day',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(
                            _selectedImage,
                            height: 90,
                            width: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEditing = true; // 입력창을 탭하면 수정 모드 시작
                        });
                      },
                      child: SizedBox(
                        width: 350, // 원하는 가로 길이로 설정
                        child: TextField(
                          controller: _textEditingController,
                          enabled: _isEditing,
                          maxLines: 19,
                          onChanged: (value) {
                            setState(() {
                              _content = _textEditingController.text;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFFFE3EE),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
