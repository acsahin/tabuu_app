import 'package:firebase_admob/firebase_admob.dart';

class AdmobService {
  MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(testDevices: ["66D2486B163BE87D5DB810CC0579341B"]);
  String _bannerID = "ca-app-pub-3004337159530698/5722381221";
  String _interID = "ca-app-pub-3004337159530698/7493793742";
  String _rewardID = "ca-app-pub-3004337159530698/2290402678";
  InterstitialAd _interstitialAd;
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerID,
      size: AdSize.fullBanner,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        print("bannerad event $event");
      },
    );
    return _bannerAd;
  }

  InterstitialAd createInterstitialAd() {
    _interstitialAd = InterstitialAd(
      adUnitId: _interID,
      targetingInfo: _targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
    return _interstitialAd;
  }

  void disposeInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd.dispose();
      _interstitialAd = null;
    }
  }

  void disposeBannerAd() {
    if (_bannerAd != null) {
      _bannerAd.dispose();
      _bannerAd = null;
    }
  }

  void getVideo() {
    RewardedVideoAd.instance.load(adUnitId: _rewardID, targetingInfo: _targetingInfo);
    RewardedVideoAd.instance.show();
  }

}
