import 'package:monetization_component/core/models/subscription_plan.dart';
import 'package:monetization_component/core/models/user_entitlement.dart';

abstract class MonetizationProvider {
  Future<void> initialize();
  Future<List<SubscriptionPlan>> getPlans();
  Future<void> purchase(String planId);
  Future<void> restore();
  Stream<UserEntitlement> entitlementStream();
}
