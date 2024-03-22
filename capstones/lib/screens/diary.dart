import 'package:capstones/widgets/adddiary.dart';
import 'package:capstones/widgets/editdiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
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
  String writeDate = ' ';
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    super.initState();
  }

  _asyncMethod() async {
    memberId = (await storage.read(key: 'memberId'))!;
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
                  writeDate = DateFormat('yyyyMMdd').format(selectedDate);
                  print(writeDate);
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
                  memberId: memberId,
                  selectedDate: writeDate,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditDiaries(
                  memberId: memberId,
                  selectedDate: writeDate,
                ),
              ),
            );

            setState(() {
              isWrite = true;
            });
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
