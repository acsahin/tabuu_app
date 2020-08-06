import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                    builder: (context) {
                      return SettingsDialog();
                    });
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

class SettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.grey[600],
      children: <Widget>[
        TeamCard(
          teamColor: Colors.green,
          teamIcon: Icons.games,
        ),
        TeamCard(
          teamColor: Colors.red,
          teamIcon: Icons.offline_bolt,
        )
      ],
    );
  }
}

class TeamCard extends StatefulWidget {
  Color teamColor;
  IconData teamIcon;

  TeamCard({this.teamColor, this.teamIcon});

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      color: widget.teamColor,
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              setState(() {
                widget.teamIcon = Icons.ac_unit;
                widget.teamColor = Colors.lightBlueAccent;
              });
            },
            child: Icon(widget.teamIcon),
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
          subtitle: Text(
            'Team starts with the color',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
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
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPressed,
        color: Colors.purple,
        padding: EdgeInsets.all(20.0),
        child: Text(title),
      ),
    );
  }
}
