import 'package:firebase_admob/firebase_admob.dart';

class AdmobService {
  MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(testDevices: ["YOUR-TESTING-DEVICE-ID"]);
  String _bannerID = BannerAd.testAdUnitId;
  String _interID = InterstitialAd.testAdUnitId;
  String _rewardID = RewardedVideoAd.testAdUnitId;
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
