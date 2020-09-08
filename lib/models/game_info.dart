import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';

class GameInfo {
  int team1Correct = 0;
  int team2Correct = 0;
  int team1Pass = 0;
  int team2Pass = 0;
  int team1Tabu = 0;
  int team2Tabu = 0;
  int roundNumber = 1;
  Color team1Color;
  Color team2Color;
  IconData team1Icon;
  IconData team2Icon;
  String team1Name;
  String team2Name;
  int team1Point;
  int team2Point;
  TeamNumber winner;

  GameInfo(
      {this.team1Color,
      this.team2Color,
      this.team1Icon,
      this.team2Icon,
      this.team1Name,
      this.team2Name});

  void pass(TeamNumber teamNumber) {
    teamNumber == TeamNumber.team1 ? team1Pass++ : team2Pass++;
  }

  void tabu(TeamNumber teamNumber) {
    teamNumber == TeamNumber.team1 ? team1Tabu++ : team2Tabu++;
  }

  void correct(TeamNumber teamNumber) {
    teamNumber == TeamNumber.team1 ? team1Correct++ : team2Correct++;
  }

  void restart() {
    team1Pass = 0;
    team2Pass = 0;
  }

  void gameFinished() {
    team1Point = calculator(team1Correct, team1Tabu);
    team2Point = calculator(team2Correct, team1Tabu);
    if (team1Point > team2Point) {
      winner = TeamNumber.team1;
    } else if (team1Point < team2Point) {
      winner = TeamNumber.team2;
    } else {
      winner = null;
    }
  }

  int calculator(int correct, int tabu) {
    return correct - (tabu * 2);
  }

  List<Widget> theWinner() {
    if (winner == null) {
      return <Widget>[
        Text(
          "BERABERE",
          style: TextStyle(fontSize: 30, color: Colors.white),
        )
      ];
    } else {
      return <Widget>[
        Text(
          "KAZANAN",
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
          color: winner == TeamNumber.team1 ? team1Color : team2Color,
          elevation: 8.0,
          child: ListTile(
            leading: Icon(
              winner == TeamNumber.team1 ? team1Icon : team2Icon,
              size: 60.0,
            ),
            title: Text(
              winner == TeamNumber.team1 ? team1Name : team2Name,
              style: TextStyle(fontSize: 35.0),
            ),
          ),
        ),
        Text(
          "${winner == TeamNumber.team1 ? team1Point : team2Point} PUAN",
          style: kTeamTextStyle,
        ),
        SizedBox(
          height: 250.0,
        ),
        Text("Kaybeden Takım"),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          color: winner == TeamNumber.team1 ? team2Color : team1Color,
          elevation: 6.0,
          child: ListTile(
            leading: Icon(
              winner == TeamNumber.team1 ? team2Icon : team1Icon,
              size: 35.0,
            ),
            title: Text(
              winner == TeamNumber.team1 ? team2Name : team1Name,
              style: kTeamLowerTextStyle,
            ),
          ),
        ),
        Text(
          "${winner == TeamNumber.team1 ? team2Point : team1Point} PUAN",
          style: kTeamLowerTextStyle,
        ),
      ];
    }
  }
}
