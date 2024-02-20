import 'package:flutter/material.dart';
import 'package:login/database/db_connect.dart';
import 'package:login/member/diary.dart';

class AddEntryPage extends StatefulWidget {
  final DateTime? selectedDate;

  const AddEntryPage(this.selectedDate, {super.key});

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  late String _text;
  late DateTime? _date;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selected Date: ${widget.selectedDate}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _textEditingController,
              decoration:
                  const InputDecoration(labelText: 'Write your entry...'),
              maxLines: null,
              onChanged: (value) {
                setState(() {
                  _text = value;
                  _date = widget.selectedDate;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String? text = _textEditingController.text.trim();
                DiaryEntry newDiaryEntry = DiaryEntry(
                  text: _text,
                  date: _date,
                );
                if (text.isNotEmpty) {
                  await saveDiary(newDiaryEntry);
                  if (!mounted) return;
                  Navigator.pop(context, text);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter some text.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
