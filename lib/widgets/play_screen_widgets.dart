import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/team_data.dart';
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
  TeamModel currentTeam,
  TeamModel team,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: kSliderActiveColor,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xFFfce2ce),
                        width: 4.0
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    color: kSliderActiveColor,
                  ),
                  child: Text(
                          '${team.teamName}\n' +
                          '$round' +
                          '. raundu bitirdi.\n' +
                          'Sıradaki takım:',
                      textAlign: TextAlign.center,
                      style: kSettingsTextStyle.copyWith(fontSize: 24, backgroundColor: kSliderActiveColor)),
                ),
              ),
            ),
            TeamInGameCard(
              team: currentTeam,
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

class TeamInGameCard extends StatelessWidget {
final TeamModel team;
final TextStyle textStyle;
final EdgeInsets margin;

TeamInGameCard(
    {this.team, this.margin, this.textStyle});

@override
Widget build(BuildContext context) {
  return Card(
    margin: margin == null
        ? EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
        : margin,
    color: team.teamColor,
    elevation: 8.0,
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      leading: Icon(
        team.teamIcon,
        size: 50.0,
      ),
      title: Text(
        team.teamName,
        overflow: TextOverflow.visible,
        softWrap: false,
        textAlign: TextAlign.left,
        style: textStyle == null
            ? kTeamTextStyle.copyWith(fontSize: 35.0)
            : textStyle,
      ),
    ),
  );
}
}
