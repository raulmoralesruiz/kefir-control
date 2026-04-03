import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/fermentation_service.dart';
import '../services/notification_service.dart';

part 'service_providers.g.dart';

@riverpod
FermentationService fermentationService(Ref ref) {
  return FermentationService();
}

@riverpod
NotificationService notificationService(Ref ref) {
  return NotificationService();
}
