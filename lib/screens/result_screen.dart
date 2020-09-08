import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/game_info.dart';

class ResultScreen extends StatelessWidget {
  final GameInfo gameInfo;

  ResultScreen({this.gameInfo});

  List<Widget> results() {
    return gameInfo.theWinner();
  }

  @override
  Widget build(BuildContext context) {
    gameInfo.gameFinished();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabu TR'),
      ),
      body: Container(
        color: kPrimaryBackgroundColor,
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: results(),
        ),
      ),
    );
  }
}
