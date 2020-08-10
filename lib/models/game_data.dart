import 'package:flutter/material.dart';

class GameData extends ChangeNotifier{
  int round = 4;
  int time = 30;
  int pass = 3;

  List<Color> teamColors = [Colors.orange[300], Colors.grey, Colors.yellow[900], Colors.indigo];
  List<IconData> teamIcons = [Icons.offline_bolt, Icons.whatshot, Icons.toys, Icons.airplanemode_active, Icons.audiotrack];
  Color team1Color = Colors.red;
  Color team2Color = Colors.green;
  IconData team1Icon = Icons.ac_unit;
  IconData team2Icon = Icons.cloud;
  String team1Name = '1. TAKIM';
  String team2Name = '2. TAKIM';
  int team1Correct = 0;
  int team2Correct = 0;
  int team1Tabu = 0;
  int team2Tabu = 0;

  Color changeColor(Color color) {
    Color newColor = teamColors.first;
    teamColors.removeAt(0);
    teamColors.add(color);
    return newColor;
  }

  void changeTeam1Color() {
    team1Color = changeColor(team1Color);
    notifyListeners();
  }

  void changeTeam2Color() {
    team2Color = changeColor(team2Color);
    notifyListeners();
  }

  IconData changeIcon(IconData icon) {
    IconData newIcon = teamIcons.first;
    teamIcons.removeAt(0);
    teamIcons.add(icon);
    return newIcon;
  }

  void changeTeam1Icon() {
    team1Icon = changeIcon(team1Icon);
    notifyListeners();
  }

  void changeTeam2Icon() {
    team2Icon = changeIcon(team2Icon);
    notifyListeners();
  }
}