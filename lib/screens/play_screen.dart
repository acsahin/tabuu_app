import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/game_data.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'dart:async';
import 'package:tabuu_app/widgets/play_screen_widgets.dart';

class PlayScreen extends StatefulWidget {
  final GameData gameData;
  final TeamData teamData;

  PlayScreen({this.gameData, this.teamData});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  GameData _gameData;
  TeamData _teamData;
  int _currentTime;
  TeamNumber _currentTeam;

  @override
  void initState() {
    super.initState();
    _gameData = widget.gameData;
    _teamData = widget.teamData;
    _currentTime = _gameData.time;
    _currentTeam = TeamNumber.team1;
    roundTimer();
  }

  void roundTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime--;
        print(_currentTime);
        if (_currentTime == 0) {
          timer.cancel();
          print('DONE');
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: kPrimaryBackgroundColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 56.0, horizontal: 30.0),
                    padding: EdgeInsets.all(5.0),
                    child: Text('heloooo'),
                  ),
                ],
              ),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _currentTime != 0
            ? Text(
                '$_currentTime SANİYE',
                style: TextStyle(fontSize: 40.0),
              )
            : Text(
                '! ! B İ T T İ ! !',
                style: TextStyle(fontSize: 40.0),
              ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              color: _currentTeam == TeamNumber.team1
                  ? _teamData.team1Color
                  : _teamData.team2Color,
              elevation: 8.0,
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                leading: Icon(
                  _currentTeam == TeamNumber.team1
                      ? _teamData.team1Icon
                      : _teamData.team2Icon,
                  size: 60.0,
                ),
                title: Text(
                  _currentTeam == TeamNumber.team1
                      ? _teamData.team1Name
                      : _teamData.team2Name,
                  textAlign: TextAlign.center,
                  style: kTeamTextStyle.copyWith(fontSize: 35.0),
                ),
              ),
            ),
            Image.asset('images/flag.jpg'),
            Row(
              children: <Widget>[
                Expanded(
                  child: ResultButton(
                    color: kPrimaryColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10.0)),
                    text: 'TABU',
                    icon: Icons.sentiment_very_dissatisfied,
                  ),
                ),
                Expanded(
                  child: ResultButton(
                    color: kMainButtonColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    text: 'PAS',
                    icon: Icons.block,
                  ),
                ),
                Expanded(
                  child: ResultButton(
                    color: kSliderActiveColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10.0)),
                    text: 'DOĞRU',
                    icon: Icons.sentiment_very_satisfied,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
