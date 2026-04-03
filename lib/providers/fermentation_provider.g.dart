// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fermentation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveFermentation)
final activeFermentationProvider = ActiveFermentationProvider._();

final class ActiveFermentationProvider
    extends $NotifierProvider<ActiveFermentation, Fermentation?> {
  ActiveFermentationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'activeFermentationProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activeFermentationHash();

  @$internal
  @override
  ActiveFermentation create() => ActiveFermentation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Fermentation? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Fermentation?>(value),
    );
  }
}

String _$activeFermentationHash() =>
    r'bca2e8c2f67953cc65eec2b3ba9db7fbfaa611f1';

abstract class _$ActiveFermentation extends $Notifier<Fermentation?> {
  Fermentation? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Fermentation?, Fermentation?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Fermentation?, Fermentation?>,
        Fermentation?,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
