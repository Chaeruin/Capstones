import 'package:capstones/api_services/db_connect.dart';
import 'package:capstones/models/statistics_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Top3Emotion extends StatefulWidget {
  final String memberId;
  const Top3Emotion({super.key, required this.memberId});

  @override
  State<Top3Emotion> createState() => _Top3EmotionState();
}

class _Top3EmotionState extends State<Top3Emotion> {
  String writeDate = DateFormat('yyyyMMdd').format(DateTime.now()).toString();
  late String memberId;
  late Future<List<Top3Emotions>> top3;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    memberId = widget.memberId;
    top3 = top3Emotions(memberId, writeDate);
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onRefresh() async {
    // Fetch new data
    setState(() {
      top3 = top3Emotions(memberId, writeDate);
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
      child: Column(
        children: [
          Row(
            children: [
              Title(
                color: Colors.black,
                child: const Text('많이 기록한 감정'),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text('몇월?'),
            ],
          ),
          FutureBuilder(
            future: top3,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: makeList(snapshot),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}

ListView makeList(AsyncSnapshot<List<Top3Emotions>> snapshot) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    padding: const EdgeInsets.all(8),
    itemBuilder: (context, index) {
      var rank = snapshot.data![index];
      return Top3(
        emotionType: rank.emotionType,
        count: rank.count,
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: 30,
    ),
  );
}

class Top3 extends StatelessWidget {
  final String emotionType;
  final int count;
  const Top3({
    super.key,
    required this.emotionType,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/assets/images/$emotionType.png',
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
