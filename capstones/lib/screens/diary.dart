import 'package:capstones/widgets/adddiary.dart';
import 'package:capstones/widgets/editdiary.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  late DateTime selectedDate;
  bool isWrite = false;
  late String memberId;

  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF98dfff),
        title: const Text('My Diary'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SfCalendar(
              initialSelectedDate: selectedDate,
              view: CalendarView.month,
              onTap: (CalendarTapDetails details) {
                setState(() {
                  selectedDate = details.date!;
                  print(selectedDate);
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Image.asset('lib/images/giryong.png'),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF98dfff),
                  ),
                  child: const Text(
                    '오늘 무슨 일이 있었는지 \n기룡이에게 솔직하게\n 털어 놓아 보아요!',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (isWrite == false) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDiaries(
                  selectedDate: selectedDate,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditDiaries(memberId: memberId),
              ),
            );

            setState(() {
              isWrite = true;
            });
          }
          /*
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
        */
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
