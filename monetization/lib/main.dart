import 'package:flutter/material.dart';
import 'monetization_module.dart';
import 'core/config/monetization_env.dart';
import 'providers/revenuecat/revenuecat_provider.dart';
import 'providers/ads/admob_provider.dart';
import 'ui/paywall_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MonetizationEnv.validateAndLog();
  final monetization = MonetizationModule(
    provider: RevenueCatProvider(),
    adsProvider: AdmobProvider(),
  );
  await monetization.init();
  runApp(MyApp(monetization: monetization));
}

class MyApp extends StatelessWidget {
  final MonetizationModule monetization;
  const MyApp({super.key, required this.monetization});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Monetization Example')),
        body: Center(child: PaywallWidget(provider: monetization.provider)),
      ),
    );
  }
}
