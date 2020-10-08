import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/game_data.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'package:tabuu_app/screens/play_screen.dart';

class MainScreenButton extends StatelessWidget {
  final Function onTap;
  final String title;
  final GameData gameData;
  final TeamData teamData;

  MainScreenButton({this.onTap, @required this.title, this.teamData, this.gameData});

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
            ? () async {
                String data = await rootBundle.loadString('images/questions.json');
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayScreen(
                        gameData: gameData,
                        teamData: teamData,
                        questionData: data,

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

class TeamCard extends StatefulWidget {
  final TeamNumber selectedTeam;
  final TeamModel teamModel;
  TeamCard({this.selectedTeam, this.teamModel});

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (detail) {
        setState(() {
          widget.teamModel.changeColor();
        });
      },
      onTap: () {
        setState(() {
          widget.teamModel.changeIcon();
        });
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
        color: widget.teamModel.teamColor,
        elevation: 8.0,
        child: ListTile(
          leading: Icon(
            widget.teamModel.teamIcon,
            size: 50.0,
          ),
          title: TextField(
            decoration: InputDecoration(
              hintText:
                  widget.selectedTeam == TeamNumber.team1 ? '1. Takım' : '2. Takım',
              border: InputBorder.none,
            ),
            onChanged: (newName) {
              widget.teamModel.teamName = newName.toString();
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
  final String title;
  final GameData gameData;

  SettingsCard({this.title, this.gameData});

  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  double _min;
  double _max;
  double _value;
  int _divisions;

  @override
  void initState() {
    super.initState();
    configure();
  }

  void configure() {
    if(widget.title == 'saniye') {
      _min = 30.0;
      _max = 180.0;
      _divisions = 160;
      _value = widget.gameData.time;
    }else if(widget.title == 'raund') {
      _min = 2.0;
      _max = 10.0;
      _divisions = 8;
      _value = widget.gameData.round;
    }else if(widget.title == 'pas') {
      _min = 0.0;
      _max = 10.0;
      _divisions = 10;
      _value = widget.gameData.pass;
    }
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
            min: _min,
            max: _max,
            value: _value,
            onChanged: (newValue) {
              if(widget.title == 'saniye') {
                widget.gameData.changeTime(newValue);
              }else if(widget.title == 'raund') {
                widget.gameData.changeRound(newValue);
              }else if(widget.title == 'pas') {
                widget.gameData.changePass(newValue);
              }
              setState(() {
                _value = newValue;
              });
            },
            divisions: _divisions,
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
