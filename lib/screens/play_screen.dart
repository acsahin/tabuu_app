import 'package:flutter/material.dart';
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
        if(time==0) {
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
      body: Container(),
    );
  }
}
