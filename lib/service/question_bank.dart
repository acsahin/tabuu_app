import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';

class QuestionBank {
  List<dynamic> questionList;
  List<Widget> currentQuestion;

  QuestionBank({this.questionList});

  void getQuestion() {
    Random random = Random();
    int a = random.nextInt(questionList.length);
    currentQuestion =  [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          questionList[a]['title'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32, color: Color(0xFFfce2ce), fontWeight: FontWeight.bold),
        ),
      ),
      Divider(
        thickness: 4.0,
        color: Color(0xFFfce2ce),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          questionList[a]['tabu1'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          questionList[a]['tabu2'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          questionList[a]['tabu3'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          questionList[a]['tabu4'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
        child: Text(
          questionList[a]['tabu5'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    ];
    questionList.removeAt(a);
    // print(currentQuestion);
  }
}
