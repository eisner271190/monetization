import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/interfaces/ads_provider.dart';
import '../../core/config/monetization_env.dart';

class AdmobProvider implements AdsProvider {
  BannerAd? _bannerAd;

  @override
  Future<void> initialize() async {
    if (kIsWeb) return;
    // Inicializando AdMob
    await MobileAds.instance.initialize();
  }

  @override
  void showBanner() {
    if (kIsWeb) return;
    // Mostrando banner
    final adUnitId = MonetizationEnv.admobBannerId;
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    )..load();
    // Integrar con la UI para mostrar el banner
  }

  @override
  void hideBanner() {
    if (kIsWeb) return;
    // Ocultando banner
    _bannerAd?.dispose();
    _bannerAd = null;
  }
}
