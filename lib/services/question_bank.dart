import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';

class QuestionBank {
  List<dynamic> questionList;
  List usedList;
  List<Widget> currentQuestion;

  QuestionBank({this.questionList});

  void remake() {
    usedList = List.from(questionList);
  }

  void getQuestion() {
    if(usedList.length == 0) {
      remake();
    }
    Random random = Random();
    int a = random.nextInt(usedList.length);
    currentQuestion =  [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          usedList[a]['title'],
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
          usedList[a]['tabu1'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          usedList[a]['tabu2'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          usedList[a]['tabu3'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          usedList[a]['tabu4'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
        child: Text(
          usedList[a]['tabu5'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    ];
    usedList.removeAt(a);
    // print(currentQuestion);
  }
}
