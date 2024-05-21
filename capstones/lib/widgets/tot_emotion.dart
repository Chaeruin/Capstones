import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/statistics_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  double joy = (double.parse(sentiment.joy.replaceAll('%', '')));
  double hope = (double.parse(sentiment.hope.replaceAll('%', '')));
  double neutrality = (double.parse(sentiment.neutrality.replaceAll('%', '')));
  double sadness = (double.parse(sentiment.sadness.replaceAll('%', '')));
  double anger = (double.parse(sentiment.anger.replaceAll('%', '')));
  double anxiety = (double.parse(sentiment.anxiety.replaceAll('%', '')));
  double tiredness = (double.parse(sentiment.tiredness.replaceAll('%', '')));
  double regret = (double.parse(sentiment.regret.replaceAll('%', '')));

  final List chartData = [
    _ChartData('joy', joy),
    _ChartData('hope', hope),
    _ChartData('neutrality', neutrality),
    _ChartData('sadness', sadness),
    _ChartData('anger', anger),
    _ChartData('anxiety', anxiety),
    _ChartData('tiredness', tiredness),
    _ChartData('regret', regret),
  ];

  return SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        labelStyle: TextStyle(fontSize: 8),
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 50,
        interval: 25,
      ),
      series: [
        ColumnSeries(
          dataSource: chartData,
          xValueMapper: (chartData, _) => chartData.x,
          yValueMapper: (chartData, _) => chartData.y,
        )
      ]);
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
