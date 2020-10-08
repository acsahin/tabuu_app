import 'package:flutter/material.dart';

List<Color> teamColors = [Colors.orange[300], Colors.grey, Colors.yellow[900], Colors.indigo];
List<IconData> teamIcons = [Icons.offline_bolt, Icons.whatshot, Icons.toys, Icons.airplanemode_active, Icons.audiotrack];

enum TeamNumber {
team1,
team2,
}

const kPrimaryColor = Color(0xFF322F3D);
const kPrimaryBackgroundColor = Color(0xFF4B5D67);
const kMainButtonColor = Color(0xFF59405c);
const kSliderActiveColor = Color(0xFF87556f);
const kSettingsTextStyle = TextStyle(
  color: Color(0xFFfce2ce),
);
const kTeamTextStyle = TextStyle(
  fontSize: 24.0,
);

const kTeamLowerTextStyle = TextStyle(
  fontSize: 20.0,
);