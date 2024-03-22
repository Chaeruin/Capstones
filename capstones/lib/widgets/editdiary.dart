//원래 써 놧던 내용을 조회 후 수정 및 저장
import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/diary_model.dart';
import 'package:flutter/material.dart';

class EditDiaries extends StatefulWidget {
  final String memberId;
  final String selectedDate;
  const EditDiaries(
      {super.key, required this.memberId, required this.selectedDate});

  @override
  State<EditDiaries> createState() => _EditDiariesState();
}

class _EditDiariesState extends State<EditDiaries> {
  late Future<Diaries?> diary;
  bool isWrite = false;
  late TextEditingController _textEditingController;
  late String memberId;
  late String writeDate;

  @override
  void initState() {
    super.initState();
    memberId = widget.memberId;
    writeDate = widget.selectedDate;

    diary = readDiary(memberId, writeDate); //memberId
    _textEditingController = TextEditingController(text: diary.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: diary,
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
