import 'package:flutter/material.dart';
import 'package:monetization_component/monetization_module.dart';
import 'package:monetization_component/providers/revenuecat/revenuecat_provider.dart';
import 'package:monetization_component/providers/ads/admob_provider.dart';
import 'package:monetization_component/ui/paywall_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        body: Center(
          child: PaywallWidget(provider: monetization.provider),
        ),
      ),
    );
  }
}
