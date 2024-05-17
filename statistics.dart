import 'package:capstones/widgets/phq9test.dart';
import 'package:capstones/widgets/top3_emotion.dart';
import 'package:capstones/widgets/tot_emotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Statistics extends StatefulWidget {
  final String memberId;
  const Statistics({super.key, required this.memberId});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late String memberId;

  @override
  void initState() {
    super.initState();
    memberId = widget.memberId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('통계'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 4,
                mainAxisCellCount: 2,
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: TotalEmotion(memberId: memberId)),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PHQ9()),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const Text('우울체크'),
                  ),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: const Text('우울체크 트래킹\n이전 검사결과\n이번 검사결과'),
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 4,
                mainAxisCellCount: 2,
                child: Top3Emotion(memberId: memberId),
              ),
            ],
          ),
        ));
  }
}
