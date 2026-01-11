# Flutter Monetization Component (Reusable)

Componente desacoplado para monetización en Flutter con **suscripciones (mensual/anual)**, **free con anuncios**, usando **RevenueCat** pero preparado para cambiar de proveedor.

---

## 🎯 Objetivos
- Reutilizable como **package** o **module**
- Fácil integración en cualquier app Flutter
- Abstracción del proveedor de monetización
- Uso de variables de entorno

---

## 📁 Estructura de carpetas

```txt
monetization_component/
│
├─ lib/
│  ├─ monetization.dart              # Public API
│  ├─ core/
│  │  ├─ config/
│  │  │  └─ monetization_env.dart
│  │  ├─ interfaces/
│  │  │  ├─ monetization_provider.dart
│  │  │  └─ ads_provider.dart
│  │  ├─ models/
│  │  │  ├─ subscription_plan.dart
│  │  │  └─ user_entitlement.dart
│  │  └─ errors/
│  │     └─ monetization_exception.dart
│  │
│  ├─ providers/
│  │  ├─ revenuecat/
│  │  │  ├─ revenuecat_provider.dart
│  │  │  └─ revenuecat_mapper.dart
│  │  └─ ads/
│  │     └─ admob_provider.dart
│  │
│  ├─ ui/
│  │  ├─ paywall_widget.dart
│  │  └─ subscription_badge.dart
│  │
│  └─ monetization_module.dart
│
├─ example/
│  └─ main.dart
│
├─ .env.example
├─ pubspec.yaml
└─ INTEGRATION.md
```

---

## 🧩 Interfaces (Contratos)

### Monetization Provider (abstracción)

```dart
abstract class MonetizationProvider {
  Future<void> initialize();
  Future<List<SubscriptionPlan>> getPlans();
  Future<void> purchase(String planId);
  Future<void> restore();
  Stream<UserEntitlement> entitlementStream();
}
```

### Ads Provider

```dart
abstract class AdsProvider {
  Future<void> initialize();
  void showBanner();
  void hideBanner();
}
```

---

## 🧠 Implementación RevenueCat

```dart
class RevenueCatProvider implements MonetizationProvider {
  @override
  Future<void> initialize() async {
    // Purchases.configure()
  }

  @override
  Future<List<SubscriptionPlan>> getPlans() async {
    return [];
  }

  @override
  Future<void> purchase(String planId) async {}

  @override
  Future<void> restore() async {}

  @override
  Stream<UserEntitlement> entitlementStream() {
    return const Stream.empty();
  }
}
```

> 🔁 Si cambias de proveedor (Stripe, Google Play, etc.) solo implementas `MonetizationProvider`.

---

## ⚙️ Variables de entorno

### `.env.example`

```env
REVENUECAT_PUBLIC_KEY=pk_xxx
REVENUECAT_APPLE_API_KEY=apple_xxx
REVENUECAT_GOOGLE_API_KEY=google_xxx
ADS_PROVIDER=admob
```

### Config loader

```dart
class MonetizationEnv {
  static String get revenueCatKey => const String.fromEnvironment('REVENUECAT_PUBLIC_KEY');
}
```

---

## 🧩 Módulo principal

```dart
class MonetizationModule {
  final MonetizationProvider provider;
  final AdsProvider adsProvider;

  MonetizationModule({
    required this.provider,
    required this.adsProvider,
  });

  Future<void> init() async {
    await provider.initialize();
    await adsProvider.initialize();
  }
}
```

---

## 🖥️ UI Reutilizable

### Paywall Widget

```dart
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
        )
      ],
    );
  }
}
```

---

## 📦 Public API

```dart
library monetization;

export 'core/interfaces/monetization_provider.dart';
export 'monetization_module.dart';
export 'ui/paywall_widget.dart';
```

---

## 📘 Integración Paso a Paso

### 1️⃣ Agregar dependencia

```yaml
dependencies:
  monetization_component:
    path: ../monetization_component
```

### 2️⃣ Variables de entorno

```bash
flutter run --dart-define-from-file=.env
```

### 3️⃣ Inicializar

```dart
final monetization = MonetizationModule(
  provider: RevenueCatProvider(),
  adsProvider: AdmobProvider(),
);

await monetization.init();
```

### 4️⃣ Usar Paywall

```dart
PaywallWidget(provider: monetization.provider)
```

---

## 🚀 Beneficios
- Vendor lock-in evitado
- Clean Architecture
- Plug & Play
- Listo para escalar y vender como SDK

---

Si quieres, puedo:
- Convertir esto en **Flutter package publicable**
- Añadir **tests**
- Crear **diagrama de arquitectura**
- Prepararlo como **SDK comercial**

