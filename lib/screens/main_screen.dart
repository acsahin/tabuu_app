import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabuu_app/models/team_data.dart';
import 'package:tabuu_app/services/admob_service.dart';
import 'package:tabuu_app/widgets/main_screen_widgets.dart';
import 'package:tabuu_app/models/game_data.dart';
import 'package:tabuu_app/constants.dart';

class MainScreen extends StatelessWidget {
  AdmobService _admobService = AdmobService();

  @override
  Widget build(BuildContext context) {
    _admobService.createBannerAd()..load()..show();
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
                _admobService.disposeBannerAd();
                showDialog(
                  context: context,
                  builder: (_) => Center(
                    child: SettingsDialog(),
                  ),
                );
              },
              title: 'OYNA',
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
  final AdmobService _admobService = AdmobService();

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _admobService.createInterstitialAd()..load()..show();
    super.initState();
  }

  @override
  void dispose() {
    _admobService.disposeInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TeamData teamData = TeamData();
    GameData gameData = GameData();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TeamCard(
                selectedTeam: TeamNumber.team1, teamModel: teamData.team1,
              ),
              TeamCard(
                selectedTeam: TeamNumber.team2, teamModel: teamData.team2,
              ),
              SettingsCard(
                title: 'saniye',
                gameData: gameData,
              ),
              SettingsCard(
                title: 'raund',
                gameData: gameData,
              ),
              SettingsCard(
                title: 'pas',
                gameData: gameData,
              ),
              MainScreenButton(
                onTap: () {

                },
                title: 'BAŞLAT',
                gameData: gameData,
                teamData: teamData,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
