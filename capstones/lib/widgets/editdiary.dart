//원래 써 놧던 내용을 조회 후 수정 및 저장
import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/diary_model.dart';
import 'package:flutter/material.dart';

class EditDiaries extends StatefulWidget {
  final String memberId;
  const EditDiaries({super.key, required this.memberId});

  @override
  State<EditDiaries> createState() => _EditDiariesState();
}

class _EditDiariesState extends State<EditDiaries> {
  late Future<Diaries?> diaries;
  bool isWrite = false;
  late TextEditingController _textEditingController;
  late String memberId;

  @override
  void initState() {
    super.initState();
    memberId = widget.memberId;
    diaries = readDiary(memberId); //memberId
    _textEditingController = TextEditingController(text: diaries.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Column(
            children: [
              FutureBuilder(
                future: diaries,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        TextField(
                          controller: _textEditingController,
                          enabled: isWrite,
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isWrite = true;
          });
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
