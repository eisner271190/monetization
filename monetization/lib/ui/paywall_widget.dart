import 'package:flutter/material.dart';
import '../core/interfaces/monetization_provider.dart';

class PaywallWidget extends StatelessWidget {
  final MonetizationProvider provider;

  const PaywallWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => provider.purchase('monthly'),
          child: const Text('Suscribirse'),
        ),
      ],
    );
  }
}
