// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fermentationService)
final fermentationServiceProvider = FermentationServiceProvider._();

final class FermentationServiceProvider extends $FunctionalProvider<
    FermentationService,
    FermentationService,
    FermentationService> with $Provider<FermentationService> {
  FermentationServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fermentationServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fermentationServiceHash();

  @$internal
  @override
  $ProviderElement<FermentationService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FermentationService create(Ref ref) {
    return fermentationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FermentationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FermentationService>(value),
    );
  }
}

String _$fermentationServiceHash() =>
    r'4d2351b20727f31410520b80c0873b8b8ba90448';

@ProviderFor(notificationService)
final notificationServiceProvider = NotificationServiceProvider._();

final class NotificationServiceProvider extends $FunctionalProvider<
    NotificationService,
    NotificationService,
    NotificationService> with $Provider<NotificationService> {
  NotificationServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationService> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationService create(Ref ref) {
    return notificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationService>(value),
    );
  }
}

String _$notificationServiceHash() =>
    r'cda5ea9d196dce85bee56839a4a0f035021752e3';
