import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class SubscriptionBadge extends StatelessWidget {
  final String label;
  const SubscriptionBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    debugPrint('[SubscriptionBadge] Mostrando badge: $label');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
