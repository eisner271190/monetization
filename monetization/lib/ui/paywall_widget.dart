import 'package:flutter/material.dart';
import '../core/interfaces/monetization_provider.dart';

import 'package:flutter/foundation.dart';

class PaywallWidget extends StatelessWidget {
  final MonetizationProvider provider;

  const PaywallWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            debugPrint('[PaywallWidget] Botón de suscripción presionado');
            provider.purchase('monthly');
          },
          child: const Text('Suscribirse'),
        ),
      ],
    );
  }
}
