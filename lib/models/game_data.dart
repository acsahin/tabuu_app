import 'package:flutter/material.dart';

class GameData extends ChangeNotifier{
  double round = 4;
  double time = 60;
  double pass = 3;

  void changeRound(double newValue) {
    round = newValue;
  }
  void changeTime(double newValue) {
    time = newValue;
  }
  void changePass(double newValue) {
    pass = newValue;
  }
}