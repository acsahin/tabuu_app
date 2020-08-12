import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/game_data.dart';
import 'package:provider/provider.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'package:tabuu_app/screens/play_screen.dart';

class MainScreenButton extends StatelessWidget {
  final Function onTap;
  final String title;

  MainScreenButton({this.onTap, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      child: RaisedButton(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: title == 'BAŞLAT'
            ? () {
                GameData gD = Provider.of<GameData>(context, listen: false);
                TeamData tD = Provider.of<TeamData>(context, listen: false);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayScreen(
                        gameData: gD,
                        teamData: tD,
                      ),
                    ));
              }
            : onTap,
        color: kMainButtonColor,
        padding: EdgeInsets.all(20.0),
        child: Text(title),
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final TeamNumber selectedTeam;
  TeamCard({this.selectedTeam});

  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (detail) {
        selectedTeam == TeamNumber.team1
            ? Provider.of<TeamData>(context, listen: false)
                .changeTeam1Color()
            : Provider.of<TeamData>(context, listen: false)
                .changeTeam2Color();
      },
      onTap: () {
        selectedTeam == TeamNumber.team1
            ? Provider.of<TeamData>(context, listen: false)
            .changeTeam1Icon()
            : Provider.of<TeamData>(context, listen: false)
            .changeTeam2Icon();
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
        color: selectedTeam == TeamNumber.team1
            ? Provider.of<TeamData>(context).team1Color
            : Provider.of<TeamData>(context).team2Color,
        elevation: 8.0,
        child: ListTile(
          leading: Icon(
            selectedTeam == TeamNumber.team1
                ? Provider.of<TeamData>(context).team1Icon
                : Provider.of<TeamData>(context).team2Icon,
            size: 50.0,
          ),
          title: TextField(
            decoration: InputDecoration(
              hintText:
                  selectedTeam == TeamNumber.team1 ? '1. Takım' : '2. Takım',
              border: InputBorder.none,
            ),
            onChanged: (newName) {
              selectedTeam == TeamNumber.team1
                  ? Provider.of<TeamData>(context, listen: false).team1Name = newName.toString()
                  : Provider.of<TeamData>(context, listen: false).team2Name = newName.toString();
            },
            cursorColor: Colors.white,
            textCapitalization: TextCapitalization.characters,
            style: kTeamTextStyle,
          ),
        ),
      ),
    );
  }
}

class SettingsCard extends StatefulWidget {
  final int divisions;
  final String title;
  final double min;
  final double max;
  final double value;

  SettingsCard({this.divisions, this.title, this.min, this.max, this.value});

  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColor,
      margin: EdgeInsets.all(3.0),
      elevation: 0.0,
      child: Column(
        children: <Widget>[
          Slider(
            activeColor: kSliderActiveColor,
            inactiveColor: kPrimaryBackgroundColor,
            min: widget.min,
            max: widget.max,
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
                if (widget.title == 'saniye') {
                  Provider.of<GameData>(context, listen: false).time =
                      _value.toInt();
                  print(Provider.of<GameData>(context, listen: false).time);
                } else if (widget.title == 'raund') {
                  Provider.of<GameData>(context, listen: false).round =
                      _value.toInt();
                  print(Provider.of<GameData>(context, listen: false).round);
                } else if (widget.title == 'pas') {
                  Provider.of<GameData>(context, listen: false).pass =
                      _value.toInt();
                  print(Provider.of<GameData>(context, listen: false).pass);
                }
              });
            },
            divisions: widget.divisions,
          ),
          Text('${_value.toInt()} ${widget.title}', style: kSettingsTextStyle),
          SizedBox(
            height: 6.0,
          ),
        ],
      ),
    );
  }
}
