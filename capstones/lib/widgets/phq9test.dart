import 'package:flutter/material.dart';

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
  Map<int, TableColumnWidth> columwidth = {
    0: const FlexColumnWidth(3),
    1: const FlexColumnWidth(0.5),
    2: const FlexColumnWidth(0.5),
    3: const FlexColumnWidth(0.5),
    4: const FlexColumnWidth(0.5),
  };
  // 각 셀의 데이터를 저장할 변수들

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
                columnWidths: columwidth,
                children: [
                  //headline
                  const TableRow(
                    children: [
                      TableCell(child: Center(child: Text('문        항'))),
                      TableCell(child: Center(child: Text('없음'))),
                      TableCell(child: Center(child: Text('2~6일'))),
                      TableCell(child: Center(child: Text('7~12일'))),
                      TableCell(child: Center(child: Text('거의매일'))),
                    ],
                  ),
                  //1번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(
                              child: Text(
                        '기분이 가라앉거나, 우울하거나,\n 희망이 없다고 느꼈다.',
                        style: TextStyle(),
                      ))),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //2번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(
                              child: Text(
                                  '평소 하던 일에 대한 흥미가 \n없어지거나 즐거움을 느끼지 못했다.'))),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //3번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(
                              child:
                                  Text('잠들기가 어렵거나 자주 깼다. /\n 혹은 너무 많이 잤다.'))),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //4번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(
                              child:
                                  Text('평소보다 식욕이 줄었다. /\n 혹은 평소보다 많이 먹었다.'))),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //5번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(
                              child: Text(
                                  '다른 사람들이 눈치 챌 정도로 평소보다 말과 행동이 느려졌다. /\n 혹은 너무 안절부절 못해서 가만히 앉아있을 수 없었다.'))),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //6번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(child: Text('피곤하고 기운이 없었다.'))),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //7번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(
                              child: Text(
                                  '내가 잘못했거나, 실패했다는 생각이 들었다. /\n 혹은 자신과 가족을 실망시켰다고 생각했다.'))),
                      TableCell(
                        child: Checkbox(
                          activeColor: Colors.blueGrey,
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //8번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(
                              child: Text(
                                  '신문을 읽거나 TV를 보는 것과 같은 일상적인 일에도 집중할 수가 없었다.'))),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //9번
                  TableRow(
                    children: [
                      const TableCell(
                          child: Center(
                              child: Text(
                                  '차라리 죽는 것은 더 낫겠다고 생각했다. /\n 혹은 자해할 생각을 했다.'))),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Checkbox(
                          value: false,
                          onChanged: (value) => setState(
                            () {
                              score = score + 1;
                              value = true;
                            },
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 2;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (value) => setState(
                              () {
                                score = score + 3;
                                value = true;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //  - 0~4점 : 우울 아님

              //  - 5~9점 : 가벼운 우울

              //  - 10~19점 : 중간 정도의 우울

              //  - 20~27점 : 심한 우울

              IconButton(
                  onPressed: () {
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
                  icon: const Icon(Icons.check)),
            ],
          ),
        ),
      ),
    );
  }
}
