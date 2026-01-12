import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../core/config/monetization_env.dart';
import '../../core/interfaces/monetization_provider.dart';
import '../../core/models/subscription_plan.dart';
import '../../core/models/user_entitlement.dart';

class RevenueCatProvider implements MonetizationProvider {
  Offerings? _offerings;
  final _entitlementController = StreamController<UserEntitlement>.broadcast();

  @override
  Future<void> initialize() async {
    if (kIsWeb) {
      // No inicializar RevenueCat en web
      return;
    }
    // Inicializando RevenueCat
    await Purchases.setLogLevel(LogLevel.debug);
    // Usar la clave desde MonetizationEnv
    await Purchases.configure(
      PurchasesConfiguration(MonetizationEnv.revenueCatKey),
    );
    _offerings = await Purchases.getOfferings();
    await Purchases.getCustomerInfo();
    _emitEntitlement();
  }

  @override
  Future<List<SubscriptionPlan>> getPlans() async {
    // Obteniendo planes
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
    // Intentando comprar plan: $planId
    final packages = _offerings?.current?.availablePackages;
    final package = packages?.firstWhereOrNull((p) => p.identifier == planId);
    if (package != null) {
      final params = PurchaseParams.package(package);
      await Purchases.purchase(params);
      await Purchases.getCustomerInfo();
      _emitEntitlement();
    }
  }

  @override
  Future<void> restore() async {
    // Restaurando compras
    await Purchases.restorePurchases();
    await Purchases.getCustomerInfo();
    _emitEntitlement();
  }

  @override
  Stream<UserEntitlement> entitlementStream() {
    return _entitlementController.stream;
  }

  void _emitEntitlement() async {
    final info = await Purchases.getCustomerInfo();
    final entitlements = info.entitlements.active.values;
    if (entitlements.isNotEmpty) {
      final planId = entitlements.first.identifier;
      _entitlementController.add(
        UserEntitlement(isActive: true, planId: planId),
      );
    } else {
      _entitlementController.add(UserEntitlement(isActive: false));
    }
  }
}
