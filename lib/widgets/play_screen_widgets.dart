import 'package:flutter/material.dart';

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