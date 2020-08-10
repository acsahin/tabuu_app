import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/game_data.dart';
import 'dart:async';
import 'package:tabuu_app/widgets/play_screen_widgets.dart';

class PlayScreen extends StatefulWidget {
  final GameData gameData;

  PlayScreen({this.gameData});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  GameData _gameData;
  int _currentTime;
  TeamNumber _currentTeam;

  @override
  void initState() {
    super.initState();
    _gameData = widget.gameData;
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
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _currentTime != 0 ? Text('$_currentTime SANİYE', style: TextStyle(fontSize: 40.0),) : Text('! ! B İ T T İ ! !', style: TextStyle(fontSize: 40.0),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              color: _currentTeam == TeamNumber.team1 ? _gameData.team1Color : _gameData.team2Color,
              elevation: 8.0,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                leading: Icon(
                  _currentTeam == TeamNumber.team1 ? _gameData.team1Icon : _gameData.team2Icon,
                  size: 60.0,
                ),
                title: Text(
                  _currentTeam == TeamNumber.team1 ? _gameData.team1Name : _gameData.team2Name,
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
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
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


