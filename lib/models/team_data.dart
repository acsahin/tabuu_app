import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';

class TeamData extends ChangeNotifier{
  TeamModel team1 = TeamModel(teamColor: Colors.red, teamIcon: Icons.ac_unit, teamName: '1. TAKIM');
  TeamModel team2 = TeamModel(teamColor: Colors.green, teamIcon: Icons.cloud, teamName: '2. TAKIM');
}

class TeamModel{
  Color teamColor;
  IconData teamIcon;
  String teamName;
  int correct = 0;
  int pass = 0;
  int tabu = 0;
  int point;

  TeamModel({this.teamColor, this.teamIcon, this.teamName});

  void changeColor() {
    Color newColor = teamColors.first;
    teamColors.removeAt(0);
    teamColors.add(teamColor);
    teamColor = newColor;
  }

  void changeIcon() {
    IconData newIcon = teamIcons.first;
    teamIcons.removeAt(0);
    teamIcons.add(teamIcon);
    teamIcon = newIcon;
  }

}