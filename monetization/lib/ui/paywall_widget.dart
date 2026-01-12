import 'package:flutter/material.dart';
import '../core/interfaces/monetization_provider.dart';

// import eliminado: innecesario

class PaywallWidget extends StatelessWidget {
  final MonetizationProvider provider;

  const PaywallWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: provider.getPlans(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error al cargar los planes'));
        }
        final plans = snapshot.data ?? [];
        if (plans.isEmpty) {
          return Center(child: Text('No hay planes disponibles'));
        }
        return Column(
          children: plans.where((plan) => plan != null).map((plan) {
            final p = plan as dynamic;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(p.name ?? ''),
                subtitle: Text('${p.price ?? ''} / ${p.period ?? ''}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    debugPrint(
                      '[PaywallWidget] Card de suscripción presionado: ${p.id ?? ''}',
                    );
                    provider.purchase(p.id ?? '');
                  },
                  child: const Text('Suscribirse'),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
