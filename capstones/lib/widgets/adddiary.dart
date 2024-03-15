import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/diary_model.dart';
import 'package:capstones/screens/diary.dart';
import 'package:flutter/material.dart';

class AddDiaries extends StatefulWidget {
  final DateTime selectedDate;
  const AddDiaries({super.key, required this.selectedDate});

  @override
  State<AddDiaries> createState() => _AddDiariesState();
}

class _AddDiariesState extends State<AddDiaries> {
  late String _content;
  late DateTime _writeDate;
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
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          child: Column(
            children: [
              Text(
                  "${_writeDate.month.toString().padLeft(2, '0')}-${_writeDate.day.toString().padLeft(2, '0')}"),
              const SizedBox(
                height: 16,
              ),
              TextField(
                expands: true,
                controller: _textEditingController,
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    _content = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Diaries newPage = Diaries(
            writeDate: _writeDate.toString(),
            content: _content,
          );
          await saveDiary(newPage);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Diary(),
              ));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
