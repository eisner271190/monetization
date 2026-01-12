import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MonetizationEnv {
  static String get revenueCatKey => dotenv.env['REVENUECAT_PUBLIC_KEY'] ?? '';
  static String get admobBannerId => dotenv.env['ADMOB_BANNER_ID'] ?? '';

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
