import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PHQ9 extends StatefulWidget {
  const PHQ9({super.key});

  @override
  State<PHQ9> createState() => _PHQ9State();
}

class _PHQ9State extends State<PHQ9> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '우울증 건강설문(PHQ-9)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TableForm(),
    );
  }
}

class TableForm extends StatefulWidget {
  const TableForm({super.key});

  @override
  _TableFormState createState() => _TableFormState();
}

class _TableFormState extends State<TableForm> {
  int score = 0;
  SharedPreferences? prefs;
  List<String> testScore = [];

  final List<int> _selectedValues = List.filled(9, 0);

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final testScoreList = prefs!.getStringList('testScore');

    if (testScoreList == null) {
      await prefs!.setStringList('testScore', []);
    } else if (testScoreList.length == 2) {
      testScoreList[0] = testScoreList[1];
      testScore = testScoreList;
    } else {
      testScore = testScoreList;
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _updateTestScore(String score) async {
    testScore.add(score);
    await prefs!.setStringList('testScore', testScore);
    setState(() {});
  }

  void _onCheckboxChanged(int questionIndex, int value) {
    setState(() {
      _selectedValues[questionIndex] = value;
      score = _selectedValues.reduce((a, b) => a + b);
    });
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PHQ-9'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(0.5),
                  2: FlexColumnWidth(0.5),
                  3: FlexColumnWidth(0.5),
                  4: FlexColumnWidth(0.5),
                },
                children: [
                  // Headline
                  const TableRow(
                    children: [
                      TableCell(child: Center(child: Text('문        항'))),
                      TableCell(child: Center(child: Text('없음'))),
                      TableCell(child: Center(child: Text('2~6일'))),
                      TableCell(child: Center(child: Text('7~12일'))),
                      TableCell(child: Center(child: Text('거의매일'))),
                    ],
                  ),
                  // Questions
                  _buildTableRow(
                    questionIndex: 0,
                    questionText: '기분이 가라앉거나, 우울하거나,\n 희망이 없다고 느꼈다.',
                  ),
                  _buildTableRow(
                    questionIndex: 1,
                    questionText: '평소 하던 일에 대한 흥미가 \n없어지거나 즐거움을 느끼지 못했다.',
                  ),
                  _buildTableRow(
                    questionIndex: 2,
                    questionText: '잠들기가 어렵거나 자주 깼다. /\n 혹은 너무 많이 잤다.',
                  ),
                  _buildTableRow(
                    questionIndex: 3,
                    questionText: '평소보다 식욕이 줄었다. /\n 혹은 평소보다 많이 먹었다.',
                  ),
                  _buildTableRow(
                    questionIndex: 4,
                    questionText:
                        '다른 사람들이 눈치 챌 정도로 평소보다 말과 행동이 느려졌다. /\n 혹은 너무 안절부절 못해서 가만히 앉아있을 수 없었다.',
                  ),
                  _buildTableRow(
                    questionIndex: 5,
                    questionText: '피곤하고 기운이 없었다.',
                  ),
                  _buildTableRow(
                    questionIndex: 6,
                    questionText:
                        '내가 잘못했거나, 실패했다는 생각이 들었다. /\n 혹은 자신과 가족을 실망시켰다고 생각했다.',
                  ),
                  _buildTableRow(
                    questionIndex: 7,
                    questionText: '신문을 읽거나 TV를 보는 것과 같은 일상적인 일에도 집중할 수가 없었다.',
                  ),
                  _buildTableRow(
                    questionIndex: 8,
                    questionText: '차라리 죽는 것은 더 낫겠다고 생각했다. /\n 혹은 자해할 생각을 했다.',
                  ),
                ],
              ),
              // Score and Result
              IconButton(
                onPressed: () {
                  _updateTestScore(score.toString());
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text('검사결과'),
                        children: [
                          Text('총 $score점 입니다'),
                          if (score <= 4)
                            const Text('우울 아님')
                          else if (score > 4 && score <= 9)
                            const Text('가벼운 우울')
                          else if (score > 9 && score <= 19)
                            const Text('중간 정도의 우울')
                          else
                            const Text('심한 우울')
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow({
    required int questionIndex,
    required String questionText,
  }) {
    return TableRow(
      children: [
        TableCell(
          child: Center(
            child: Text(
              questionText,
              style: const TextStyle(),
            ),
          ),
        ),
        _buildCheckboxCell(questionIndex, 0),
        _buildCheckboxCell(questionIndex, 1),
        _buildCheckboxCell(questionIndex, 2),
        _buildCheckboxCell(questionIndex, 3),
      ],
    );
  }

  TableCell _buildCheckboxCell(int questionIndex, int value) {
    return TableCell(
      child: Checkbox(
        value: _selectedValues[questionIndex] == value,
        onChanged: (isSelected) {
          if (isSelected != null && isSelected) {
            _onCheckboxChanged(questionIndex, value);
          }
        },
      ),
    );
  }
}