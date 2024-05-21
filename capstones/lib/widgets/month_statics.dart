import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:capstones/models/MonthStatistics_model.dart';

class MonthStatisticsPage extends StatelessWidget {
  const MonthStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<MonthStatistics> model = [
      MonthStatistics(
          count: 20,
          color: const Color.fromARGB(255, 253, 171, 248).withOpacity(1),
          text: "기쁨"),
      MonthStatistics(
          count: 5,
          color: const Color.fromARGB(255, 113, 202, 246).withOpacity(1),
          text: "희망"),
      MonthStatistics(count: 3, color: Colors.grey.withOpacity(1), text: "분노"),
      MonthStatistics(
          count: 10,
          color: const Color.fromARGB(255, 250, 245, 95).withOpacity(1),
          text: "불안"),
      MonthStatistics(
          count: 7,
          color: const Color.fromARGB(255, 148, 252, 152).withOpacity(1),
          text: "슬픔"),
      MonthStatistics(
          count: 20,
          color: const Color.fromARGB(255, 118, 161, 255).withOpacity(1),
          text: "중립"),
      MonthStatistics(
          count: 20,
          color: const Color.fromARGB(255, 232, 151, 246).withOpacity(1),
          text: "피곤"),
      MonthStatistics(
          count: 20,
          color: const Color.fromARGB(255, 254, 151, 151).withOpacity(1),
          text: "후회"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF87CEFA),
        centerTitle: true,
        title: const Text(
          '이 달의 마음 통계',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'single_day',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                // 이미지 크기 조정
                SizedBox(
                  width: 150,
                  height: 200,
                  child: Image.asset('lib/assets/images/giryong.png'),
                ),
                Container(
                  height: 100,
                  width: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xFF98dfff),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '이번 달의 당신이 느낀 \n감정 비율이에요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'single_day',
                    ),
                  ),
                )
              ],
            ),

            // Pie Chart 추가
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.width,
                ),
                painter: PieChartPainter(model),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<MonthStatistics> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()..color = Colors.white;

    Offset offset = Offset(size.width / 2, size.width / 2);
    double radius = (size.width / 2) * 0.8;
    canvas.drawCircle(offset, radius, circlePaint);

    double startPoint = -math.pi / 2; // 시작 각도 초기화

    // "기쁨" 섹션을 먼저 그리도록 순서 변경
    for (int i = 0; i < data.length; i++) {
      if (data[i].text == "기쁨") {
        double sweepAngle = 2 * math.pi * (data[i].count / 100);
        circlePaint.color = data[i].color;

        // 아크 그리기
        canvas.drawArc(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.width / 2), radius: radius),
          startPoint,
          sweepAngle,
          true,
          circlePaint,
        );

        // 중심 각도 계산
        double angle = startPoint + sweepAngle / 2;

        // 텍스트 그리기
        TextSpan span = TextSpan(
          text: data[i].text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'single_day',
          ),
        );
        TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        tp.layout();

        // 텍스트의 위치 계산
        double textX = size.width / 2 + radius * 0.8 * math.cos(angle);
        double textY = size.width / 2 + radius * 0.8 * math.sin(angle);

        Offset textOffset = Offset(textX - tp.width / 2, textY - tp.height / 2);
        tp.paint(canvas, textOffset);

        // 다음 섹션의 시작 각도 계산
        startPoint += sweepAngle;
        break; // "기쁨" 섹션을 그린 후에는 종료
      }
    }

    // 나머지 섹션 그리기
    for (int i = 0; i < data.length; i++) {
      if (data[i].text != "기쁨") {
        double sweepAngle = 2 * math.pi * (data[i].count / 100);
        circlePaint.color = data[i].color;

        // 아크 그리기
        canvas.drawArc(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.width / 2), radius: radius),
          startPoint,
          sweepAngle,
          true,
          circlePaint,
        );

        // 중심 각도 계산
        double angle = startPoint + sweepAngle / 2;

        // 텍스트 그리기
        TextSpan span = TextSpan(
          text: data[i].text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'single_day',
          ),
        );
        TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        tp.layout();

        // 텍스트의 위치 계산
        double textX = size.width / 2 + radius * 0.8 * math.cos(angle);
        double textY = size.width / 2 + radius * 0.8 * math.sin(angle);

        Offset textOffset = Offset(textX - tp.width / 2, textY - tp.height / 2);
        tp.paint(canvas, textOffset);

        // 다음 섹션의 시작 각도 계산
        startPoint += sweepAngle;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
