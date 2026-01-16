import 'package:flutter/widgets.dart';
import '../monetization_module.dart';
import 'app_initializer.dart';

class MonetizationInitializer implements AppInitializer {
  final MonetizationModule monetization;
  MonetizationInitializer(this.monetization);

  @override
  Future<void> preUi() async {
    debugPrint('[MonetizationInitializer] preUi() called');
    await monetization.init();
    debugPrint('[MonetizationInitializer] preUi() finished');
  }

  @override
  Future<void> postUi(BuildContext context) async {
    debugPrint('[MonetizationInitializer] postUi() called');
    // Aquí puedes cargar datos pesados, ofertas, restaurar compras, etc.
    // Ejemplo:
    // await monetization.provider.getPlans();
    // await monetization.provider.restore();
    debugPrint('[MonetizationInitializer] postUi() finished');
  }
}
