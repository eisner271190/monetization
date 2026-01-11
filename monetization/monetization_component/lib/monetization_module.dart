import 'core/interfaces/monetization_provider.dart';
import 'core/interfaces/ads_provider.dart';

class MonetizationModule {
  final MonetizationProvider provider;
  final AdsProvider adsProvider;

  MonetizationModule({
    required this.provider,
    required this.adsProvider,
  });

  Future<void> init() async {
    await provider.initialize();
    await adsProvider.initialize();
  }
}
