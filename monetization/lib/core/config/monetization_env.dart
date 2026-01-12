import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MonetizationEnv {
  static String get revenueCatKey => dotenv.env['REVENUECAT_PUBLIC_KEY'] ?? '';
  static String get admobBannerId => dotenv.env['ADMOB_BANNER_ID'] ?? '';

  static String get privacyUrl => dotenv.env['PRIVACY_URL'] ?? '';
  static String get termsUrl => dotenv.env['TERMS_URL'] ?? '';

  static void validateAndLog() {
    final revenueCat = revenueCatKey;
    final admob = admobBannerId;
    final privacy = privacyUrl;
    final terms = termsUrl;
    log('[MonetizationEnv] REVENUECAT_PUBLIC_KEY: $revenueCat');
    log('[MonetizationEnv] ADMOB_BANNER_ID: $admob');
    log('[MonetizationEnv] PRIVACY_URL: $privacy');
    log('[MonetizationEnv] TERMS_URL: $terms');
    if (revenueCat.isEmpty) {
      throw Exception('REVENUECAT_PUBLIC_KEY is not set in .env');
    }
    if (admob.isEmpty) {
      throw Exception('ADMOB_BANNER_ID is not set in .env');
    }
    if (privacy.isEmpty) {
      throw Exception('PRIVACY_URL is not set in .env');
    }
    if (terms.isEmpty) {
      throw Exception('TERMS_URL is not set in .env');
    }
  }
}
