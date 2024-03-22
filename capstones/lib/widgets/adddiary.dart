import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/diary_model.dart';
import 'package:flutter/material.dart';

class AddDiaries extends StatefulWidget {
  final String selectedDate;
  final String memberId;
  const AddDiaries(
      {super.key, required this.selectedDate, required this.memberId});

  @override
  State<AddDiaries> createState() => _AddDiariesState();
}

class _AddDiariesState extends State<AddDiaries> {
  late String _content;
  late String _writeDate;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _writeDate = widget.selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('페이지 추가'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(_writeDate),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                expands: false,
                controller: _textEditingController,
                maxLines: 10,
                onChanged: (value) {
                  setState(() {
                    _content = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Diaries newPage = Diaries(
            memberId: widget.memberId,
            writeDate: _writeDate,
            content: _content,
          );
          await saveDiary(newPage);
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
