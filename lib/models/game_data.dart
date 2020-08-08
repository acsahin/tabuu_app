import 'package:flutter/material.dart';
import 'package:tabuu_app/models/team_data.dart';

class GameData extends ChangeNotifier{
  TeamData teamData;
  int round = 4;
  int time = 30;
  int pass = 3;

  GameData(this.teamData);
}