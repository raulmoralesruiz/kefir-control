// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fermentation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActiveFermentations)
final activeFermentationsProvider = ActiveFermentationsProvider._();

final class ActiveFermentationsProvider
    extends $NotifierProvider<ActiveFermentations, List<Fermentation>> {
  ActiveFermentationsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'activeFermentationsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activeFermentationsHash();

  @$internal
  @override
  ActiveFermentations create() => ActiveFermentations();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Fermentation> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Fermentation>>(value),
    );
  }
}

String _$activeFermentationsHash() =>
    r'753a62cd59e19c43a837389c85bd0fac16d187ff';

abstract class _$ActiveFermentations extends $Notifier<List<Fermentation>> {
  List<Fermentation> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Fermentation>, List<Fermentation>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<Fermentation>, List<Fermentation>>,
        List<Fermentation>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
