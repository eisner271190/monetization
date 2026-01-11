class MonetizationEnv {
  static String get revenueCatKey =>
      const String.fromEnvironment('REVENUECAT_PUBLIC_KEY');
  static String get admobBannerId =>
      const String.fromEnvironment('ADMOB_BANNER_ID');
}
