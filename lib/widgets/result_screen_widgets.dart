import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'package:tabuu_app/widgets/play_screen_widgets.dart';
import '../constants.dart';

class TheWinner extends StatelessWidget {
  const TheWinner({
    Key key,
    @required this.winner,
    @required this.loser,
  }) : super(key: key);

  final TeamModel winner;
  final TeamModel loser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TeamResult(
          team: winner,
          icon: Icons.grade,
          iconColor: Colors.yellow[700],
          backgroundColor: Color(0xFF87556f),
        ),
        TeamResult(
          team: loser,
          icon: Icons.close,
          iconColor: Colors.red[700],
          backgroundColor: Color(0xFF4B5D67),
        ),
      ],
    );
  }
}

class TeamResult extends StatelessWidget {
  const TeamResult({
    Key key,
    @required this.team,
    @required this.icon,
    @required this.iconColor,
    @required this.backgroundColor,
  }) : super(key: key);

  final TeamModel team;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: backgroundColor,
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
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 70.0,
                    ),
                  ),
                  Expanded(
                    child: TeamInGameCard(
                      team: team,
                      textStyle: kTeamTextStyle,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Text(
                  '${team.point} PUAN',
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
    );
  }
}
