# Integración del Monetization Component

## 1. Agregar dependencia

```yaml
dependencies:
  monetization_component:
    path: ../monetization_component
```

## 2. Variables de entorno

```bash
flutter run --dart-define-from-file=.env
```

## 3. Inicializar

```dart
final monetization = MonetizationModule(
  provider: RevenueCatProvider(),
  adsProvider: AdmobProvider(),
);

await monetization.init();
```

## 4. Usar Paywall

```dart
PaywallWidget(provider: monetization.provider)
```
