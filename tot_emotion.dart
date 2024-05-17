import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/statistics_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_barchart/extension/expandedSection.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

class TotalEmotion extends StatefulWidget {
  final String memberId;
  const TotalEmotion({super.key, required this.memberId});

  @override
  State<TotalEmotion> createState() => _TotalEmotionState();
}

class _TotalEmotionState extends State<TotalEmotion> {
  late Future<MonthlyEmotion> sentiment;
  String writeDate = DateFormat('yyyyMMdd').format(DateTime.now()).toString();
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    sentiment = readEmotionMonthly(widget.memberId, writeDate);
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onRefresh() async {
    // Fetch new data
    setState(() {
      sentiment = readEmotionMonthly(widget.memberId, writeDate);
    });
    // Call refresh complete when finished
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _onRefresh,
      child: FutureBuilder(
        future: sentiment,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildChart(snapshot);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Widget _buildChart(AsyncSnapshot<MonthlyEmotion> snapshot) {
  var sentiment = snapshot.data!;

  // 여기 sentiment 받아서 처리하기
  double joy =
      (double.parse(sentiment.joy.replaceAll('%', '')) * 100).roundToDouble();
  double hope =
      (double.parse(sentiment.hope.replaceAll('%', '')) * 100).roundToDouble();
  double neutrality =
      (double.parse(sentiment.neutrality.replaceAll('%', '')) * 100)
          .roundToDouble();
  double sadness = (double.parse(sentiment.sadness.replaceAll('%', '')) * 100)
      .roundToDouble();
  double anger =
      (double.parse(sentiment.anger.replaceAll('%', '')) * 100).roundToDouble();
  double anxiety = (double.parse(sentiment.anxiety.replaceAll('%', '')) * 100)
      .roundToDouble();
  double tiredness =
      (double.parse(sentiment.tiredness.replaceAll('%', '')) * 100)
          .roundToDouble();
  double regret = (double.parse(sentiment.regret.replaceAll('%', '')) * 100)
      .roundToDouble();

  final List<VBarChartModel> bardata = [
    VBarChartModel(
      index: 0,
      label: "JOY!",
      colors: [
        const Color.fromARGB(255, 125, 201, 255),
        const Color.fromARGB(255, 125, 201, 255)
      ],
      jumlah: joy,
      tooltip: "$joy%",
    ),
    VBarChartModel(
      index: 1,
      label: "HOPE!",
      colors: [
        const Color.fromARGB(255, 255, 130, 141),
        const Color.fromARGB(255, 255, 130, 141)
      ],
      jumlah: hope,
      tooltip: "$hope%",
    ),
    VBarChartModel(
      index: 2,
      label: "NEUTRALITY!",
      colors: [
        const Color.fromARGB(255, 217, 255, 113),
        const Color.fromARGB(255, 217, 255, 113)
      ],
      jumlah: neutrality,
      tooltip: "$neutrality%",
    ),
    VBarChartModel(
      index: 3,
      label: "SADNESS!",
      colors: [
        const Color.fromARGB(255, 255, 136, 1),
        const Color.fromARGB(255, 255, 136, 1),
      ],
      jumlah: sadness,
      tooltip: "$sadness%",
    ),
    VBarChartModel(
      index: 4,
      label: "ANGER!",
      colors: [
        const Color.fromRGBO(0, 255, 123, 1),
        const Color.fromRGBO(0, 255, 123, 1),
      ],
      jumlah: anger,
      tooltip: "$anger%",
    ),
    VBarChartModel(
      index: 5,
      label: "ANXIETY!",
      colors: [
        const Color.fromRGBO(255, 0, 140, 1),
        const Color.fromRGBO(255, 0, 140, 1),
      ],
      jumlah: anxiety,
      tooltip: "$anxiety%",
    ),
    VBarChartModel(
      index: 6,
      label: "TIREDNESS!",
      colors: [
        const Color.fromRGBO(21, 6, 122, 1),
        const Color.fromRGBO(21, 6, 122, 1),
      ],
      jumlah: tiredness,
      tooltip: "$tiredness%",
    ),
    VBarChartModel(
      index: 7,
      label: "REGRET!",
      colors: [
        const Color.fromRGBO(58, 135, 14, 1),
        const Color.fromRGBO(58, 135, 14, 1),
      ],
      jumlah: regret,
      tooltip: "$regret%",
    ),
  ];

  return const SfCartesianChart(
    primaryXAxis: CategoryAxis(),
    primaryYAxis: NumericAxis(
      minimum: 0,
      maximum: 100,
      interval: 25,
    ),
  );
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
