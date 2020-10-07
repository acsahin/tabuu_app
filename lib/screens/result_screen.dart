import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'package:tabuu_app/models/game_info.dart';

class ResultScreen extends StatelessWidget {
  final GameInfo gameInfo;

  ResultScreen({this.gameInfo});

  @override
  Widget build(BuildContext context) {
    gameInfo.gameFinished();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabu TR'),
      ),
      body: SafeArea(
        child: Container(
          color: kPrimaryBackgroundColor,
          child: gameInfo.theWinner(),
        ),
      ),
    );
  }
}
