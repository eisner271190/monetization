import 'dart:developer';

class MonetizationEnv {
  static String get revenueCatKey =>
      const String.fromEnvironment('REVENUECAT_PUBLIC_KEY');
  static String get admobBannerId =>
      const String.fromEnvironment('ADMOB_BANNER_ID');

  static void validateAndLog() {
    final revenueCat = revenueCatKey;
    final admob = admobBannerId;
    log('[MonetizationEnv] REVENUECAT_PUBLIC_KEY: $revenueCat');
    log('[MonetizationEnv] ADMOB_BANNER_ID: $admob');
    if (revenueCat.isEmpty) {
      throw Exception('REVENUECAT_PUBLIC_KEY is not set in .env');
    }
    if (admob.isEmpty) {
      throw Exception('ADMOB_BANNER_ID is not set in .env');
    }
  }
}
