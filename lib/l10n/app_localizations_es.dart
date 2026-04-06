// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Kéfir Control';

  @override
  String get accept => 'Aceptar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get history => 'Historial';

  @override
  String get changeLanguage => 'Cambiar idioma';

  @override
  String get drawerDonate => 'Invítame a un café';

  @override
  String get drawerDonateSubtitle => 'Apoya el desarrollo';

  @override
  String get historyTitle => 'Historial';

  @override
  String get historyEmpty => 'No hay fermentaciones registradas.';

  @override
  String get historyClear => 'Limpiar';

  @override
  String get historyClearTitle => '¿Borrar historial?';

  @override
  String get historyClearContent => 'Esta acción no se puede deshacer.';

  @override
  String get historyClearConfirm => 'Borrar';

  @override
  String get homeNoActiveFermentationTitle => 'Sin fermentación activa';

  @override
  String get homeNoActiveFermentationDesc =>
      'Selecciona una opción del menú para comenzar.';

  @override
  String get homeEstimatedFinish => 'Tiempo estimado';

  @override
  String get homeRemainingTime => 'Quedan';

  @override
  String get homeCompleted => 'Completado';

  @override
  String get homeStopTitle => '¿Finalizar fermentación?';

  @override
  String get homeStopContent =>
      'Estás a punto de parar el temporizador. Asegúrate de colar los nódulos.';

  @override
  String get homeStopConfirm => 'Finalizar';

  @override
  String get btnStartFermentation => 'Iniciar fermentación';

  @override
  String get btnStartPastFermentation => 'Registrar fermentación pasada';

  @override
  String get btnStopFermentation => 'Finalizar fermentación';

  @override
  String get dialogManualTitle => 'Iniciar fermentación pasada';

  @override
  String get dialogManualDesc =>
      'Selecciona la fecha y hora a la que mezclaste la leche con los nódulos para calcular el progreso actual y programar la alarma.';

  @override
  String get dialogManualDate => 'Fecha de inicio';

  @override
  String get dialogManualTime => 'Hora de inicio';

  @override
  String get dialogManualDuration => 'Duración objetivo';

  @override
  String get dialogManualBtnStart => 'Iniciar';

  @override
  String get dialogOption24h => '24 horas';

  @override
  String get dialogOption36h => '36 horas';

  @override
  String get dialogOption48h => '48 horas';

  @override
  String get infoTitle => 'Información y Guía';

  @override
  String get infoCard1Title => '🥛 ¿Qué es el Kéfir de leche?';

  @override
  String get infoCard1Desc =>
      'El kéfir de leche es una bebida fermentada rica en probióticos que se elabora añadiendo nódulos de kéfir a leche entera a temperatura ambiente.';

  @override
  String get infoCard2Title => '⏱️ Tiempos de Fermentación';

  @override
  String get infoCard2Subtitle1 => '24 Horas';

  @override
  String get infoCard2Desc1 =>
      'Sabor suave y consistencia líquida, parecido a un yogur para beber con toques dulces. Efecto ligeramente laxante. Ideal si la temperatura ambiente es alta (>25ºC).';

  @override
  String get infoCard2Subtitle2 => '36 Horas';

  @override
  String get infoCard2Desc2 =>
      'El punto más equilibrado. Textura más cremosa que separa ligeramente el suero. Efecto regulador intestinal.';

  @override
  String get infoCard2Subtitle3 => '48 Horas';

  @override
  String get infoCard2Desc3 =>
      'Sabor ácido y fuerte. El suero formará una bolsa de líquido evidente en la base. Efecto astringente. Recomendado solo si la temperatura ambiente es muy baja o se busca un kéfir curado.';

  @override
  String get infoCard3Title => 'Consejo';

  @override
  String get infoCard3Desc =>
      'Evita los utensilios de metal al colar tus nódulos; usa cucharas y coladores de plástico o madera para no dañar los microorganismos.';

  @override
  String get devDesc => 'Gestiona tus fermentaciones';

  @override
  String get notifReadyTitle => '¡El kéfir está listo! 🥛';

  @override
  String notifReadyBody(Object hours) {
    return 'La fermentación de $hours horas ha terminado. Es hora de colar los nódulos y disfrutar de tu bebida probiótica.';
  }

  @override
  String get notifReminderTitle => 'Preparación para el Kéfir';

  @override
  String get notifReminderBody =>
      'Faltan 2 horas para terminar. ¡Ve preparando recipientes limpios!';

  @override
  String get infoTab1 => 'Sobre el Kéfir';

  @override
  String get infoTab2 => 'Guía de la App';

  @override
  String get infoProcessTitle => 'El Proceso de Fermentación';

  @override
  String get infoProcessStep1Title => 'Preparación';

  @override
  String get infoProcessStep1Desc =>
      'Se introducen los nódulos de kéfir en leche a temperatura ambiente, preferiblemente leche entera (aunque también puede ser semidesnatada o desnatada).';

  @override
  String get infoProcessStep2Title => 'Fermentación (24h - 48h)';

  @override
  String get infoProcessStep2Desc =>
      'Los microorganismos consumen la lactosa de la leche, transformándola en ácido láctico (lo que le da su sabor ácido), dióxido de carbono y otros compuestos beneficiosos. A mayor tiempo, más espeso y ácido se vuelve.';

  @override
  String get infoProcessStep3Title => 'Recolección';

  @override
  String get infoProcessStep3Desc =>
      'Se cuela la mezcla con un colador no metálico. El líquido resultante es la bebida de kéfir lista para consumir, y los nódulos recuperados se vuelven a introducir en nueva leche para repetir el ciclo.';

  @override
  String get infoGuideTitle => 'Cómo usar Kéfir Control';

  @override
  String get infoGuideDesc =>
      'Esta aplicación está diseñada para ayudarte a llevar un control preciso de los tiempos de tus fermentaciones, evitando que tu kéfir se vuelva excesivamente ácido por olvido.';

  @override
  String get infoGuideStep1Title => 'Iniciar Fermentación Ahora';

  @override
  String get infoGuideStep1Desc =>
      'Pulsa este botón justo después de mezclar la leche con los nódulos. Te pedirá que elijas cuánto tiempo quieres que fermente (24, 36 o 48 horas). La app programará una alarma automática.';

  @override
  String get infoGuideStep2Title => 'Registrar Fermentación Pasada';

  @override
  String get infoGuideStep2Desc =>
      '¿Se te olvidó darle al botón cuando preparaste el kéfir esta mañana? No pasa nada. Usa esta opción para indicar a qué hora (y día) exacta hiciste la mezcla en la vida real. La app calculará el tiempo transcurrido desde entonces.';

  @override
  String get infoGuideStep3Title => 'Notificaciones';

  @override
  String get infoGuideStep3Desc =>
      'Puedes cerrar la aplicación sin miedo. Cuando el tiempo objetivo se alcance, recibirás una notificación en tu dispositivo avisándote de que es hora de colar el kéfir.';

  @override
  String get infoGuideStep4Title => 'Finalizar Fermentación';

  @override
  String get infoGuideStep4Desc =>
      'Pulsa este botón rojo una vez hayas colado el kéfir para limpiar el temporizador y dejar la aplicación lista para tu próxima recolección.';

  @override
  String get historyDeleted => 'Registro eliminado';

  @override
  String historyItemTitle(Object hours) {
    return 'Fermentación ${hours}h';
  }

  @override
  String historyItemStart(Object date) {
    return 'Inicio: $date';
  }

  @override
  String historyItemEnd(Object date) {
    return 'Fin: $date';
  }

  @override
  String get timeDays => 'DÍAS';

  @override
  String get timeHours => 'HORAS';

  @override
  String get timeMinutes => 'MINUTOS';

  @override
  String get timeSeconds => 'SEGUNDOS';

  @override
  String get timelineStart => 'Inicio';

  @override
  String get timelineEnd => 'Fin';

  @override
  String get step0Title => 'Etapa láctea';

  @override
  String get step0Desc =>
      'La leche está infusionándose y empezando a espesar ligeramente.';

  @override
  String get step1Title => 'Iniciando fermentación';

  @override
  String get step1Desc =>
      'El kéfir comienza a tomar forma con una acidez suave.';

  @override
  String get step2Title => 'Fermentación ideal';

  @override
  String get step2Desc =>
      'Momento perfecto para la mayoría de los gustos. Textura cremosa.';

  @override
  String get step3Title => 'Fermentación fuerte';

  @override
  String get step3Desc =>
      'Sabor más pronunciado. Puede empezar a separarse el suero.';

  @override
  String get step4Title => 'Muy ácido';

  @override
  String get step4Desc =>
      'Sabor muy agresivo. Ideal para recetas que requieran acidez fuerte.';

  @override
  String get addSheetTitle => '¿Qué vas a fermentar?';

  @override
  String get addSheetKefir => 'Kéfir de Leche';

  @override
  String get addSheetKombucha => 'Kombucha';

  @override
  String get notifReadyTitleKombucha => 'Kombucha Lista';

  @override
  String get notifReadyTitleKefir => 'Kéfir Listo';

  @override
  String get notifReadyBodyGeneric => 'Tu fermentación ha finalizado';

  @override
  String get notifReminderTitleGeneric => 'Recordatorio';

  @override
  String get notifReminderBodyGeneric => 'Faltan 2 horas para terminar';

  @override
  String get addSheetPastRecord => 'Registrar fermentación pasada';

  @override
  String addSheetPastSelected(Object date) {
    return 'Inicio: $date\nAhora elige la duración';
  }

  @override
  String get addSheetTimeKefir => 'Tiempo para Kéfir';

  @override
  String addSheetHours(Object hours) {
    return '$hours Horas';
  }

  @override
  String get addSheetTimeKombucha => 'Tiempo para Kombucha';

  @override
  String addSheetIdealTime(Object days) {
    return 'Tu tiempo ideal ($days días)';
  }

  @override
  String addSheetDays(Object days) {
    return '$days Días';
  }

  @override
  String get cardTranscurrido => 'Transcurrido';

  @override
  String get cardRestante => 'Restante';

  @override
  String get cardCosechar => 'Cosechar';

  @override
  String get cardFinalizar => 'Finalizar';

  @override
  String get homeHarvestKombuchaTitle => 'Cosechar Kombucha';

  @override
  String get homeHarvestKombuchaDesc =>
      '¿Deseas memorizar este tiempo exacto como tu tiempo ideal para futuras fermentaciones?';

  @override
  String get homeHarvestOnly => 'Solo cosechar';

  @override
  String get homeHarvestAndSave => 'Cosechar y Guardar';

  @override
  String get homeDeleteTitle => '¿Eliminar fermentación?';

  @override
  String get homeDeleteDesc =>
      'Si eliminas esta tarjeta, el proceso se descartará y no se guardará en el historial.';

  @override
  String get homeDeleteBtn => 'Eliminar';

  @override
  String get homeNewFermentation => 'Nueva fermentación';

  @override
  String get historyKombuchaFinished => 'Kombucha cosechada';

  @override
  String historyKombuchaDuration(Object days) {
    return 'Duración: $days días';
  }

  @override
  String get stageKombucha0 => 'Formación inicial';

  @override
  String get stageKombucha1 => 'Ligeramente dulce';

  @override
  String get stageKombucha2 => 'Equilibrada (Ideal)';

  @override
  String get stageKombucha3 => 'Fuerte/Ácida';

  @override
  String get stageKombucha4 => 'Avinagrada';

  @override
  String get historyKefirFinished => 'Kéfir cosechado';

  @override
  String historyCompletedPercent(Object percent) {
    return 'Completado: $percent%';
  }

  @override
  String historyDurationDays(Object days) {
    return '$days días';
  }

  @override
  String historyDurationDaysHours(Object days, Object hours) {
    return '$days días y ${hours}h';
  }

  @override
  String historyDurationHours(Object hours) {
    return '${hours}h';
  }

  @override
  String historyDurationHoursMinutes(Object hours, Object minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String historyRealDurationTarget(Object actual, Object target) {
    return 'Duración real: $actual / Meta: $target';
  }

  @override
  String historyCompletedOn(Object date) {
    return 'Completado el $date';
  }

  @override
  String get historyItemDeleteTitle => '¿Eliminar registro?';

  @override
  String get historyItemDeleteContent =>
      'Este registro se borrará de forma permanente.';

  @override
  String get drawerDataManagement => 'Gestión de datos';

  @override
  String get drawerBackup => 'Exportar copia';

  @override
  String get drawerRestore => 'Restaurar copia';

  @override
  String get backupSuccessTitle => 'Copia exportada';

  @override
  String get backupSuccessDesc => 'Los datos se han guardado con éxito.';

  @override
  String get restoreSuccessTitle => 'Copia restaurada';

  @override
  String get restoreSuccessDesc => 'Los datos han vuelto a la magia.';

  @override
  String get restoreErrorTitle => 'Error';

  @override
  String get restoreErrorDesc => 'El archivo es inválido o está corrupto.';

  @override
  String addSheetIdealTimeKefir(num hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String hoursString = hoursNumberFormat.format(hours);

    return 'Tu tiempo ideal (${hoursString}h)';
  }

  @override
  String get addSheetCustomTime => 'Tiempo personalizado';

  @override
  String get addSheetNoLimit => 'Sin límite';

  @override
  String get addSheetCustomHours => 'Horas';

  @override
  String get addSheetCustomDays => 'Días';

  @override
  String get addSheetCustomConfirm => 'Usar este tiempo';

  @override
  String get cardNoLimit => 'Sin límite';

  @override
  String get cardOpenEndedStage => 'Modo experimental';

  @override
  String get addSheetNameHint => 'Nombre del lote (opcional)';

  @override
  String get cardRenameTitle => 'Renombrar';

  @override
  String get cardRenameHint => 'Nombre del lote';

  @override
  String get drawerCalendar => 'Calendario';

  @override
  String get calendarTitle => 'Mis Fermentaciones';

  @override
  String get calendarNoFermentations => 'Sin fermentaciones este día';

  @override
  String get calendarActiveBadge => 'Activa';

  @override
  String get calendarPlannedBadge => 'Planificada';

  @override
  String get calendarPlanButton => 'Planificar para este día';

  @override
  String get cardStartsIn => 'Comienza en';
}
