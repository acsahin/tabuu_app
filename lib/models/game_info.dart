import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'package:tabuu_app/widgets/result_screen_widgets.dart';

class GameInfo {
  int roundNumber = 1;
  TeamNumber winner;

  TeamModel team1 = TeamModel();
  TeamModel team2 = TeamModel();

  GameInfo({this.team1, this.team2});

  void pass(TeamNumber teamNumber) {
    teamNumber == TeamNumber.team1 ? team1.pass++ : team2.pass++;
  }

  void tabu(TeamNumber teamNumber) {
    teamNumber == TeamNumber.team1 ? team1.tabu++ : team2.tabu++;
  }

  void correct(TeamNumber teamNumber) {
    teamNumber == TeamNumber.team1 ? team1.correct++ : team2.correct++;
  }

  void restart() {
    team1.pass = 0;
    team2.pass = 0;
  }

  void gameFinished() {
    team1.point = calculator(team1.correct, team1.tabu);
    team2.point = calculator(team2.correct, team1.tabu);
    if (team1.point > team2.point) {
      winner = TeamNumber.team1;
    } else if (team1.point < team2.point) {
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
    }else if(winner == TeamNumber.team1) {
      return TheWinner(winner: team1, loser: team2);
    }else {
      return TheWinner(winner: team2, loser: team1);
    }
  }
}