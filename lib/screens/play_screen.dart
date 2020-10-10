import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/game_data.dart';
import 'package:tabuu_app/screens/result_screen.dart';
import 'package:tabuu_app/service/question_bank.dart';
import 'dart:async';
import 'package:tabuu_app/widgets/play_screen_widgets.dart';
import 'package:tabuu_app/models/game_info.dart';

class PlayScreen extends StatefulWidget {
  final GameData gameData;
  final String questionData;
  final GameInfo gameInfo;

  PlayScreen({this.gameData, this.questionData, this.gameInfo});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  QuestionBank _questionBank;
  int _currentTime;
  TeamNumber _currentTeam;

  @override
  void initState() {
    super.initState();
    _questionBank = QuestionBank(questionList: jsonDecode(widget.questionData));
    _questionBank.remake();
    _questionBank.getQuestion();
    _currentTime = widget.gameData.time.toInt();
    _currentTeam = TeamNumber.team1;
    roundTimer();
  }

  void roundTimer() {
    if (!mounted) return;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime--;
        //print(_currentTime);
        if (_currentTime == 0) {
          timer.cancel();
          if (widget.gameInfo.roundNumber == widget.gameData.round &&
              _currentTeam == TeamNumber.team2) {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    gameInfo: widget.gameInfo,
                  ),
                ));
          } else {
            _currentTime = widget.gameData.time.toInt();
            widget.gameInfo.restart();
            _currentTeam = (_currentTeam == TeamNumber.team1
                ? TeamNumber.team2
                : TeamNumber.team1);
            _questionBank.getQuestion();
            showMyDialog(
              onTap: () {
                Navigator.pop(context);
                roundTimer();
              },
              context: context,
              currentTeam: _currentTeam == TeamNumber.team1 ? widget.gameInfo.team1 : widget.gameInfo.team2,
              team: _currentTeam == TeamNumber.team1 ? widget.gameInfo.team2 : widget.gameInfo.team1,
              round: widget.gameInfo.roundNumber,
            );
            if (_currentTeam == TeamNumber.team1) widget.gameInfo.roundNumber++;
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
            TeamInGameCard(team: _currentTeam == TeamNumber.team1 ? widget.gameInfo.team1 : widget.gameInfo.team2),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kSliderActiveColor,
                  border: Border.all(color: Color(0xFFfce2ce), width: 4.0),
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
                      widget.gameInfo.tabu(_currentTeam);
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
                          widget.gameInfo.team1.pass < widget.gameData.pass) {
                        widget.gameInfo.pass(_currentTeam);
                        setState(() {
                          _questionBank.getQuestion();
                        });
                      } else if (_currentTeam == TeamNumber.team2 &&
                          widget.gameInfo.team2.pass < widget.gameData.pass) {
                        widget.gameInfo.pass(_currentTeam);
                        setState(() {
                          _questionBank.getQuestion();
                        });
                      }
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
                      widget.gameInfo.correct(_currentTeam);
                      setState(() {
                        _questionBank.getQuestion();
                        try {

                        }catch(e) {

                        }
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