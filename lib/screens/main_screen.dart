import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabuu_app/widgets/main_screen_widgets.dart';
import 'package:provider/provider.dart';
import 'package:tabuu_app/models/game_data.dart';
import 'package:tabuu_app/constants.dart';

class MainScreen extends StatelessWidget {
  void loadFile() async {
    String data = await rootBundle.loadString('images/dummy.json');
    List<dynamic> questionList = jsonDecode(data);
    print(questionList[0]['title']);
  }

  @override
  Widget build(BuildContext context) {
    loadFile();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabu TR'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MainScreenButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Center(
                    child: SettingsDialog(),
                  ),
                );
              },
              title: 'OYNA',
            ),
            MainScreenButton(
              onTap: () {},
              title: 'YARDIM',
            ),
            MainScreenButton(
              onTap: () {},
              title: 'HAKKINDA',
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsDialog extends StatefulWidget {
  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: kPrimaryBackgroundColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          margin: EdgeInsets.symmetric(vertical: 56.0, horizontal: 30.0),
          padding: EdgeInsets.all(5.0),
          child: ChangeNotifierProvider(
            create: (context) => GameData(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TeamCard(
                  selectedTeam: TeamNumber.team1,
                ),
                TeamCard(
                  selectedTeam: TeamNumber.team2,
                ),
                SettingsCard(
                  min: 10.0,
                  max: 60.0,
                  value: 30.0,
                  divisions: 50,
                  title: 'saniye',
                ),
                SettingsCard(
                  min: 2.0,
                  max: 16.0,
                  value: 4.0,
                  divisions: 14,
                  title: 'raund',
                ),
                SettingsCard(
                  min: 0.0,
                  max: 10.0,
                  value: 3.0,
                  divisions: 10,
                  title: 'pas',
                ),
                MainScreenButton(
                  onTap: () {},
                  title: 'BAŞLAT',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
