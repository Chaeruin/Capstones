// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:login/member/diary.dart';
import 'package:login/screens/diary_write_screen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DiaryHomeScreen extends StatefulWidget {
  const DiaryHomeScreen({super.key});

  @override
  State<DiaryHomeScreen> createState() => _DiaryHomeScreenState();
}

class _DiaryHomeScreenState extends State<DiaryHomeScreen> {
  List<DiaryEntry> entries = [];
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SfCalendar(
              view: CalendarView.month,
              onTap: (CalendarTapDetails details) {
                setState(() {
                  selectedDate = details.date;
                  print(selectedDate);
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                if (selectedDate != null &&
                    entry.date!.year == selectedDate!.year &&
                    entry.date!.month == selectedDate!.month &&
                    entry.date!.day == selectedDate!.day) {
                  return ListTile(
                    title: Text(entry.text),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? newEntry = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEntryPage(selectedDate)),
          );
          if (newEntry != null) {
            setState(
              () {
                entries.add(DiaryEntry(
                  text: newEntry,
                  date: selectedDate ?? DateTime.now(),
                ));
              },
            );
          }
        },
        tooltip: 'Add Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}
