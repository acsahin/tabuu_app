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
  int _time;
  @override
  void initState() {
    super.initState();
    _gameData = widget.gameData;
    _time = _gameData.time;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _time--;
        print(_time);
        if (_time == 0) {
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
        title: _time != 0 ? Text('$_time SANİYE', style: TextStyle(fontSize: 40.0),) : Text('! ! B İ T T İ ! !', style: TextStyle(fontSize: 40.0),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              color: Colors.blue,
              elevation: 8.0,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                leading: Icon(
                  Icons.timer,
                  size: 60.0,
                ),
                title: Text(
                  '1. TAKIM',
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


