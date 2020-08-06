import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tabuu_app/models/team_data.dart';

enum TeamNumber {
  team1,
  team2,
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabuu TR'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MainScreenButton(
              onPressed: () {
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
              onPressed: () {},
              title: 'YARDIM',
            ),
            MainScreenButton(
              onPressed: () {},
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
    return ChangeNotifierProvider(
      create: (context) => TeamData(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(6.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 56.0, horizontal: 30.0),
            padding: EdgeInsets.all(5.0),
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
                SettingsCard(),
                SettingsCard(),
                SettingsCard(),
                SettingsCard(),
                MainScreenButton(
                  onPressed: () {},
                  title: 'PLAY',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  double theValue = 20.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(3.0),
      color: Colors.black54,
      elevation: 0.0,
      child: Column(
        children: <Widget>[
          Slider(
            min: 10.0,
            max: 60.0,
            value: theValue,
            onChanged: (newValue) {
              setState(() {
                theValue = newValue;
              });
            },
            divisions: 10,
          ),
          Text('Süre ${theValue.toInt()} saniye'),
          SizedBox(
            height: 3.0,
          ),
        ],
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final TeamNumber selectedTeam;

  TeamCard({this.selectedTeam});

  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (detail) {
        selectedTeam == TeamNumber.team1 ? Provider.of<TeamData>(context, listen: false).changeTeam1Color() : Provider.of<TeamData>(context, listen: false).changeTeam2Color();
      },
      onTap: () {
        selectedTeam == TeamNumber.team1 ? Provider.of<TeamData>(context, listen: false).changeTeam1Icon() : Provider.of<TeamData>(context, listen: false).changeTeam2Icon();
      },
      child: Consumer<TeamData>(
        builder: (context, teamData, child) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
            color: selectedTeam == TeamNumber.team1
                ? teamData.team1Color
                : teamData.team2Color,
            elevation: 8.0,
            child: ListTile(
              leading: Icon(
                selectedTeam == TeamNumber.team1
                    ? teamData.team1Icon
                    : teamData.team2Icon,
                size: 50.0,
              ),
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Team Name',
                  border: InputBorder.none,
                ),
                cursorColor: Colors.grey[200],
                textCapitalization: TextCapitalization.characters,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
//              subtitle: Text(
//                'Team starts with the color',
//                style: TextStyle(
//                  fontStyle: FontStyle.italic,
//                ),
//              ),
            ),
          );
        },
      ),
    );
  }
}

class MainScreenButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  MainScreenButton({@required this.onPressed, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      child: RaisedButton(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPressed,
        color: Colors.purple[900],
        padding: EdgeInsets.all(20.0),
        child: Text(title),
      ),
    );
  }
}
