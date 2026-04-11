import 'package:flutter/services.dart';

/// Servicio centralizado para gestionar el feedback háptico (vibraciones sutiles).
/// Proporciona diferentes intensidades y patrones para mejorar la UX.
class HapticService {
  /// Feedback ligero para toques simples, navegación o ajustes menores.
  static Future<void> light() => HapticFeedback.lightImpact();

  /// Feedback de selección (click) ideal para ruedas de scroll o cambios de estado rápidos.
  static Future<void> selection() => HapticFeedback.selectionClick();

  /// Feedback intermedio para acciones positivas confirmadas (ej: iniciar lote).
  static Future<void> medium() => HapticFeedback.mediumImpact();

  /// Feedback pesado para acciones importantes o irreversibles (ej: borrar).
  static Future<void> heavy() => HapticFeedback.heavyImpact();

  /// Patrón personalizado de éxito: doble toque ligero.
  /// Ideal para acciones gratificantes como cosechar un fermento.
  static Future<void> success() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 60));
    await HapticFeedback.lightImpact();
  }
}
