import 'package:flutter/material.dart';
import 'package:tabuu_app/models/game_info.dart';
import 'package:tabuu_app/screens/main_screen.dart';
import 'package:tabuu_app/services/admob_service.dart';

class ResultScreen extends StatelessWidget {
  final GameInfo gameInfo;
  AdmobService _admobService = AdmobService();

  ResultScreen({this.gameInfo});

  @override
  Widget build(BuildContext context) {
    _admobService.createBannerAd()..load()..show();
    _admobService.getVideo();
    gameInfo.gameFinished();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabu TR'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _admobService.disposeBannerAd();
            _admobService.createInterstitialAd()..load()..show();
            _admobService.disposeInterstitialAd();
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          child: gameInfo.theWinner(),
        )
      ),
    );
  }
}
