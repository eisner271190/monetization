import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:flutter/foundation.dart';

import '../../core/config/monetization_env.dart';
import '../../core/interfaces/monetization_provider.dart';
import '../../core/models/subscription_plan.dart';
import '../../core/models/user_entitlement.dart';

class RevenueCatProvider implements MonetizationProvider {
  Offerings? _offerings;
  final _entitlementController = Stream<UserEntitlement>.empty();

  @override
  Future<void> initialize() async {
    if (kIsWeb) {
      // No inicializar RevenueCat en web
      return;
    }
    debugPrint('[RevenueCatProvider] Inicializando RevenueCat');
    await Purchases.setLogLevel(LogLevel.debug);
    // Usar la clave desde MonetizationEnv
    await Purchases.configure(
      PurchasesConfiguration(MonetizationEnv.revenueCatKey),
    );
    _offerings = await Purchases.getOfferings();
    await Purchases.getCustomerInfo();
  }

  @override
  Future<List<SubscriptionPlan>> getPlans() async {
    debugPrint('[RevenueCatProvider] Obteniendo planes');
    final plans = <SubscriptionPlan>[];
    if (_offerings?.current != null) {
      for (final package in _offerings!.current!.availablePackages) {
        plans.add(
          SubscriptionPlan(
            id: package.identifier,
            name: package.storeProduct.title,
            price: package.storeProduct.price.toString(),
            period: package.storeProduct.subscriptionPeriod ?? '',
          ),
        );
      }
    }
    return plans;
  }

  @override
  Future<void> purchase(String planId) async {
    debugPrint('[RevenueCatProvider] Intentando comprar plan: $planId');
    final packages = _offerings?.current?.availablePackages;
    final package = packages?.firstWhereOrNull((p) => p.identifier == planId);
    if (package != null) {
      await Purchases.purchasePackage(package);
      await Purchases.getCustomerInfo();
    }
  }

  @override
  Future<void> restore() async {
    debugPrint('[RevenueCatProvider] Restaurando compras');
    await Purchases.restorePurchases();
    await Purchases.getCustomerInfo();
  }

  @override
  Stream<UserEntitlement> entitlementStream() {
    // Implementar stream real si es necesario
    return _entitlementController;
  }
}
