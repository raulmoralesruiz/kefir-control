import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/fermentation_history_item.dart';
import 'service_providers.dart';

part 'history_provider.g.dart';

@riverpod
class History extends _$History {
  @override
  Future<List<FermentationHistoryItem>> build() async {
    final service = ref.read(fermentationServiceProvider);
    return await service.getHistory();
  }

  Future<void> clearHistory() async {
    final service = ref.read(fermentationServiceProvider);
    await service.clearHistory();
    ref.invalidateSelf();
  }

  Future<void> deleteEntry(DateTime completedAt) async {
    final service = ref.read(fermentationServiceProvider);
    await service.deleteHistoryEntry(completedAt);
    ref.invalidateSelf();
  }

  Future<void> updateEntry(FermentationHistoryItem item) async {
    final service = ref.read(fermentationServiceProvider);
    await service.updateHistoryEntry(item);
    ref.invalidateSelf();
  }
}
