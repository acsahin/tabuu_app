import 'package:flutter/material.dart';

class TeamData extends ChangeNotifier{
  List<Color> teamColors = [Colors.orange, Colors.grey, Colors.yellow, Colors.indigo];
  Color team1Color = Colors.red;
  Color team2Color = Colors.green;

//  Color changeColor(Color color) {
//    Color newColor = teamColors.first;
//    teamColors.removeAt(0);
//    teamColors.add(color);
//    return newColor;
//  }

  void changeTeam1Color() {
    teamColors.add(team1Color);
    team1Color = teamColors.first;
    teamColors.removeAt(0);
    print('new color ${team1Color}');
    notifyListeners();
  }

  void changeTeam2Color() {
    teamColors.add(team2Color);
    team2Color = teamColors.first;
    teamColors.removeAt(0);
    notifyListeners();
  }
}