import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:url_launcher/url_launcher_string.dart';

// enum DataKind { NONE, JOY, HOPE, NEUTRALITY, SADNESS, ANGER, ANXIETY, TIREDNESS, REGRET }
enum DataKind { OK }

enum Kind { NONE, EMPATHY, OVERCOME }

Future<String?> fetchString(DataKind dataKind, String emotion) async {
  final http.Response response = await http.post(
      Uri.parse('http://10.0.2.2:5001/music/recommendation'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'emotion': emotion}));
  if (response.statusCode == 200) {
    print('감정 전송 성공: ${response.body}');
  } else {
    print('감정 전송 실패: ${response.statusCode}');
  }

  return response.body;
}

class Extant extends StatefulWidget {
  final String selectedEmotion;

  const Extant({super.key, required this.selectedEmotion});

  @override
  _ExtantState createState() => _ExtantState();
}

class _ExtantState extends State<Extant> {
  String _selectedCategory = '';
  final String musicRecommendationUrl =
      'https://youtu.be/XEfle_XvYiw?si=sS2MryzR7k2d6z3w';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print('Selected Emotion: ${widget.selectedEmotion}');
  }

  Kind mKind = Kind.NONE;
  DataKind nKind = DataKind.OK;

  Widget makeChild(String str, Kind kind) {
    Map<String, dynamic> items = jsonDecode(str);
    // print(items);

    switch (kind) {
      case Kind.NONE:
        return const Placeholder();

      case Kind.EMPATHY:
        List<Widget> widgetList = [];
        for (int i = 0; i < 5; i++) {
          final musicName = items['empathy'][i]['name'];
          final musicArtist = items['empathy'][i]['artist'];

          widgetList.add(Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(items['empathy'][i]['image']),
                const SizedBox(height: 20),
                const SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    //_launchURL(musicRecommendationUrl);
                  },
                  child: Container(
                    width: 200,
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          musicName,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 89, 130),
                          ),
                        ),
                        Text(
                          musicArtist,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 145, 211),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]));
        }
        return Column(children: widgetList);

      case Kind.OVERCOME:
        List<Widget> widgetList = [];
        for (int i = 0; i < 5; i++) {
          final musicName = items['overcome'][i]['name'];
          final musicArtist = items['overcome'][i]['artist'];

          widgetList.add(Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(items['overcome'][i]['image']),
                const SizedBox(height: 20),
                const SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    // _launchURL(musicRecommendationUrl);
                  },
                  child: Container(
                    width: 200,
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          musicName,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 89, 130),
                          ),
                        ),
                        Text(
                          musicArtist,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 145, 211),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]));
        }
        return Column(children: widgetList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  width: 120,
                  child: Image.asset(
                    'lib/assets/images/${widget.selectedEmotion}.png',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '"${widget.selectedEmotion}"에 어울리는 음악',
                  style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'single_day',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = 'empathy';
                          mKind = Kind.EMPATHY;
                        });
                      },
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: _selectedCategory == 'empathy'
                              ? Colors.grey
                              : Colors.transparent,
                        ),
                        child: const Text(
                          'Empathy',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'single_day',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = 'overcome';
                          mKind = Kind.OVERCOME;
                        });
                      },
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: _selectedCategory == 'overcome'
                              ? Colors.grey
                              : Colors.transparent,
                        ),
                        child: const Text(
                          'Overcome',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'single_day',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      child: Column(children: [
                        FutureBuilder(
                          future: fetchString(nKind, widget.selectedEmotion),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Center(
                                child:
                                    makeChild(snapshot.data.toString(), mKind),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MusicRecommendationItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;
  final String url;

  const MusicRecommendationItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 55),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'single_day',
                  color: Colors.black,
                ),
              ),
              Text(
                artist,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'single_day',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw '오류입니다. $url';
    }
  }
}
