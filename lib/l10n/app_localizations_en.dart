// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Kefir Control';

  @override
  String get accept => 'Accept';

  @override
  String get cancel => 'Cancel';

  @override
  String get history => 'History';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get drawerDonate => 'Buy me a coffee ☕';

  @override
  String get drawerDonateSubtitle => 'Support development via PayPal';

  @override
  String get historyTitle => 'History';

  @override
  String get historyEmpty => 'No past fermentations recorded.';

  @override
  String get historyClear => 'Clear';

  @override
  String get historyClearTitle => 'Clear history?';

  @override
  String get historyClearContent => 'This action cannot be undone.';

  @override
  String get historyClearConfirm => 'Clear';

  @override
  String get homeNoActiveFermentationTitle => 'No active fermentation';

  @override
  String get homeNoActiveFermentationDesc =>
      'Select an option from the menu below to start.';

  @override
  String get homeEstimatedFinish => 'Estimated finish';

  @override
  String get homeRemainingTime => 'Remaining';

  @override
  String get homeCompleted => 'Completed';

  @override
  String get homeStopTitle => 'Finish fermentation early?';

  @override
  String get homeStopContent =>
      'You are about to stop the timer. Make sure to strain the grains.';

  @override
  String get homeStopConfirm => 'Finish';

  @override
  String get btnStartFermentation => 'Start fermentation';

  @override
  String get btnStartPastFermentation => 'Record past fermentation';

  @override
  String get btnStopFermentation => 'Finish fermentation';

  @override
  String get dialogManualTitle => 'Start past fermentation';

  @override
  String get dialogManualDesc =>
      'Select the date and time when you mixed the milk with the grains to calculate the current progress and schedule the alarm.';

  @override
  String get dialogManualDate => 'Start Date';

  @override
  String get dialogManualTime => 'Start Time';

  @override
  String get dialogManualDuration => 'Target Duration';

  @override
  String get dialogManualBtnStart => 'Start';

  @override
  String get dialogOption24h => '24 hours';

  @override
  String get dialogOption36h => '36 hours';

  @override
  String get dialogOption48h => '48 hours';

  @override
  String get infoTitle => 'Information & Guide';

  @override
  String get infoCard1Title => '🥛 What is Milk Kefir?';

  @override
  String get infoCard1Desc =>
      'Milk kefir is a probiotic-rich fermented beverage made by adding kefir grains to whole milk at room temperature.';

  @override
  String get infoCard2Title => '⏱️ Fermentation Times';

  @override
  String get infoCard2Subtitle1 => '24 Hours';

  @override
  String get infoCard2Desc1 =>
      'Mild flavor and liquid consistency, similar to a drinking yogurt with sweet touches. Slightly laxative effect. Ideal if room temperature is high (>25ºC / 77ºF).';

  @override
  String get infoCard2Subtitle2 => '36 Hours';

  @override
  String get infoCard2Desc2 =>
      'The most balanced point. Creamier texture that slightly separates the whey. Intestinal regulating effect.';

  @override
  String get infoCard2Subtitle3 => '48 Hours';

  @override
  String get infoCard2Desc3 =>
      'Acidic and strong flavor. The whey will form an obvious pocket of liquid at the base. Astringent effect. Recommended only if room temperature is very low or if a cured kefir is desired.';

  @override
  String get infoCard3Title => 'Tip';

  @override
  String get infoCard3Desc =>
      'Avoid metal utensils when straining your grains; use plastic or wooden spoons and strainers to avoid damaging the microorganisms.';

  @override
  String get devDesc => 'Manage your kefir fermentations';

  @override
  String get notifReadyTitle => 'Kefir is ready! 🥛';

  @override
  String notifReadyBody(Object hours) {
    return 'The $hours hour fermentation is complete. It\'s time to strain the grains and enjoy your probiotic drink.';
  }

  @override
  String get notifReminderTitle => 'Kefir Preparation';

  @override
  String get notifReminderBody =>
      '2 hours left until completion. Start preparing clean containers!';

  @override
  String get infoTab1 => 'About Kefir';

  @override
  String get infoTab2 => 'App Guide';

  @override
  String get infoProcessTitle => 'The Fermentation Process';

  @override
  String get infoProcessStep1Title => 'Preparation';

  @override
  String get infoProcessStep1Desc =>
      'Kefir grains are introduced into milk at room temperature, preferably whole milk (although it can also be semi-skimmed or skimmed).';

  @override
  String get infoProcessStep2Title => 'Fermentation (24h - 48h)';

  @override
  String get infoProcessStep2Desc =>
      'Microorganisms consume the lactose in the milk, transforming it into lactic acid (which gives its sour taste), carbon dioxide, and other beneficial compounds. The longer it sits, the thicker and more acidic it becomes.';

  @override
  String get infoProcessStep3Title => 'Harvesting';

  @override
  String get infoProcessStep3Desc =>
      'Strain the mixture with a non-metallic strainer. The resulting liquid is the kefir beverage ready to consume, and the recovered grains are introduced back into fresh milk to repeat the cycle.';

  @override
  String get infoGuideTitle => 'How to use Kefir Control';

  @override
  String get infoGuideDesc =>
      'This application is designed to help you keep precise track of your fermentation times, preventing your kefir from becoming excessively acidic due to forgetting.';

  @override
  String get infoGuideStep1Title => 'Start Fermentation Now';

  @override
  String get infoGuideStep1Desc =>
      'Press this button right after mixing the milk with the grains. It will ask you to choose how long you want it to ferment (24, 36, or 48 hours). The app will schedule an automatic alarm.';

  @override
  String get infoGuideStep2Title => 'Record Past Fermentation';

  @override
  String get infoGuideStep2Desc =>
      'Did you forget to press the button when you prepared the kefir this morning? No problem. Use this option to indicate the exact time (and day) you made the mixture in real life. The app will calculate the elapsed time since then.';

  @override
  String get infoGuideStep3Title => 'Notifications';

  @override
  String get infoGuideStep3Desc =>
      'You can close the application safely. When the target time is reached, you will receive a notification on your device letting you know it is time to strain the kefir.';

  @override
  String get infoGuideStep4Title => 'Finish Fermentation';

  @override
  String get infoGuideStep4Desc =>
      'Press this red button once you have strained the kefir to clear the timer and leave the application ready for your next harvest.';

  @override
  String get historyDeleted => 'Record deleted';

  @override
  String historyItemTitle(Object hours) {
    return '${hours}h Fermentation';
  }

  @override
  String historyItemStart(Object date) {
    return 'Start: $date';
  }

  @override
  String historyItemEnd(Object date) {
    return 'End: $date';
  }

  @override
  String get timeDays => 'DAYS';

  @override
  String get timeHours => 'HOURS';

  @override
  String get timeMinutes => 'MINUTES';

  @override
  String get timeSeconds => 'SECONDS';

  @override
  String get timelineStart => 'Start';

  @override
  String get timelineEnd => 'End';

  @override
  String get step0Title => 'Milky stage';

  @override
  String get step0Desc =>
      'The milk is infusing and starting to thicken slightly.';

  @override
  String get step1Title => 'Starting fermentation';

  @override
  String get step1Desc => 'The kefir begins to take shape with mild acidity.';

  @override
  String get step2Title => 'Ideal fermentation';

  @override
  String get step2Desc => 'Perfect moment for most tastes. Creamy texture.';

  @override
  String get step3Title => 'Strong fermentation';

  @override
  String get step3Desc => 'More pronounced flavor. Whey may start to separate.';

  @override
  String get step4Title => 'Very acidic';

  @override
  String get step4Desc =>
      'Very aggressive flavor. Ideal for recipes requiring strong acidity.';
}
