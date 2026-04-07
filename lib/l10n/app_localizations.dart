import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Kéfir Control'**
  String get appTitle;

  /// No description provided for @accept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get accept;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @history.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get history;

  /// No description provided for @changeLanguage.
  ///
  /// In es, this message translates to:
  /// **'Cambiar idioma'**
  String get changeLanguage;

  /// No description provided for @drawerDonate.
  ///
  /// In es, this message translates to:
  /// **'Invítame a un café'**
  String get drawerDonate;

  /// No description provided for @drawerDonateSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Apoya el desarrollo'**
  String get drawerDonateSubtitle;

  /// No description provided for @historyTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay fermentaciones registradas.'**
  String get historyEmpty;

  /// No description provided for @historyClear.
  ///
  /// In es, this message translates to:
  /// **'Limpiar'**
  String get historyClear;

  /// No description provided for @historyClearTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar historial?'**
  String get historyClearTitle;

  /// No description provided for @historyClearContent.
  ///
  /// In es, this message translates to:
  /// **'Esta acción no se puede deshacer.'**
  String get historyClearContent;

  /// No description provided for @historyClearConfirm.
  ///
  /// In es, this message translates to:
  /// **'Borrar'**
  String get historyClearConfirm;

  /// No description provided for @homeNoActiveFermentationTitle.
  ///
  /// In es, this message translates to:
  /// **'Sin fermentación activa'**
  String get homeNoActiveFermentationTitle;

  /// No description provided for @homeNoActiveFermentationDesc.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una opción del menú para comenzar.'**
  String get homeNoActiveFermentationDesc;

  /// No description provided for @homeEstimatedFinish.
  ///
  /// In es, this message translates to:
  /// **'Tiempo estimado'**
  String get homeEstimatedFinish;

  /// No description provided for @homeRemainingTime.
  ///
  /// In es, this message translates to:
  /// **'Quedan'**
  String get homeRemainingTime;

  /// No description provided for @homeCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completado'**
  String get homeCompleted;

  /// No description provided for @homeStopTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Finalizar fermentación?'**
  String get homeStopTitle;

  /// No description provided for @homeStopContent.
  ///
  /// In es, this message translates to:
  /// **'Estás a punto de parar el temporizador. Asegúrate de colar los nódulos.'**
  String get homeStopContent;

  /// No description provided for @homeStopConfirm.
  ///
  /// In es, this message translates to:
  /// **'Finalizar'**
  String get homeStopConfirm;

  /// No description provided for @btnStartFermentation.
  ///
  /// In es, this message translates to:
  /// **'Iniciar fermentación'**
  String get btnStartFermentation;

  /// No description provided for @btnStartPastFermentation.
  ///
  /// In es, this message translates to:
  /// **'Registrar fermentación pasada'**
  String get btnStartPastFermentation;

  /// No description provided for @btnStopFermentation.
  ///
  /// In es, this message translates to:
  /// **'Finalizar fermentación'**
  String get btnStopFermentation;

  /// No description provided for @dialogManualTitle.
  ///
  /// In es, this message translates to:
  /// **'Iniciar fermentación pasada'**
  String get dialogManualTitle;

  /// No description provided for @dialogManualDesc.
  ///
  /// In es, this message translates to:
  /// **'Selecciona la fecha y hora a la que mezclaste la leche con los nódulos para calcular el progreso actual y programar la alarma.'**
  String get dialogManualDesc;

  /// No description provided for @dialogManualDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de inicio'**
  String get dialogManualDate;

  /// No description provided for @dialogManualTime.
  ///
  /// In es, this message translates to:
  /// **'Hora de inicio'**
  String get dialogManualTime;

  /// No description provided for @dialogManualDuration.
  ///
  /// In es, this message translates to:
  /// **'Duración objetivo'**
  String get dialogManualDuration;

  /// No description provided for @dialogManualBtnStart.
  ///
  /// In es, this message translates to:
  /// **'Iniciar'**
  String get dialogManualBtnStart;

  /// No description provided for @dialogOption24h.
  ///
  /// In es, this message translates to:
  /// **'24 horas'**
  String get dialogOption24h;

  /// No description provided for @dialogOption36h.
  ///
  /// In es, this message translates to:
  /// **'36 horas'**
  String get dialogOption36h;

  /// No description provided for @dialogOption48h.
  ///
  /// In es, this message translates to:
  /// **'48 horas'**
  String get dialogOption48h;

  /// No description provided for @infoTitle.
  ///
  /// In es, this message translates to:
  /// **'Información y Guía'**
  String get infoTitle;

  /// No description provided for @infoCard1Title.
  ///
  /// In es, this message translates to:
  /// **'🥛 ¿Qué es el Kéfir de leche?'**
  String get infoCard1Title;

  /// No description provided for @infoCard1Desc.
  ///
  /// In es, this message translates to:
  /// **'El kéfir de leche es una bebida fermentada rica en probióticos que se elabora añadiendo nódulos de kéfir a leche entera a temperatura ambiente.'**
  String get infoCard1Desc;

  /// No description provided for @infoCard2Title.
  ///
  /// In es, this message translates to:
  /// **'⏱️ Tiempos de Fermentación'**
  String get infoCard2Title;

  /// No description provided for @infoCard2Subtitle1.
  ///
  /// In es, this message translates to:
  /// **'24 Horas'**
  String get infoCard2Subtitle1;

  /// No description provided for @infoCard2Desc1.
  ///
  /// In es, this message translates to:
  /// **'Sabor suave y consistencia líquida, parecido a un yogur para beber con toques dulces. Efecto ligeramente laxante. Ideal si la temperatura ambiente es alta (>25ºC).'**
  String get infoCard2Desc1;

  /// No description provided for @infoCard2Subtitle2.
  ///
  /// In es, this message translates to:
  /// **'36 Horas'**
  String get infoCard2Subtitle2;

  /// No description provided for @infoCard2Desc2.
  ///
  /// In es, this message translates to:
  /// **'El punto más equilibrado. Textura más cremosa que separa ligeramente el suero. Efecto regulador intestinal.'**
  String get infoCard2Desc2;

  /// No description provided for @infoCard2Subtitle3.
  ///
  /// In es, this message translates to:
  /// **'48 Horas'**
  String get infoCard2Subtitle3;

  /// No description provided for @infoCard2Desc3.
  ///
  /// In es, this message translates to:
  /// **'Sabor ácido y fuerte. El suero formará una bolsa de líquido evidente en la base. Efecto astringente. Recomendado solo si la temperatura ambiente es muy baja o se busca un kéfir curado.'**
  String get infoCard2Desc3;

  /// No description provided for @infoCard3Title.
  ///
  /// In es, this message translates to:
  /// **'Consejo'**
  String get infoCard3Title;

  /// No description provided for @infoCard3Desc.
  ///
  /// In es, this message translates to:
  /// **'Evita los utensilios de metal al colar tus nódulos; usa cucharas y coladores de plástico o madera para no dañar los microorganismos.'**
  String get infoCard3Desc;

  /// No description provided for @devDesc.
  ///
  /// In es, this message translates to:
  /// **'Gestiona tus fermentaciones'**
  String get devDesc;

  /// No description provided for @notifReadyTitle.
  ///
  /// In es, this message translates to:
  /// **'¡El kéfir está listo! 🥛'**
  String get notifReadyTitle;

  /// No description provided for @notifReadyBody.
  ///
  /// In es, this message translates to:
  /// **'La fermentación de {hours} horas ha terminado. Es hora de colar los nódulos y disfrutar de tu bebida probiótica.'**
  String notifReadyBody(Object hours);

  /// No description provided for @notifReminderTitle.
  ///
  /// In es, this message translates to:
  /// **'Preparación para el Kéfir'**
  String get notifReminderTitle;

  /// No description provided for @notifReminderBody.
  ///
  /// In es, this message translates to:
  /// **'Faltan 2 horas para terminar. ¡Ve preparando recipientes limpios!'**
  String get notifReminderBody;

  /// No description provided for @infoTab1.
  ///
  /// In es, this message translates to:
  /// **'Sobre el Kéfir'**
  String get infoTab1;

  /// No description provided for @infoTab2.
  ///
  /// In es, this message translates to:
  /// **'Guía de la App'**
  String get infoTab2;

  /// No description provided for @infoProcessTitle.
  ///
  /// In es, this message translates to:
  /// **'El Proceso de Fermentación'**
  String get infoProcessTitle;

  /// No description provided for @infoProcessStep1Title.
  ///
  /// In es, this message translates to:
  /// **'Preparación'**
  String get infoProcessStep1Title;

  /// No description provided for @infoProcessStep1Desc.
  ///
  /// In es, this message translates to:
  /// **'Se introducen los nódulos de kéfir en leche a temperatura ambiente, preferiblemente leche entera (aunque también puede ser semidesnatada o desnatada).'**
  String get infoProcessStep1Desc;

  /// No description provided for @infoProcessStep2Title.
  ///
  /// In es, this message translates to:
  /// **'Fermentación (24h - 48h)'**
  String get infoProcessStep2Title;

  /// No description provided for @infoProcessStep2Desc.
  ///
  /// In es, this message translates to:
  /// **'Los microorganismos consumen la lactosa de la leche, transformándola en ácido láctico (lo que le da su sabor ácido), dióxido de carbono y otros compuestos beneficiosos. A mayor tiempo, más espeso y ácido se vuelve.'**
  String get infoProcessStep2Desc;

  /// No description provided for @infoProcessStep3Title.
  ///
  /// In es, this message translates to:
  /// **'Recolección'**
  String get infoProcessStep3Title;

  /// No description provided for @infoProcessStep3Desc.
  ///
  /// In es, this message translates to:
  /// **'Se cuela la mezcla con un colador no metálico. El líquido resultante es la bebida de kéfir lista para consumir, y los nódulos recuperados se vuelven a introducir en nueva leche para repetir el ciclo.'**
  String get infoProcessStep3Desc;

  /// No description provided for @infoGuideTitle.
  ///
  /// In es, this message translates to:
  /// **'Cómo usar Kéfir Control'**
  String get infoGuideTitle;

  /// No description provided for @infoGuideDesc.
  ///
  /// In es, this message translates to:
  /// **'Esta aplicación está diseñada para ayudarte a llevar un control preciso de los tiempos de tus fermentaciones, evitando que tu kéfir se vuelva excesivamente ácido por olvido.'**
  String get infoGuideDesc;

  /// No description provided for @infoGuideStep1Title.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Fermentación Ahora'**
  String get infoGuideStep1Title;

  /// No description provided for @infoGuideStep1Desc.
  ///
  /// In es, this message translates to:
  /// **'Pulsa este botón justo después de mezclar la leche con los nódulos. Te pedirá que elijas cuánto tiempo quieres que fermente (24, 36 o 48 horas). La app programará una alarma automática.'**
  String get infoGuideStep1Desc;

  /// No description provided for @infoGuideStep2Title.
  ///
  /// In es, this message translates to:
  /// **'Registrar Fermentación Pasada'**
  String get infoGuideStep2Title;

  /// No description provided for @infoGuideStep2Desc.
  ///
  /// In es, this message translates to:
  /// **'¿Se te olvidó darle al botón cuando preparaste el kéfir esta mañana? No pasa nada. Usa esta opción para indicar a qué hora (y día) exacta hiciste la mezcla en la vida real. La app calculará el tiempo transcurrido desde entonces.'**
  String get infoGuideStep2Desc;

  /// No description provided for @infoGuideStep3Title.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get infoGuideStep3Title;

  /// No description provided for @infoGuideStep3Desc.
  ///
  /// In es, this message translates to:
  /// **'Puedes cerrar la aplicación sin miedo. Cuando el tiempo objetivo se alcance, recibirás una notificación en tu dispositivo avisándote de que es hora de colar el kéfir.'**
  String get infoGuideStep3Desc;

  /// No description provided for @infoGuideStep4Title.
  ///
  /// In es, this message translates to:
  /// **'Finalizar Fermentación'**
  String get infoGuideStep4Title;

  /// No description provided for @infoGuideStep4Desc.
  ///
  /// In es, this message translates to:
  /// **'Pulsa este botón rojo una vez hayas colado el kéfir para limpiar el temporizador y dejar la aplicación lista para tu próxima recolección.'**
  String get infoGuideStep4Desc;

  /// No description provided for @historyDeleted.
  ///
  /// In es, this message translates to:
  /// **'Registro eliminado'**
  String get historyDeleted;

  /// No description provided for @historyItemTitle.
  ///
  /// In es, this message translates to:
  /// **'Fermentación {hours}h'**
  String historyItemTitle(Object hours);

  /// No description provided for @historyItemStart.
  ///
  /// In es, this message translates to:
  /// **'Inicio: {date}'**
  String historyItemStart(Object date);

  /// No description provided for @historyItemEnd.
  ///
  /// In es, this message translates to:
  /// **'Fin: {date}'**
  String historyItemEnd(Object date);

  /// No description provided for @timeDays.
  ///
  /// In es, this message translates to:
  /// **'DÍAS'**
  String get timeDays;

  /// No description provided for @timeHours.
  ///
  /// In es, this message translates to:
  /// **'HORAS'**
  String get timeHours;

  /// No description provided for @timeMinutes.
  ///
  /// In es, this message translates to:
  /// **'MINUTOS'**
  String get timeMinutes;

  /// No description provided for @timeSeconds.
  ///
  /// In es, this message translates to:
  /// **'SEGUNDOS'**
  String get timeSeconds;

  /// No description provided for @timelineStart.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get timelineStart;

  /// No description provided for @timelineEnd.
  ///
  /// In es, this message translates to:
  /// **'Fin'**
  String get timelineEnd;

  /// No description provided for @step0Title.
  ///
  /// In es, this message translates to:
  /// **'Etapa láctea'**
  String get step0Title;

  /// No description provided for @step0Desc.
  ///
  /// In es, this message translates to:
  /// **'La leche está infusionándose y empezando a espesar ligeramente.'**
  String get step0Desc;

  /// No description provided for @step1Title.
  ///
  /// In es, this message translates to:
  /// **'Iniciando fermentación'**
  String get step1Title;

  /// No description provided for @step1Desc.
  ///
  /// In es, this message translates to:
  /// **'El kéfir comienza a tomar forma con una acidez suave.'**
  String get step1Desc;

  /// No description provided for @step2Title.
  ///
  /// In es, this message translates to:
  /// **'Fermentación ideal'**
  String get step2Title;

  /// No description provided for @step2Desc.
  ///
  /// In es, this message translates to:
  /// **'Momento perfecto para la mayoría de los gustos. Textura cremosa.'**
  String get step2Desc;

  /// No description provided for @step3Title.
  ///
  /// In es, this message translates to:
  /// **'Fermentación fuerte'**
  String get step3Title;

  /// No description provided for @step3Desc.
  ///
  /// In es, this message translates to:
  /// **'Sabor más pronunciado. Puede empezar a separarse el suero.'**
  String get step3Desc;

  /// No description provided for @step4Title.
  ///
  /// In es, this message translates to:
  /// **'Muy ácido'**
  String get step4Title;

  /// No description provided for @step4Desc.
  ///
  /// In es, this message translates to:
  /// **'Sabor muy agresivo. Ideal para recetas que requieran acidez fuerte.'**
  String get step4Desc;

  /// No description provided for @addSheetTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Qué vas a fermentar?'**
  String get addSheetTitle;

  /// No description provided for @addSheetKefir.
  ///
  /// In es, this message translates to:
  /// **'Kéfir de Leche'**
  String get addSheetKefir;

  /// No description provided for @addSheetKombucha.
  ///
  /// In es, this message translates to:
  /// **'Kombucha'**
  String get addSheetKombucha;

  /// No description provided for @notifReadyTitleKombucha.
  ///
  /// In es, this message translates to:
  /// **'Kombucha Lista'**
  String get notifReadyTitleKombucha;

  /// No description provided for @notifReadyTitleKefir.
  ///
  /// In es, this message translates to:
  /// **'Kéfir Listo'**
  String get notifReadyTitleKefir;

  /// No description provided for @notifReadyBodyGeneric.
  ///
  /// In es, this message translates to:
  /// **'Tu fermentación ha finalizado'**
  String get notifReadyBodyGeneric;

  /// No description provided for @notifReminderTitleGeneric.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio'**
  String get notifReminderTitleGeneric;

  /// No description provided for @notifReminderBodyGeneric.
  ///
  /// In es, this message translates to:
  /// **'Faltan 2 horas para terminar'**
  String get notifReminderBodyGeneric;

  /// No description provided for @addSheetPastRecord.
  ///
  /// In es, this message translates to:
  /// **'Registrar fermentación pasada'**
  String get addSheetPastRecord;

  /// No description provided for @addSheetPastSelected.
  ///
  /// In es, this message translates to:
  /// **'Inicio: {date}\nAhora elige la duración'**
  String addSheetPastSelected(Object date);

  /// No description provided for @addSheetTimeKefir.
  ///
  /// In es, this message translates to:
  /// **'Tiempo para Kéfir'**
  String get addSheetTimeKefir;

  /// No description provided for @addSheetHours.
  ///
  /// In es, this message translates to:
  /// **'{hours} Horas'**
  String addSheetHours(Object hours);

  /// No description provided for @addSheetTimeKombucha.
  ///
  /// In es, this message translates to:
  /// **'Tiempo para Kombucha'**
  String get addSheetTimeKombucha;

  /// No description provided for @addSheetIdealTime.
  ///
  /// In es, this message translates to:
  /// **'Tu tiempo ideal ({days} días)'**
  String addSheetIdealTime(Object days);

  /// No description provided for @addSheetDays.
  ///
  /// In es, this message translates to:
  /// **'{days} Días'**
  String addSheetDays(Object days);

  /// No description provided for @cardTranscurrido.
  ///
  /// In es, this message translates to:
  /// **'Transcurrido'**
  String get cardTranscurrido;

  /// No description provided for @cardRestante.
  ///
  /// In es, this message translates to:
  /// **'Restante'**
  String get cardRestante;

  /// No description provided for @cardCosechar.
  ///
  /// In es, this message translates to:
  /// **'Cosechar'**
  String get cardCosechar;

  /// No description provided for @cardFinalizar.
  ///
  /// In es, this message translates to:
  /// **'Finalizar'**
  String get cardFinalizar;

  /// No description provided for @homeHarvestKombuchaTitle.
  ///
  /// In es, this message translates to:
  /// **'Cosechar Kombucha'**
  String get homeHarvestKombuchaTitle;

  /// No description provided for @homeHarvestKombuchaDesc.
  ///
  /// In es, this message translates to:
  /// **'¿Deseas memorizar este tiempo exacto como tu tiempo ideal para futuras fermentaciones?'**
  String get homeHarvestKombuchaDesc;

  /// No description provided for @homeHarvestOnly.
  ///
  /// In es, this message translates to:
  /// **'Solo cosechar'**
  String get homeHarvestOnly;

  /// No description provided for @homeHarvestAndSave.
  ///
  /// In es, this message translates to:
  /// **'Cosechar y Guardar'**
  String get homeHarvestAndSave;

  /// No description provided for @homeDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar fermentación?'**
  String get homeDeleteTitle;

  /// No description provided for @homeDeleteDesc.
  ///
  /// In es, this message translates to:
  /// **'Si eliminas esta tarjeta, el proceso se descartará y no se guardará en el historial.'**
  String get homeDeleteDesc;

  /// No description provided for @homeDeleteBtn.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get homeDeleteBtn;

  /// No description provided for @homeNewFermentation.
  ///
  /// In es, this message translates to:
  /// **'Nueva fermentación'**
  String get homeNewFermentation;

  /// No description provided for @historyKombuchaFinished.
  ///
  /// In es, this message translates to:
  /// **'Kombucha cosechada'**
  String get historyKombuchaFinished;

  /// No description provided for @historyKombuchaDuration.
  ///
  /// In es, this message translates to:
  /// **'Duración: {days} días'**
  String historyKombuchaDuration(Object days);

  /// No description provided for @stageKombucha0.
  ///
  /// In es, this message translates to:
  /// **'Formación inicial'**
  String get stageKombucha0;

  /// No description provided for @stageKombucha1.
  ///
  /// In es, this message translates to:
  /// **'Ligeramente dulce'**
  String get stageKombucha1;

  /// No description provided for @stageKombucha2.
  ///
  /// In es, this message translates to:
  /// **'Equilibrada (Ideal)'**
  String get stageKombucha2;

  /// No description provided for @stageKombucha3.
  ///
  /// In es, this message translates to:
  /// **'Fuerte/Ácida'**
  String get stageKombucha3;

  /// No description provided for @stageKombucha4.
  ///
  /// In es, this message translates to:
  /// **'Avinagrada'**
  String get stageKombucha4;

  /// No description provided for @historyKefirFinished.
  ///
  /// In es, this message translates to:
  /// **'Kéfir cosechado'**
  String get historyKefirFinished;

  /// No description provided for @historyCompletedPercent.
  ///
  /// In es, this message translates to:
  /// **'Completado: {percent}%'**
  String historyCompletedPercent(Object percent);

  /// No description provided for @historyDurationDays.
  ///
  /// In es, this message translates to:
  /// **'{days} días'**
  String historyDurationDays(Object days);

  /// No description provided for @historyDurationDaysHours.
  ///
  /// In es, this message translates to:
  /// **'{days} días y {hours}h'**
  String historyDurationDaysHours(Object days, Object hours);

  /// No description provided for @historyDurationHours.
  ///
  /// In es, this message translates to:
  /// **'{hours}h'**
  String historyDurationHours(Object hours);

  /// No description provided for @historyDurationHoursMinutes.
  ///
  /// In es, this message translates to:
  /// **'{hours}h {minutes}m'**
  String historyDurationHoursMinutes(Object hours, Object minutes);

  /// No description provided for @historyHarvestDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de cosecha'**
  String get historyHarvestDate;

  /// No description provided for @historyRealDurationTarget.
  ///
  /// In es, this message translates to:
  /// **'Duración: {actual} (objetivo {target})'**
  String historyRealDurationTarget(Object actual, Object target);

  /// No description provided for @historyCompletedOn.
  ///
  /// In es, this message translates to:
  /// **'Completado el {date}'**
  String historyCompletedOn(Object date);

  /// No description provided for @historyItemDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar registro?'**
  String get historyItemDeleteTitle;

  /// No description provided for @historyItemDeleteContent.
  ///
  /// In es, this message translates to:
  /// **'Este registro se borrará de forma permanente.'**
  String get historyItemDeleteContent;

  /// No description provided for @drawerDataManagement.
  ///
  /// In es, this message translates to:
  /// **'Gestión de datos'**
  String get drawerDataManagement;

  /// No description provided for @drawerBackup.
  ///
  /// In es, this message translates to:
  /// **'Exportar copia'**
  String get drawerBackup;

  /// No description provided for @drawerRestore.
  ///
  /// In es, this message translates to:
  /// **'Restaurar copia'**
  String get drawerRestore;

  /// No description provided for @backupSuccessTitle.
  ///
  /// In es, this message translates to:
  /// **'Copia exportada'**
  String get backupSuccessTitle;

  /// No description provided for @backupSuccessDesc.
  ///
  /// In es, this message translates to:
  /// **'Los datos se han guardado con éxito.'**
  String get backupSuccessDesc;

  /// No description provided for @restoreSuccessTitle.
  ///
  /// In es, this message translates to:
  /// **'Copia restaurada'**
  String get restoreSuccessTitle;

  /// No description provided for @restoreSuccessDesc.
  ///
  /// In es, this message translates to:
  /// **'Los datos han vuelto a la magia.'**
  String get restoreSuccessDesc;

  /// No description provided for @restoreErrorTitle.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get restoreErrorTitle;

  /// No description provided for @restoreErrorDesc.
  ///
  /// In es, this message translates to:
  /// **'El archivo es inválido o está corrupto.'**
  String get restoreErrorDesc;

  /// No description provided for @addSheetIdealTimeKefir.
  ///
  /// In es, this message translates to:
  /// **'Tu tiempo ideal ({hours}h)'**
  String addSheetIdealTimeKefir(num hours);

  /// No description provided for @addSheetCustomTime.
  ///
  /// In es, this message translates to:
  /// **'Tiempo personalizado'**
  String get addSheetCustomTime;

  /// No description provided for @addSheetNoLimit.
  ///
  /// In es, this message translates to:
  /// **'Sin límite'**
  String get addSheetNoLimit;

  /// No description provided for @addSheetCustomHours.
  ///
  /// In es, this message translates to:
  /// **'Horas'**
  String get addSheetCustomHours;

  /// No description provided for @addSheetCustomDays.
  ///
  /// In es, this message translates to:
  /// **'Días'**
  String get addSheetCustomDays;

  /// No description provided for @addSheetCustomConfirm.
  ///
  /// In es, this message translates to:
  /// **'Usar este tiempo'**
  String get addSheetCustomConfirm;

  /// No description provided for @cardNoLimit.
  ///
  /// In es, this message translates to:
  /// **'Sin límite'**
  String get cardNoLimit;

  /// No description provided for @cardOpenEndedStage.
  ///
  /// In es, this message translates to:
  /// **'Modo experimental'**
  String get cardOpenEndedStage;

  /// No description provided for @addSheetNameHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre del lote (opcional)'**
  String get addSheetNameHint;

  /// No description provided for @cardRenameTitle.
  ///
  /// In es, this message translates to:
  /// **'Renombrar'**
  String get cardRenameTitle;

  /// No description provided for @cardRenameHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre del lote'**
  String get cardRenameHint;

  /// No description provided for @drawerCalendar.
  ///
  /// In es, this message translates to:
  /// **'Calendario'**
  String get drawerCalendar;

  /// No description provided for @calendarTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis Fermentaciones'**
  String get calendarTitle;

  /// No description provided for @calendarNoFermentations.
  ///
  /// In es, this message translates to:
  /// **'Sin fermentaciones este día'**
  String get calendarNoFermentations;

  /// No description provided for @calendarActiveBadge.
  ///
  /// In es, this message translates to:
  /// **'Activa'**
  String get calendarActiveBadge;

  /// No description provided for @calendarPlannedBadge.
  ///
  /// In es, this message translates to:
  /// **'Planificada'**
  String get calendarPlannedBadge;

  /// No description provided for @calendarPlanButton.
  ///
  /// In es, this message translates to:
  /// **'Planificar para este día'**
  String get calendarPlanButton;

  /// No description provided for @cardStartsIn.
  ///
  /// In es, this message translates to:
  /// **'Comienza en'**
  String get cardStartsIn;

  /// No description provided for @detailStartDate.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get detailStartDate;

  /// No description provided for @detailStageKombucha0Desc.
  ///
  /// In es, this message translates to:
  /// **'El SCOBY está despertando. La bebida sigue siendo prácticamente té dulce.'**
  String get detailStageKombucha0Desc;

  /// No description provided for @detailStageKombucha1Desc.
  ///
  /// In es, this message translates to:
  /// **'La fermentación avanza con suavidad. Aún predomina el dulzor con un ligero toque ácido.'**
  String get detailStageKombucha1Desc;

  /// No description provided for @detailStageKombucha2Desc.
  ///
  /// In es, this message translates to:
  /// **'El punto de equilibrio perfecto entre dulzura y acidez. Ideal para la mayoría de paladares.'**
  String get detailStageKombucha2Desc;

  /// No description provided for @detailStageKombucha3Desc.
  ///
  /// In es, this message translates to:
  /// **'Acidez pronunciada y sabor complejo. Apto para quienes prefieren un sabor intenso.'**
  String get detailStageKombucha3Desc;

  /// No description provided for @detailStageKombucha4Desc.
  ///
  /// In es, this message translates to:
  /// **'Fermentación muy avanzada. Sabor avinagrado intenso, más apto para uso culinario.'**
  String get detailStageKombucha4Desc;

  /// No description provided for @detailNotesTitle.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get detailNotesTitle;

  /// No description provided for @detailNotesHint.
  ///
  /// In es, this message translates to:
  /// **'Añade detalles sobre la leche, temperatura, etc...'**
  String get detailNotesHint;

  /// No description provided for @detailHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial Reciente'**
  String get detailHistoryTitle;

  /// No description provided for @detailHistoryEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin cosechas previas'**
  String get detailHistoryEmpty;

  /// No description provided for @detailHistoryLastHarvest.
  ///
  /// In es, this message translates to:
  /// **'Última tanda: {duration}'**
  String detailHistoryLastHarvest(Object duration);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
