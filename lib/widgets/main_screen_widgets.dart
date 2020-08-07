import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'package:provider/provider.dart';

class MainScreenButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  MainScreenButton({@required this.onPressed, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      child: RaisedButton(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPressed,
        color: Colors.purple[900],
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
            ? Provider.of<TeamData>(context, listen: false).changeTeam1Color()
            : Provider.of<TeamData>(context, listen: false).changeTeam2Color();
      },
      onTap: () {
        selectedTeam == TeamNumber.team1
            ? Provider.of<TeamData>(context, listen: false).changeTeam1Icon()
            : Provider.of<TeamData>(context, listen: false).changeTeam2Icon();
      },
      child: Consumer<TeamData>(
        builder: (context, teamData, child) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
            color: selectedTeam == TeamNumber.team1
                ? teamData.team1Color
                : teamData.team2Color,
            elevation: 8.0,
            child: ListTile(
              leading: Icon(
                selectedTeam == TeamNumber.team1
                    ? teamData.team1Icon
                    : teamData.team2Icon,
                size: 50.0,
              ),
              title: TextField(
                decoration: InputDecoration(
                  hintText: selectedTeam == TeamNumber.team1
                      ? '1. Takım'
                      : '2. Takım',
                  border: InputBorder.none,
                ),
                cursorColor: Colors.grey[200],
                textCapitalization: TextCapitalization.characters,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
          );
        },
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
      margin: EdgeInsets.all(3.0),
      color: Colors.black54,
      elevation: 0.0,
      child: Column(
        children: <Widget>[
          Slider(
            min: widget.min,
            max: widget.max,
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
              });
            },
            divisions: widget.divisions,
          ),
          Text('${_value.toInt()} ${widget.title}'),
          SizedBox(
            height: 3.0,
          ),
        ],
      ),
    );
  }
}
