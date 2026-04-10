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
  String get themeTitle => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Modo claro';

  @override
  String get themeDark => 'Modo oscuro';

  @override
  String get drawerDonate => 'Invítame a un café';

  @override
  String get drawerDonateSubtitle => 'Apoya el desarrollo';

  @override
  String get historyTitle => 'Historial';

  @override
  String get homeSwipeDeleteHint => 'Desliza una tarjeta para borrarla';

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
  String get infoTab1 => 'Guía';

  @override
  String get infoTab2 => 'Fermentos';

  @override
  String get infoTab3 => 'Avanzado';

  @override
  String get infoProcessTitle => 'El Proceso del Kéfir';

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
  String get infoGuideStepHarvestTitle => 'Cosechar y Reiniciar';

  @override
  String get infoGuideStepHarvestDesc =>
      'Cuando termines un lote, usa este nuevo flujo para guardarlo e iniciar el siguiente ciclo inmediatamente con un solo toque.';

  @override
  String get infoGuideStepAdjustTitle => 'Ajustar Tiempos';

  @override
  String get infoGuideStepAdjustDesc =>
      '¿Hace más calor de lo normal? Pulsa sobre el progreso de cualquier fermentación activa para acortar o alargar su duración.';

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
  String get historyHarvestDate => 'Fecha de cosecha';

  @override
  String historyRealDurationTarget(Object actual, Object target) {
    return 'Duración: $actual (objetivo $target)';
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

  @override
  String get detailStartDate => 'Inicio';

  @override
  String get detailStageKombucha0Desc =>
      'El SCOBY está despertando. La bebida sigue siendo prácticamente té dulce.';

  @override
  String get detailStageKombucha1Desc =>
      'La fermentación avanza con suavidad. Aún predomina el dulzor con un ligero toque ácido.';

  @override
  String get detailStageKombucha2Desc =>
      'El punto de equilibrio perfecto entre dulzura y acidez. Ideal para la mayoría de paladares.';

  @override
  String get detailStageKombucha3Desc =>
      'Acidez pronunciada y sabor complejo. Apto para quienes prefieren un sabor intenso.';

  @override
  String get detailStageKombucha4Desc =>
      'Fermentación muy avanzada. Sabor avinagrado intenso, más apto para uso culinario.';

  @override
  String get detailNotesTitle => 'Notas';

  @override
  String get detailNotesHint =>
      'Añade detalles sobre la leche, temperatura, etc...';

  @override
  String get detailHistoryTitle => 'Historial Reciente';

  @override
  String get detailHistoryEmpty => 'Sin cosechas previas';

  @override
  String detailHistoryLastHarvest(Object duration) {
    return 'Última tanda: $duration';
  }

  @override
  String get historyRepeat => 'Repetir lote';

  @override
  String get adjSheetTitle => 'Ajustar tiempo';

  @override
  String get adjSheetSetNoLimit => 'Pasar a \'Sin límite\'';

  @override
  String get adjSheetSetTimed => 'Establecer duración';

  @override
  String get actionSaveIdealTime => 'Guardar tiempo ideal';

  @override
  String get actionSaveIdealTimeSuccess =>
      'Tiempo ideal guardado correctamente';

  @override
  String get dialogSaveIdealConfirm =>
      '¿Guardar este tiempo como tu referencia ideal?';

  @override
  String get actionHarvestAndRestart => 'Cosechar y reiniciar';

  @override
  String get dialogHarvestAndRestartConfirm =>
      '¿Cosechar lote actual y empezar uno nuevo?';

  @override
  String get harvestNextStepTitle => 'Siguiente ciclo';

  @override
  String get actionDelete => 'Borrar';

  @override
  String get dialogResetConfirm =>
      'Se guardará en el historial y el contador volverá a 0.';

  @override
  String secondFermentationName(Object name) {
    return 'F2: $name';
  }

  @override
  String get secondFermentationDefaultName => 'Segunda Fermentación';

  @override
  String get infoKombuchaTitle => '🍵 ¿Qué es la Kombucha?';

  @override
  String get infoKombuchaDesc =>
      'Es té fermentado mediante una colonia simbiótica de bacterias y levaduras (SCOBY). Es rica en ácidos orgánicos y vitaminas.';

  @override
  String get infoKombuchaProcessTitle => 'El Ciclo de la Kombucha';

  @override
  String get infoKombuchaStep1Title => 'Preparación';

  @override
  String get infoKombuchaStep1Desc =>
      'Se infusiona té con azúcar y, una vez frío, se añade el SCOBY con un poco de líquido iniciador del lote anterior.';

  @override
  String get infoKombuchaStep2Title => 'Fermentación (7-12 días)';

  @override
  String get infoKombuchaStep2Desc =>
      'El SCOBY consume el azúcar y el té. La app aprenderá de tus cosechas para sugerirte tu \'Tiempo Ideal\' personalizado.';

  @override
  String get infoAdvancedCalendarTitle => 'Calendario';

  @override
  String get infoAdvancedCalendarDesc =>
      'Visualiza tus cosechas pasadas y planifica futuras preparaciones desde la pestaña de Calendario.';

  @override
  String get infoAdvancedHistoryTitle => 'Historial';

  @override
  String get infoAdvancedHistoryDesc =>
      'Repite lotes previos fácilmente. Los tiempos de Kombucha se ajustan automáticamente según tus preferencias pasadas.';

  @override
  String get infoAdvancedDataTitle => 'Seguridad de Datos';

  @override
  String get infoAdvancedDataDesc =>
      'Usa las opciones de Exportar y Restaurar para mantener tus registros a salvo o moverlos de dispositivo.';
}

/// The translations for Spanish Castilian, as used in Netherlands Antilles (`es_AN`).
class AppLocalizationsEsAn extends AppLocalizationsEs {
  AppLocalizationsEsAn() : super('es_AN');

  @override
  String get appTitle => 'Kéfî Contrôh';

  @override
  String get accept => 'Açêttâh';

  @override
  String get cancel => 'Cançelâh';

  @override
  String get history => 'Îttoriâh';

  @override
  String get changeLanguage => 'Cambiâh idioma';

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeSystem => 'Çîttema';

  @override
  String get themeLight => 'Modo claro';

  @override
  String get themeDark => 'Modo ôccuro';

  @override
  String get drawerDonate => 'Imbítame a un café';

  @override
  String get drawerDonateSubtitle => 'Apoya el deçarroyo';

  @override
  String get historyTitle => 'Îttoriâh';

  @override
  String get homeSwipeDeleteHint => 'Dêl-liça una tarheta pa borrâl-la';

  @override
  String get historyEmpty => 'No ay fermentaçionê rehîttrâh.';

  @override
  String get historyClear => 'Limpiâh';

  @override
  String get historyClearTitle => 'Borrâh îttoriâh?';

  @override
  String get historyClearContent => 'Êtta aççiô no çe pue deçaçêh.';

  @override
  String get historyClearConfirm => 'Borrâh';

  @override
  String get homeNoActiveFermentationTitle => 'Çin fermentaçión âttiba';

  @override
  String get homeNoActiveFermentationDesc =>
      'Çelêççiona una ôççión der menú pa començâh.';

  @override
  String get homeEstimatedFinish => 'Tiempo êttimao';

  @override
  String get homeRemainingTime => 'Quedan';

  @override
  String get homeCompleted => 'Completao';

  @override
  String get homeStopTitle => 'Finaliçâh fermentaçión?';

  @override
  String get homeStopContent =>
      'Êttâh a punto de parâh er temporiçadôh. Açegúrate de colâh lô nódulô.';

  @override
  String get homeStopConfirm => 'Finaliçâh';

  @override
  String get btnStartFermentation => 'Iniçiâh fermentaçión';

  @override
  String get btnStartPastFermentation => 'Rehîttrâh fermentaçión paçá';

  @override
  String get btnStopFermentation => 'Finaliçâh fermentaçión';

  @override
  String get dialogManualTitle => 'Iniçiâh fermentaçión paçá';

  @override
  String get dialogManualDesc =>
      'Çeleççiona la fexa y ora a la que mêçclâtte la lexe con lô nódulô pa carculâh er progreço açttuâh y programâ l\'alarma.';

  @override
  String get dialogManualDate => 'Fexa d\'iniçio';

  @override
  String get dialogManualTime => 'Ora d\'iniçio';

  @override
  String get dialogManualDuration => 'Duraççiô objetibo';

  @override
  String get dialogManualBtnStart => 'Iniçiâh';

  @override
  String get dialogOption24h => '24 orâ';

  @override
  String get dialogOption36h => '36 orâ';

  @override
  String get dialogOption48h => '48 orâ';

  @override
  String get infoTitle => 'Informaçión y Guía';

  @override
  String get infoCard1Title => '🥛 ¿Qué êh er Kéfî de lexe?';

  @override
  String get infoCard1Desc =>
      'Er kéfî de lexe êh una bebía fermentá rica en probióticô que çe elabora añadiendo nódulô de kéfî a lexe entera a temperatura ambiente.';

  @override
  String get infoCard2Title => '⏱️ Tiempô de Fermentaçiôh';

  @override
  String get infoCard2Subtitle1 => '24 Orâ';

  @override
  String get infoCard2Desc1 =>
      'Çabô çuabe y conçîttençia líquida, pareçío a un yogûh pa bebêh con toquê durçê. Efêtto liheramente laçante. Ideâh çi la temperatura ambiente êh arta (>25ºC).';

  @override
  String get infoCard2Subtitle2 => '36 Orâ';

  @override
  String get infoCard2Desc2 =>
      'Er punto mâh equilibrao. Tettura mâ cremôça que çepara liheramente er çuero. Efêtto reguladô intêttinâh.';

  @override
  String get infoCard2Subtitle3 => '48 Orâ';

  @override
  String get infoCard2Desc3 =>
      'Çabôh áçido y fuerte. Er çuero formarâ una bôrça de líquido ebidente en la baçe. Efêtto âttrinhente. Recomendao çolo çi la temperatura ambiente êh mu baha o çe bûcca un kéfî curao.';

  @override
  String get infoCard3Title => 'Conçeho';

  @override
  String get infoCard3Desc =>
      'Ebita lô utençiliô de metâh ar colâh tû nódulô; uça cuxarâ y coladorê de pláttico o maera pa no dañâh lô microorganîmmô.';

  @override
  String get devDesc => 'Hêttiona tû fermentaçionê';

  @override
  String get notifReadyTitle => '¡Er kéfî êttá lîtto! 🥛';

  @override
  String notifReadyBody(Object hours) {
    return 'La fermentaççiô de $hours orâ a terminao. Êh ora de colâh lô nódulô y dîffrutâh de tu bebía probiótica.';
  }

  @override
  String get notifReminderTitle => 'Preparaççiô par Kéfî';

  @override
  String get notifReminderBody =>
      'Fartan 2 orâ pa terminâh. ¡Be preparando reçipientê limpiô!';

  @override
  String get infoTab1 => 'Guía';

  @override
  String get infoTab2 => 'Fermentô';

  @override
  String get infoTab3 => 'Abançao';

  @override
  String get infoProcessTitle => 'Er Proçeço der Kéfî';

  @override
  String get infoProcessStep1Title => 'Preparaçiôn';

  @override
  String get infoProcessStep1Desc =>
      'Çe introduçen lô nódulô de kéfî en lexe a te mperatura ambiente, preferibemente lexe entera (aunque tamié pue çê çemidênnatá o dênnatá).';

  @override
  String get infoProcessStep2Title => 'Fermentaçiôn (24h - 48h)';

  @override
  String get infoProcessStep2Desc =>
      'Lô microorganîmmô conçumen la lâttoça de la lexe, trâfformándola en áçido láttico (lo que le da çu çabô áçido), dióççido de carbono y otrô compuêttô benefiçioçô. A mayôh tiempo, mâh êppeço y áçido çe buerbe.';

  @override
  String get infoProcessStep3Title => 'Recoleççiôn';

  @override
  String get infoProcessStep3Desc =>
      'Çe cuela la mêccla con un coladôh no metálico. Er líquido reçurtante êh la bebía de kéfî lîtta pa conçumîh, y lô nódulô recuperáô çe buerben a introduçîh en nueba lexe pa repetîh er çiclo.';

  @override
  String get infoGuideTitle => 'Cómo uçâh Kéfî Contrôh';

  @override
  String get infoGuideDesc =>
      'Êtta aplicaçión êttá diçeñá p\'ayuarte a yebâ un contrôh preçiço de lô tiêmppô de tû fermentaçionê, ebitando que tu kéfî çe buerba êççeçibamente áçido por orbío.';

  @override
  String get infoGuideStep1Title => 'Iniçiâh Fermentaçiôn Ahora';

  @override
  String get infoGuideStep1Desc =>
      'Purça êtte botón hûtto dêppuêh de mêcclâh la lexe con lô nódulô. Te pedirâ que elihâ cuánto tiempo quierê que fermente (24, 36 o 48 orâ). La âpp programarâ una alarma automática.';

  @override
  String get infoGuideStep2Title => 'Rehîttrâh Fermentaçión Paçá';

  @override
  String get infoGuideStep2Desc =>
      'Çe te orbidó dâl-le ar botôn cuando preparâtte er kéfî êtta mañana? No paça ná. Uça êtta oppçiôn pa indicâ a qué ora (y día) êççâtta içîtte la mêccla en la bida reâh. La âpp carculará er tiempo trâccurrío dêdde entonçê.';

  @override
  String get infoGuideStep3Title => 'Notificaçionê';

  @override
  String get infoGuideStep3Desc =>
      'Puê çerrâ la aplicaçión çin miedo. Cuando er tiempo ôhhetibo çe arcançe, reçibirâh una notificaçión en tu dîppoçitibo abiçándote de que êh ora de colâh er kéfî.';

  @override
  String get infoGuideStep4Title => 'Finaliçâh Fermentaçión';

  @override
  String get infoGuideStep4Desc =>
      'Purça êtte botón roho una bêh ayâ colao er kéfî pa limpiâh er temporiçadôh y dehâh la aplicaçión lîtta pa tu próççima recolêççión.';

  @override
  String get infoGuideStepHarvestTitle => 'Coçexâh y Reiniçiâh';

  @override
  String get infoGuideStepHarvestDesc =>
      'Cuando terminê un lote, uça êtte nuebo fluho pa guardâl-lo e iniçiâh er çigiente çiclo îmmediatamente con un çolo toque.';

  @override
  String get infoGuideStepAdjustTitle => 'Ahûttâh Tiempô';

  @override
  String get infoGuideStepAdjustDesc =>
      '¿Haçe mâ calô de lo normâh? Purça çobre er progreço de cuarquiêh fermentaçión âttiba pa acortâh o alargâh çu duraçión.';

  @override
  String get historyDeleted => 'Rehîttro eliminao';

  @override
  String historyItemTitle(Object hours) {
    return 'Fermentaçión ${hours}h';
  }

  @override
  String historyItemStart(Object date) {
    return 'Iniçio: $date';
  }

  @override
  String historyItemEnd(Object date) {
    return 'Fin: $date';
  }

  @override
  String get timeDays => 'DÍÂ';

  @override
  String get timeHours => 'ORÂ';

  @override
  String get timeMinutes => 'MINUTÔ';

  @override
  String get timeSeconds => 'ÇEGUNDÔ';

  @override
  String get timelineStart => 'Iniçio';

  @override
  String get timelineEnd => 'Fin';

  @override
  String get step0Title => 'Etapa láttea';

  @override
  String get step0Desc =>
      'La lexe êttá infuçionándoçe y empeçando a êppeçâh liheramente.';

  @override
  String get step1Title => 'Iniçiando fermentaçión';

  @override
  String get step1Desc =>
      'Er kéfî comiença a tomâh forma con una açidêh çuabe.';

  @override
  String get step2Title => 'Fermentaçión ideâh';

  @override
  String get step2Desc =>
      'Momento perfêtto pa la mayoría de lô gûttô. Têttura cremoça.';

  @override
  String get step3Title => 'Fermentaçión fuerte';

  @override
  String get step3Desc =>
      'Çabôh mâh pronunçiao. Puede empeçâh a çepararçe er çuero.';

  @override
  String get step4Title => 'Mu áçido';

  @override
  String get step4Desc =>
      'Çabôh mu agreçibo. Ideâh pa reçetâ que requieran açidêh fuerte.';

  @override
  String get addSheetTitle => '¿Qué bâ a fermentâh?';

  @override
  String get addSheetKefir => 'Kéfî de Lexe';

  @override
  String get addSheetKombucha => 'Kombuxa';

  @override
  String get notifReadyTitleKombucha => 'Kombuxa Lîtta';

  @override
  String get notifReadyTitleKefir => 'Kéfî Lîtto';

  @override
  String get notifReadyBodyGeneric => 'Tu fermentaçión a finaliçao';

  @override
  String get notifReminderTitleGeneric => 'Recordatorio';

  @override
  String get notifReminderBodyGeneric => 'Fartan 2 orâ pa terminâh';

  @override
  String get addSheetPastRecord => 'Rehîttrâh fermentaçión paçá';

  @override
  String addSheetPastSelected(Object date) {
    return 'Iniçio: $date\nAhora elihe la duraçión';
  }

  @override
  String get addSheetTimeKefir => 'Tiempo pa Kéfî';

  @override
  String addSheetHours(Object hours) {
    return '$hours Orâ';
  }

  @override
  String get addSheetTimeKombucha => 'Tiempo pa Kombuxa';

  @override
  String addSheetIdealTime(Object days) {
    return 'Tu tiempo ideâ ($days díâh)';
  }

  @override
  String addSheetDays(Object days) {
    return '$days Díâ';
  }

  @override
  String get cardTranscurrido => 'Trâccurrío';

  @override
  String get cardRestante => 'Rêttante';

  @override
  String get cardCosechar => 'Coçexâh';

  @override
  String get cardFinalizar => 'Finaliçâh';

  @override
  String get homeHarvestKombuchaTitle => 'Coçexâh Kombuxa';

  @override
  String get homeHarvestKombuchaDesc =>
      '¿Deçeâ memoriçâh êtte tiempo êççâtto como tu tiempo ideâh pa futurâ fermentaçionê?';

  @override
  String get homeHarvestOnly => 'Çolo coçexâh';

  @override
  String get homeHarvestAndSave => 'Coçexâh y Guardâh';

  @override
  String get homeDeleteTitle => '¿Eliminâh fermentaçión?';

  @override
  String get homeDeleteDesc =>
      'Çi eliminâ êtta tarheta, er proçeço çe dêccartará y no çe guardará en l\'ittoriâh.';

  @override
  String get homeDeleteBtn => 'Eliminâh';

  @override
  String get homeNewFermentation => 'Nueba fermentaçión';

  @override
  String get historyKombuchaFinished => 'Kombuxa coçexá';

  @override
  String historyKombuchaDuration(Object days) {
    return 'Duraçión: $days díâ';
  }

  @override
  String get stageKombucha0 => 'Formaçión iniçiâh';

  @override
  String get stageKombucha1 => 'Liheramente durçe';

  @override
  String get stageKombucha2 => 'Equilibrá (Ideâh)';

  @override
  String get stageKombucha3 => 'Fuerte/Áçida';

  @override
  String get stageKombucha4 => 'Abinagrá';

  @override
  String get historyKefirFinished => 'Kéfî coçexao';

  @override
  String historyCompletedPercent(Object percent) {
    return 'Completao: $percent%';
  }

  @override
  String historyDurationDays(Object days) {
    return '$days díâ';
  }

  @override
  String historyDurationDaysHours(Object days, Object hours) {
    return '$days díâ y ${hours}h';
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
  String get historyHarvestDate => 'Fexa de coçexa';

  @override
  String historyRealDurationTarget(Object actual, Object target) {
    return 'Duraçión: $actual (objetibo $target)';
  }

  @override
  String historyCompletedOn(Object date) {
    return 'Completao er $date';
  }

  @override
  String get historyItemDeleteTitle => '¿Eliminâh rehîttro?';

  @override
  String get historyItemDeleteContent =>
      'Êtte rehîttro çe borrará de forma permanente.';

  @override
  String get drawerDataManagement => 'Hêttión de datô';

  @override
  String get drawerBackup => 'Êpportâh copia';

  @override
  String get drawerRestore => 'Rêttaurâh copia';

  @override
  String get backupSuccessTitle => 'Copia êpportá';

  @override
  String get backupSuccessDesc => 'Lô datô çe an guardao con éççito.';

  @override
  String get restoreSuccessTitle => 'Copia rêttaurá';

  @override
  String get restoreSuccessDesc => 'Lô datô an buerto a la mahia.';

  @override
  String get restoreErrorTitle => 'Errôh';

  @override
  String get restoreErrorDesc => 'El arxibo êh imbálido o êttá corrûtto.';

  @override
  String addSheetIdealTimeKefir(num hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String hoursString = hoursNumberFormat.format(hours);

    return 'Tu tiempo ideâh (${hoursString}h)';
  }

  @override
  String get addSheetCustomTime => 'Tiempo perçonaliçao';

  @override
  String get addSheetNoLimit => 'Çin límite';

  @override
  String get addSheetCustomHours => 'Orâ';

  @override
  String get addSheetCustomDays => 'Díâ';

  @override
  String get addSheetCustomConfirm => 'Uçâh êtte tiempo';

  @override
  String get cardNoLimit => 'Çin límite';

  @override
  String get cardOpenEndedStage => 'Modo êpperimentâh';

  @override
  String get addSheetNameHint => 'Nombre der lote (ôççionâh)';

  @override
  String get cardRenameTitle => 'Renombrâh';

  @override
  String get cardRenameHint => 'Nombre der lote';

  @override
  String get drawerCalendar => 'Calendario';

  @override
  String get calendarTitle => 'Mî Fermentaçionê';

  @override
  String get calendarNoFermentations => 'Çin fermentaçionê êtte día';

  @override
  String get calendarActiveBadge => 'Âttiba';

  @override
  String get calendarPlannedBadge => 'Planificá';

  @override
  String get calendarPlanButton => 'Planificâh pa êtte día';

  @override
  String get cardStartsIn => 'Comiença en';

  @override
  String get detailStartDate => 'Iniçio';

  @override
  String get detailStageKombucha0Desc =>
      'Er SCOBY êttá dêppertando. La bebida çige çiendo prátticamente té durçe.';

  @override
  String get detailStageKombucha1Desc =>
      'La fermentaçión abança con çuabidá. Aún predomina er durçôh con un lihero toque áçido.';

  @override
  String get detailStageKombucha2Desc =>
      'Er punto de equilibrio perfêtto entre durçura y açidêh. Ideâh pa la mayoría de paladarê.';

  @override
  String get detailStageKombucha3Desc =>
      'Açidêh pronunçiá y çabôh compleho. Âtto pa quienê prefieren un çabôh intenço.';

  @override
  String get detailStageKombucha4Desc =>
      'Fermentaçión mu abançá. Çabôh abinagrao intenço, mâh âtto pa uço culinario.';

  @override
  String get detailNotesTitle => 'Notâ';

  @override
  String get detailNotesHint =>
      'Añade detayê çobre la lexe, temperatura, ettç...';

  @override
  String get detailHistoryTitle => 'Îttoriâh Reçiente';

  @override
  String get detailHistoryEmpty => 'Çin coçexâ prebiâ';

  @override
  String detailHistoryLastHarvest(Object duration) {
    return 'Úrtima tanda: $duration';
  }

  @override
  String get historyRepeat => 'Repetîh lote';

  @override
  String get adjSheetTitle => 'Ahûttâh tiempo';

  @override
  String get adjSheetSetNoLimit => 'Paçâh a \'Çin límite\'';

  @override
  String get adjSheetSetTimed => 'Êttableçêh duraçión';

  @override
  String get actionSaveIdealTime => 'Guardâh tiempo ideâh';

  @override
  String get actionSaveIdealTimeSuccess => 'Tiempo ideâh guardao corrêttamente';

  @override
  String get dialogSaveIdealConfirm =>
      '¿Guardâh êtte tiempo como tu referençia ideâh?';

  @override
  String get actionHarvestAndRestart => 'Coçexâh y reiniçiâh';

  @override
  String get dialogHarvestAndRestartConfirm =>
      '¿Coçexâh lote âttuâh y empeçâh uno nuebo?';

  @override
  String get harvestNextStepTitle => 'Çigiente çiclo';

  @override
  String get actionDelete => 'Borrâh';

  @override
  String get dialogResetConfirm =>
      'Çe guardará en el îttoriâh y er contadôh borberá a 0.';

  @override
  String secondFermentationName(Object name) {
    return 'F2: $name';
  }

  @override
  String get secondFermentationDefaultName => 'Çegunda Fermentaçión';

  @override
  String get infoKombuchaTitle => '🍵 ¿Qué êh la Kombuxa?';

  @override
  String get infoKombuchaDesc =>
      'Êh té fermentao mediante una colonia çimbiótica de bâtteriâ y lebadurâ (SCOBY). Êh rica en áçíô orgánicô y bitaminâ.';

  @override
  String get infoKombuchaProcessTitle => 'Er Ciclo de la Kombuxa';

  @override
  String get infoKombuchaStep1Title => 'Preparaçión';

  @override
  String get infoKombuchaStep1Desc =>
      'Çe infuçiona té con açúcâ y, una bêh frío, çe añade er SCOBY con un poco de líquido iniçiadôh der lote anteriôh.';

  @override
  String get infoKombuchaStep2Title => 'Fermentaçión (7-12 díâ)';

  @override
  String get infoKombuchaStep2Desc =>
      'Er SCOBY conçume el açúcâ y er té. La âpp aprenderá de tû coçexâ pa çuherirte  tu \'Tiempo Ideâ\' perçonaliçao.';

  @override
  String get infoAdvancedCalendarTitle => 'Calendario';

  @override
  String get infoAdvancedCalendarDesc =>
      'Biçualiça tû coçexâ paçâh y planifica futurâ preparaçionê dêdde la pêttaña de Calendario.';

  @override
  String get infoAdvancedHistoryTitle => 'Îttoriâh';

  @override
  String get infoAdvancedHistoryDesc =>
      'Repite lotê prebiô fáçirmente. Lô tiempô de Kombuxa çe ahûttan automáticamente çegún tû preferençiâ paçâh.';

  @override
  String get infoAdvancedDataTitle => 'Çeguridá de Datô';

  @override
  String get infoAdvancedDataDesc =>
      'Uça lâ ôççionê de Êpportâh y Rêttaurâh pa mantenêh tû rehîttrô a çarbo o mobêl-lô de dîppoçitibo.';
}
