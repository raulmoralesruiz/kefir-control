// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(History)
final historyProvider = HistoryProvider._();

final class HistoryProvider
    extends $AsyncNotifierProvider<History, List<FermentationHistoryItem>> {
  HistoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'historyProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$historyHash();

  @$internal
  @override
  History create() => History();
}

String _$historyHash() => r'd1be1c32ccc9ecf14603703103227b307766672e';

abstract class _$History extends $AsyncNotifier<List<FermentationHistoryItem>> {
  FutureOr<List<FermentationHistoryItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<FermentationHistoryItem>>,
        List<FermentationHistoryItem>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<FermentationHistoryItem>>,
            List<FermentationHistoryItem>>,
        AsyncValue<List<FermentationHistoryItem>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
