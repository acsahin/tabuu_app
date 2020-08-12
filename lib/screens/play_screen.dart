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
  int _roundNumber = 1;

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
    if (!mounted) return;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime--;
        print(_currentTime);
        if (_currentTime == 0) {
          timer.cancel();
          print('DONE');
          if(_roundNumber == _gameData.round && _currentTeam == TeamNumber.team2) Navigator.pop(context);
          else {
            _currentTime = _gameData.time;
            _currentTeam = (_currentTeam == TeamNumber.team1
                ? TeamNumber.team2
                : TeamNumber.team1);
            showMyDialog(
              onTap: () {
                Navigator.pop(context);
                roundTimer();
              },
              context: context,
              currentTeam: _currentTeam,
              teamData: _teamData,
              round: _roundNumber,
            );
            if(_currentTeam == TeamNumber.team1) _roundNumber++;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentTime != 0 ? '$_currentTime SANİYE' : '! ! B İ T T İ ! !',
          style: TextStyle(fontSize: 40.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TeamInGameCard(currentTeam: _currentTeam, teamData: _teamData),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('images/flag.jpg'),
            ),
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

class TeamInGameCard extends StatelessWidget {
  final TeamNumber currentTeam;
  final TeamData teamData;
  final TextStyle textStyle;
  final EdgeInsets margin;

  TeamInGameCard({this.currentTeam, this.teamData, this.margin, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin == null ? EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0) : margin,
      color: currentTeam == TeamNumber.team1
          ? teamData.team1Color
          : teamData.team2Color,
      elevation: 8.0,
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        leading: Icon(
          currentTeam == TeamNumber.team1
              ? teamData.team1Icon
              : teamData.team2Icon,
          size: 60.0,
        ),
        title: Text(
          currentTeam == TeamNumber.team1
              ? teamData.team1Name
              : teamData.team2Name,
          textAlign: TextAlign.center,
          style: textStyle == null ? kTeamTextStyle.copyWith(fontSize: 35.0) : textStyle,
        ),
      ),
    );
  }
}