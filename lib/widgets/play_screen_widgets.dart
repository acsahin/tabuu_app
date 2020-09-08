import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'package:tabuu_app/screens/play_screen.dart';
import 'package:tabuu_app/widgets/main_screen_widgets.dart';

class ResultButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final String text;
  final IconData icon;
  final Color color;
  final Function onTap;

  ResultButton({this.borderRadius, this.icon, this.text, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      color: color,
      onPressed: onTap,
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 40.0,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}

void showMyDialog({
  Function onTap,
  BuildContext context,
  TeamNumber currentTeam,
  TeamData teamData,
  int round,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryBackgroundColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 180.0, horizontal: 30.0),
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Material(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: kSliderActiveColor,
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(5.0),
                child: Text(
                    currentTeam == TeamNumber.team1
                        ? '${teamData.team2Name}\n' +
                        '$round' +
                        '. raundu bitirdi.\n' +
                        'Sıradaki takım:'
                        : '${teamData.team1Name}\n' +
                            '$round' +
                            '. raundu bitirdi.\n' +
                            'Sıradaki takım:',
                    textAlign: TextAlign.center,
                    style: kSettingsTextStyle.copyWith(fontSize: 24, backgroundColor: kSliderActiveColor)),
              ),
            ),
            TeamInGameCard(
              currentTeam: currentTeam,
              teamData: teamData,
              textStyle: kTeamLowerTextStyle,
              margin: EdgeInsets.all(20.0),
            ),
            MainScreenButton(
              title: 'HAZIR',
              onTap: onTap,
            ),
          ],
        ),
      ),
    ),
  );
}
