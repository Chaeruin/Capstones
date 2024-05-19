import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/diary_model.dart';
import 'package:capstones/widgets/adddiary.dart';
import 'package:capstones/widgets/editdiary.dart';
//import 'package:capstones/widgets/month_statics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  late DateTime selectedDate;
  bool isWrite = false;
  late String? memberId;
  String writeDate = DateFormat('yyyyMMdd').format(DateTime.now());
  final storage = const FlutterSecureStorage();
  SharedPreferences? prefs;
  RefreshController? _refreshController;
  Set<String> writedays = {};

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final writedaysList = prefs!.getStringList('writedays');

    if (writedaysList == null) {
      await prefs!.setStringList('writedays', []);
    } else {
      writedays = writedaysList.toSet();
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _updateWritedays(String date) async {
    writedays.add(date);
    await prefs!.setStringList('writedays', writedays.toList());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    _initPrefs();
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onRefresh() async {
    // Fetch new data

    setState(() {});
    // Call refresh complete when finished
    _refreshController!.refreshCompleted();
  }

  _asyncMethod() async {
    memberId = (await storage.read(key: 'memberId'));
  }

  @override
  Widget build(BuildContext context) {
    if (prefs == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF98dfff),
        centerTitle: true,
        title: Text(
          '${selectedDate.year}년 ${selectedDate.month}월',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'single_day',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ),
                );
              },
              child: Image.asset('lib/assets/images/month.png'),
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController!,
        enablePullDown: true,
        onRefresh: _onRefresh,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SfCalendar(
                showDatePickerButton: true,
                initialSelectedDate: selectedDate,
                view: CalendarView.month,
                headerStyle: const CalendarHeaderStyle(
                  textStyle: TextStyle(
                    fontFamily: 'single_day',
                    fontSize: 22,
                  ),
                ),
                onTap: (CalendarTapDetails details) {
                  setState(() {
                    selectedDate = details.date!;
                    writeDate = DateFormat('yyyyMMdd').format(selectedDate);
                  });
                },
                monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
                monthCellBuilder: (context, details) {
                  final writedays = prefs!.getStringList('writedays');
                  if (writedays!.isNotEmpty) {
                    for (var day in writedays) {
                      if (day == DateFormat('yyyyMMdd').format(details.date)) {
                        return Center(
                          child: Column(
                            children: [
                              Text(
                                details.date.day.toString(),
                              ),
                              const Text(
                                '●',
                                style: TextStyle(color: Color(0xFF98dfff)),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  }

                  return Center(
                    child: Column(
                      children: [
                        Text(
                          details.date.day.toString(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Image.asset('lib/assets/images/giryong.png'),
                  Expanded(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF98dfff),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        '오늘 무슨 일이 있었는지 \n기룡이에게 솔직하게\n 털어 놓아 보아요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'single_day',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onDoubleTap: () {},
                    onTap: () async {
                      Diaries? newPage =
                          await readDiarybyDate(memberId!, writeDate);
                      if (newPage != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDiaries(diary: newPage),
                          ),
                        );
                      } else {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddDiaries(
                              memberId: memberId!,
                              selectedDate: writeDate,
                            ),
                          ),
                        );
                        _updateWritedays(writeDate);
                      }
                    },
                    child: SizedBox(
                      width: 56.0,
                      height: 56.0,
                      child: Center(
                        child: Image.asset('lib/assets/images/write.png'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
