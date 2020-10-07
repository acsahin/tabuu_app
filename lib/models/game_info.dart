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

  Widget theWinner() {
    if (winner == null) {
      return Container(
        color: kPrimaryBackgroundColor,
        child: Text("BERABERE"),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color(0xFF87556f),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.grade,
                            color: Colors.yellow[700],
                            size: 90.0,
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: winner == TeamNumber.team1
                                  ? team1Color
                                  : team2Color,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    winner == TeamNumber.team1
                                        ? team1Icon
                                        : team2Icon,
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    winner == TeamNumber.team1
                                        ? team1Name
                                        : team2Name,
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Text(winner == TeamNumber.team1 ? '$team1Point PUAN' : '$team2Point PUAN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFF4B5D67),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 90.0,
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: winner == TeamNumber.team1
                                  ? team2Color
                                  : team1Color,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    winner == TeamNumber.team1
                                        ? team2Icon
                                        : team1Icon,
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    winner == TeamNumber.team1
                                        ? team2Name
                                        : team1Name,
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Text(winner == TeamNumber.team1 ? '$team2Point PUAN' : '$team1Point PUAN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
