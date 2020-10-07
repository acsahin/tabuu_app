import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/game_data.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'package:tabuu_app/screens/result_screen.dart';
import 'package:tabuu_app/service/question_bank.dart';
import 'dart:async';
import 'package:tabuu_app/widgets/play_screen_widgets.dart';
import 'package:tabuu_app/models/game_info.dart';

class PlayScreen extends StatefulWidget {
  final GameData gameData;
  final TeamData teamData;
  final String questionData;

  PlayScreen({this.gameData, this.teamData, this.questionData});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  GameData _gameData;
  TeamData _teamData;
  QuestionBank _questionBank;
  int _currentTime;
  TeamNumber _currentTeam;
  GameInfo _gameInfo;

  @override
  void initState() {
    super.initState();
    _questionBank = QuestionBank(questionList: jsonDecode(widget.questionData));
    _questionBank.getQuestion();
    _gameData = widget.gameData;
    _teamData = widget.teamData;
    _gameInfo = GameInfo(
      team1Color: _teamData.team1Color,
      team1Name: _teamData.team1Name,
      team1Icon: _teamData.team1Icon,
      team2Color: _teamData.team2Color,
      team2Name: _teamData.team2Name,
      team2Icon: _teamData.team2Icon,
    );
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
          if (_gameInfo.roundNumber == _gameData.round &&
              _currentTeam == TeamNumber.team2) {
            print("FINISH");
            print("t1 tabu: ${_gameInfo.team1Tabu}");
            print("t2 tabu: ${_gameInfo.team2Tabu}");
            print("t1 correct: ${_gameInfo.team1Correct}");
            print("t1 correct: ${_gameInfo.team2Correct}");

            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    gameInfo: _gameInfo,
                  ),
                ));
          } else {
            _currentTime = _gameData.time;
            _gameInfo.restart();
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
              round: _gameInfo.roundNumber,
            );
            if (_currentTeam == TeamNumber.team1) _gameInfo.roundNumber++;
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
              child: Container(
                decoration: BoxDecoration(
                  color: kSliderActiveColor,
                  border: Border.all(
                    color: Color(0xFFfce2ce),
                    width: 4.0
                  ),
                  borderRadius: BorderRadius.circular(10.0),

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _questionBank.currentQuestion,
                ),
              ),
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
                    onTap: () {
                      _gameInfo.tabu(_currentTeam);
                      setState(() {
                        _questionBank.getQuestion();
                      });
                    },
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
                    onTap: () {
                      if (_currentTeam == TeamNumber.team1 &&
                          _gameInfo.team1Pass < _gameData.pass) {
                        _gameInfo.pass(_currentTeam);
                        setState(() {
                          _questionBank.getQuestion();
                        });
                      } else if (_currentTeam == TeamNumber.team2 &&
                          _gameInfo.team2Pass < _gameData.pass) {
                        _gameInfo.pass(_currentTeam);
                        setState(() {
                          _questionBank.getQuestion();
                        });
                      }
                      print("Team1: ${_gameInfo.team1Pass}");
                      print("Team2: ${_gameInfo.team2Pass}");
                    },
                  ),
                ),
                Expanded(
                  child: ResultButton(
                    color: kSliderActiveColor,
                    borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(10.0)),
                    text: 'DOĞRU',
                    icon: Icons.sentiment_very_satisfied,
                    onTap: () {
                      _gameInfo.correct(_currentTeam);
                      setState(() {
                        _questionBank.getQuestion();
                      });
                    },
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

  TeamInGameCard(
      {this.currentTeam, this.teamData, this.margin, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin == null
          ? EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)
          : margin,
      color: currentTeam == TeamNumber.team1
          ? teamData.team1Color
          : teamData.team2Color,
      elevation: 8.0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
          style: textStyle == null
              ? kTeamTextStyle.copyWith(fontSize: 35.0)
              : textStyle,
        ),
      ),
    );
  }
}
