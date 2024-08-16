import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:jolie/constant/color.dart';
import 'package:jolie/constant/typography.dart';
import 'package:jolie/screens/Home/statistic_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Map<String, String> emoji = {
    "hello": "👋🏽",
    "busy": "😤",
    "working": "💆🏽",
    "available": "🤫",
  };

  final List<String> women = [
    "🧒🏽",
    "👧🏽",
    "👩🏽‍🦱",
    "👩🏽‍🦳",
    "👩🏽‍🦰",
    "🧕🏽",
    "👸🏽"
  ];

  // final List<String> men = ["🧔🏽","👨🏽","👦🏽","👱🏽‍♂️","👨🏽‍🦱","👨🏽‍🦳","👨🏽‍🦰"];

  String getRandomWomen() {
    return women[Random().nextInt(women.length)];
  }

  // get current date in dd/mm format
  var currentDate = DateFormat('EEEE, d MMM').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    getRandomWomen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox.fromSize(size: const Size.fromHeight(100.0)),
            Text(
              '${emoji["hello"]}, Julie',
              style: Fonts.medium.copyWith(
                color: secondaryColor,
                fontSize: 40,
              ),
            ),
            SizedBox.fromSize(size: const Size.fromHeight(5.0)),
            Text(
              currentDate,
              style: Fonts.thin.copyWith(
                color: secondaryColor,
                fontSize: 20.0,
              ),
            ),
            SizedBox.fromSize(size: const Size.fromHeight(20.0)),
            StatisticCard(status: '${emoji["available"]}', ),

          ],
        ),
      ),
    );
  }
}
