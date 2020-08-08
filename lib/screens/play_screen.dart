import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabuu_app/constants.dart';
import 'dart:async';

class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  int time = 5;
  @override
  void initState() {
    super.initState();
    print(time);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time--;
        print(time);
        if (time == 0) {
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
        title: time != 0 ? Text('$time SANİYE') : Text('DONE'),
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
                leading: Icon(
                  Icons.timer,
                  size: 50.0,
                ),
                title: Text(
                  '1. TAKIM',
                  style: kTeamTextStyle,
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

class ResultButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final String text;
  final IconData icon;
  final Color color;

  ResultButton({this.borderRadius, this.icon, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      color: color,
      onPressed: () {},
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 40.0,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
