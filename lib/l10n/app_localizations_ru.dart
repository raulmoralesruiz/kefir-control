// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Kefir Control';

  @override
  String get accept => 'Принять';

  @override
  String get cancel => 'Отмена';

  @override
  String get history => 'История';

  @override
  String get changeLanguage => 'Сменить язык';

  @override
  String get themeTitle => 'Тема';

  @override
  String get themeSystem => 'Как в системе';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get drawerDonate => 'Угостить кофе';

  @override
  String get drawerDonateSubtitle => 'Поддержать разработку';

  @override
  String get historyTitle => 'История';

  @override
  String get homeSwipeDeleteHint => 'Смахните карточку, чтобы удалить';

  @override
  String get historyEmpty => 'Нет записей о ферментациях.';

  @override
  String get historyClear => 'Очистить';

  @override
  String get historyClearTitle => 'Очистить историю?';

  @override
  String get historyClearContent => 'Это действие нельзя отменить.';

  @override
  String get historyClearConfirm => 'Очистить';

  @override
  String get homeNoActiveFermentationTitle => 'Нет активной ферментации';

  @override
  String get homeNoActiveFermentationDesc =>
      'Выберите действие в меню ниже, чтобы начать.';

  @override
  String get homeEstimatedFinish => 'Примерное завершение';

  @override
  String get homeRemainingTime => 'Осталось';

  @override
  String get homeCompleted => 'Завершено';

  @override
  String get homeStopTitle => 'Завершить ферментацию раньше?';

  @override
  String get homeStopContent =>
      'Вы собираетесь остановить таймер. Не забудьте процедить грибок.';

  @override
  String get homeStopConfirm => 'Завершить';

  @override
  String get btnStartFermentation => 'Начать ферментацию';

  @override
  String get btnStartPastFermentation => 'Записать прошедшую ферментацию';

  @override
  String get btnStopFermentation => 'Завершить ферментацию';

  @override
  String get dialogManualTitle => 'Записать прошедшую ферментацию';

  @override
  String get dialogManualDesc =>
      'Укажите дату и время, когда вы смешали молоко с грибком, чтобы рассчитать текущий прогресс и установить напоминание.';

  @override
  String get dialogManualDate => 'Дата начала';

  @override
  String get dialogManualTime => 'Время начала';

  @override
  String get dialogManualDuration => 'Длительность';

  @override
  String get dialogManualBtnStart => 'Начать';

  @override
  String get dialogOption24h => '24 часа';

  @override
  String get dialogOption36h => '36 часов';

  @override
  String get dialogOption48h => '48 часов';

  @override
  String get infoTitle => 'Информация и руководство';

  @override
  String get infoCard1Title => '🥛 Что такое молочный кефир?';

  @override
  String get infoCard1Desc =>
      'Молочный кефир — это богатый пробиотиками ферментированный напиток. Готовится добавлением кефирного грибка в цельное молоко комнатной температуры.';

  @override
  String get infoCard2Title => '⏱️ Время ферментации';

  @override
  String get infoCard2Subtitle1 => '24 часа';

  @override
  String get infoCard2Desc1 =>
      'Мягкий вкус и жидкая консистенция, похож на питьевой йогурт со сладковатыми нотками. Лёгкий слабительный эффект. Идеально при высокой комнатной температуре (>25C).';

  @override
  String get infoCard2Subtitle2 => '36 часов';

  @override
  String get infoCard2Desc2 =>
      'Самый сбалансированный вариант. Более кремовая текстура с лёгким отделением сыворотки. Регулирует работу кишечника.';

  @override
  String get infoCard2Subtitle3 => '48 часов';

  @override
  String get infoCard2Desc3 =>
      'Кислый и насыщенный вкус. Сыворотка образует заметный слой внизу. Вяжущий эффект. Рекомендуется только при низкой комнатной температуре или для приготовления выдержанного кефира.';

  @override
  String get infoCard3Title => 'Совет';

  @override
  String get infoCard3Desc =>
      'Избегайте металлических предметов при процеживании грибка. Используйте пластиковые или деревянные ложки и ситечки, чтобы не повредить микроорганизмы.';

  @override
  String get devDesc => 'Управляйте ферментацией';

  @override
  String get notifReadyTitle => 'Кефир готов! 🥛';

  @override
  String notifReadyBody(Object hours) {
    return 'Ферментация ($hours ч.) завершена. Время процедить грибок и наслаждаться пробиотическим напитком.';
  }

  @override
  String get notifReminderTitle => 'Приготовление кефира';

  @override
  String get notifReminderBody =>
      'Осталось 2 часа до готовности. Приготовьте чистую посуду!';

  @override
  String get infoTab1 => 'Руководство';

  @override
  String get infoTab2 => 'Ферментация';

  @override
  String get infoTab3 => 'Дополнительно';

  @override
  String get infoProcessTitle => 'Процесс приготовления кефира';

  @override
  String get infoProcessStep1Title => 'Подготовка';

  @override
  String get infoProcessStep1Desc =>
      'Кефирный гриб помещают в молоко комнатной температуры, желательно цельное (но можно и полуобезжиренное или обезжиренное).';

  @override
  String get infoProcessStep2Title => 'Ферментация (24–48 ч.)';

  @override
  String get infoProcessStep2Desc =>
      'Микроорганизмы поглощают лактозу, преобразуя её в молочную кислоту (придаёт кислый вкус), углекислый газ и другие полезные вещества. Чем дольше настаивается, тем гуще и кислее становится кефир.';

  @override
  String get infoProcessStep3Title => 'Сбор';

  @override
  String get infoProcessStep3Desc =>
      'Процедите смесь через неметаллическое сито. Полученная жидкость — это готовый кефир, а извлечённый грибок снова добавьте в свежее молоко для повторения цикла.';

  @override
  String get infoGuideTitle => 'Как использовать Kefir Control';

  @override
  String get infoGuideDesc =>
      'Это приложение помогает точно отслеживать время ферментации, чтобы кефир не перекисал из-за забывчивости.';

  @override
  String get infoGuideStep1Title => 'Начать ферментацию сейчас';

  @override
  String get infoGuideStep1Desc =>
      'Нажмите эту кнопку сразу после смешивания молока с грибком. Выберите время ферментации (24, 36 или 48 часов). Приложение установит автоматический будильник.';

  @override
  String get infoGuideStep2Title => 'Записать прошедшую ферментацию';

  @override
  String get infoGuideStep2Desc =>
      'Забыли нажать кнопку, когда приготовили кефир утром? Ничего страшного. Укажите точное время (и день), когда вы сделали смесь. Приложение само рассчитает, сколько времени прошло.';

  @override
  String get infoGuideStep3Title => 'Уведомления';

  @override
  String get infoGuideStep3Desc =>
      'Приложение можно спокойно закрыть. Когда время выйдет, вы получите уведомление о том, что кефир пора процеживать.';

  @override
  String get infoGuideStep4Title => 'Завершить ферментацию';

  @override
  String get infoGuideStep4Desc =>
      'Нажмите эту красную кнопку после процеживания кефира, чтобы сбросить таймер для следующего цикла.';

  @override
  String get infoGuideStepHarvestTitle => 'Сбор и перезапуск';

  @override
  String get infoGuideStepHarvestDesc =>
      'Завершив одну партию, используйте эту функцию, чтобы сохранить результат и сразу начать новый цикл одним касанием.';

  @override
  String get infoGuideStepAdjustTitle => 'Корректировка времени';

  @override
  String get infoGuideStepAdjustDesc =>
      'Стало жарче обычного? Нажмите на прогресс активной ферментации, чтобы уменьшить или увеличить её длительность.';

  @override
  String get historyDeleted => 'Запись удалена';

  @override
  String historyItemTitle(Object hours) {
    return 'Ферментация $hours ч';
  }

  @override
  String historyItemStart(Object date) {
    return 'Начало: $date';
  }

  @override
  String historyItemEnd(Object date) {
    return 'Конец: $date';
  }

  @override
  String get timeDays => 'ДН.';

  @override
  String get timeHours => 'Ч.';

  @override
  String get timeMinutes => 'МИН.';

  @override
  String get timeSeconds => 'СЕК.';

  @override
  String get timelineStart => 'Старт';

  @override
  String get timelineEnd => 'Финиш';

  @override
  String get step0Title => 'Молочная стадия';

  @override
  String get step0Desc => 'Молоко настаивается и начинает слегка густеть.';

  @override
  String get step1Title => 'Начало ферментации';

  @override
  String get step1Desc => 'Кефир начинает формироваться с мягкой кислинкой.';

  @override
  String get step2Title => 'Идеальная ферментация';

  @override
  String get step2Desc =>
      'Идеальный момент для большинства. Кремовая текстура.';

  @override
  String get step3Title => 'Сильная ферментация';

  @override
  String get step3Desc =>
      'Более выраженный вкус. Может начать отделяться сыворотка.';

  @override
  String get step4Title => 'Очень кислый';

  @override
  String get step4Desc =>
      'Очень резкий вкус. Подходит для рецептов, требующих сильной кислинки.';

  @override
  String get addSheetTitle => 'Что будем ферментировать?';

  @override
  String get addSheetKefir => 'Молочный кефир';

  @override
  String get addSheetKombucha => 'Комбуча';

  @override
  String get addSheetFruitKefir => 'Водный кефир';

  @override
  String get notifReadyTitleKombucha => 'Комбуча готова';

  @override
  String get notifReadyTitleKefir => 'Кефир готов';

  @override
  String get notifReadyTitleFruitKefir => 'Водный кефир готов';

  @override
  String get notifReadyBodyGeneric => 'Ферментация завершена';

  @override
  String get notifReminderTitleGeneric => 'Напоминание';

  @override
  String get notifReminderBodyGeneric => 'Осталось 2 часа до завершения';

  @override
  String get addSheetPastRecord => 'Записать прошедшую ферментацию';

  @override
  String addSheetPastSelected(Object date) {
    return 'Начало: $date\nТеперь выберите длительность';
  }

  @override
  String get addSheetTimeKefir => 'Время для кефира';

  @override
  String addSheetHours(Object hours) {
    return '$hours ч.';
  }

  @override
  String get addSheetTimeKombucha => 'Время для комбучи';

  @override
  String get addSheetTimeFruitKefir => 'Время для водного кефира';

  @override
  String addSheetIdealTime(Object days) {
    return 'Ваше идеальное время ($days дн.)';
  }

  @override
  String addSheetDays(Object days) {
    return '$days дн.';
  }

  @override
  String get cardTranscurrido => 'Прошло';

  @override
  String get cardRestante => 'Осталось';

  @override
  String get cardCosechar => 'Собрать';

  @override
  String get cardFinalizar => 'Завершить';

  @override
  String get homeHarvestKombuchaTitle => 'Сбор комбучи';

  @override
  String get homeHarvestKombuchaDesc =>
      'Хотите запомнить это время как ваше идеальное для будущих ферментаций?';

  @override
  String get homeHarvestOnly => 'Просто собрать';

  @override
  String get homeHarvestAndSave => 'Собрать и сохранить';

  @override
  String get homeDeleteTitle => 'Удалить ферментацию?';

  @override
  String get homeDeleteDesc =>
      'Если удалить эту карточку, процесс будет отменён и не сохранится в истории.';

  @override
  String get homeDeleteBtn => 'Удалить';

  @override
  String get homeNewFermentation => 'Новая ферментация';

  @override
  String get historyKombuchaFinished => 'Комбуча собрана';

  @override
  String historyKombuchaDuration(Object days) {
    return 'Длительность: $days дн.';
  }

  @override
  String get stageKombucha0 => 'Начало формирования';

  @override
  String get stageKombucha1 => 'Слегка сладкая';

  @override
  String get stageKombucha2 => 'Сбалансированная (Идеал)';

  @override
  String get stageKombucha3 => 'Крепкая/Кислая';

  @override
  String get stageKombucha4 => 'Уксусная';

  @override
  String get historyKefirFinished => 'Кефир собран';

  @override
  String get historyFruitKefirFinished => 'Водный кефир собран';

  @override
  String get stageFruitKefir0 => 'Начало';

  @override
  String get stageFruitKefir1 => 'Активная ферментация';

  @override
  String get stageFruitKefir2 => 'Сбалансированная (Идеал)';

  @override
  String get stageFruitKefir3 => 'Крепкий';

  @override
  String get stageFruitKefir4 => 'Очень ферментированный';

  @override
  String historyCompletedPercent(Object percent) {
    return 'Завершено: $percent%';
  }

  @override
  String historyDurationDays(Object days) {
    return '$days дн.';
  }

  @override
  String historyDurationDaysHours(Object days, Object hours) {
    return '$days дн. и $hours ч.';
  }

  @override
  String historyDurationHours(Object hours) {
    return '$hours ч.';
  }

  @override
  String historyDurationHoursMinutes(Object hours, Object minutes) {
    return '$hours ч. $minutes мин.';
  }

  @override
  String get historyHarvestDate => 'Дата сбора';

  @override
  String historyRealDurationTarget(Object actual, Object target) {
    return 'Длительность: $actual (цель $target)';
  }

  @override
  String historyCompletedOn(Object date) {
    return 'Завершено $date';
  }

  @override
  String get historyItemDeleteTitle => 'Удалить запись?';

  @override
  String get historyItemDeleteContent => 'Эта запись будет удалена навсегда.';

  @override
  String get drawerDataManagement => 'Управление данными';

  @override
  String get drawerBackup => 'Экспорт резервной копии';

  @override
  String get drawerRestore => 'Восстановить из копии';

  @override
  String get backupSuccessTitle => 'Копия экспортирована';

  @override
  String get backupSuccessDesc => 'Данные успешно сохранены.';

  @override
  String get restoreSuccessTitle => 'Копия восстановлена';

  @override
  String get restoreSuccessDesc => 'Данные приложения восстановлены.';

  @override
  String get restoreErrorTitle => 'Ошибка';

  @override
  String get restoreErrorDesc => 'Файл повреждён или недействителен.';

  @override
  String addSheetIdealTimeKefir(num hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String hoursString = hoursNumberFormat.format(hours);

    return 'Ваше идеальное время ($hoursString ч.)';
  }

  @override
  String addSheetIdealTimeFruitKefir(num hours) {
    final intl.NumberFormat hoursNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String hoursString = hoursNumberFormat.format(hours);

    return 'Ваше идеальное время ($hoursString ч.)';
  }

  @override
  String get addSheetCustomTime => 'Своё время';

  @override
  String get addSheetNoLimit => 'Без ограничений';

  @override
  String get addSheetCustomHours => 'Часы';

  @override
  String get addSheetCustomDays => 'Дни';

  @override
  String get addSheetCustomConfirm => 'Использовать это время';

  @override
  String get cardNoLimit => 'Без ограничений';

  @override
  String get cardOpenEndedStage => 'Экспериментальный режим';

  @override
  String get addSheetNameHint => 'Название партии (необязательно)';

  @override
  String get cardRenameTitle => 'Переименовать';

  @override
  String get cardRenameHint => 'Название партии';

  @override
  String get drawerCalendar => 'Календарь';

  @override
  String get calendarTitle => 'Мои ферментации';

  @override
  String get calendarNoFermentations => 'В этот день ферментаций нет';

  @override
  String get calendarActiveBadge => 'Активна';

  @override
  String get calendarPlannedBadge => 'Запланирована';

  @override
  String get calendarPlanButton => 'Запланировать на этот день';

  @override
  String get cardStartsIn => 'Начнётся через';

  @override
  String get detailStartDate => 'Начало';

  @override
  String get detailStageKombucha0Desc =>
      'SCOBY пробуждается. Напиток всё ещё практически сладкий чай.';

  @override
  String get detailStageKombucha1Desc =>
      'Ферментация идёт мягко. Преобладает сладость с лёгким кислым оттенком.';

  @override
  String get detailStageKombucha2Desc =>
      'Идеальный баланс сладости и кислоты. Подходит большинству.';

  @override
  String get detailStageKombucha3Desc =>
      'Выраженная кислота и сложный вкус. Для любителей насыщенного вкуса.';

  @override
  String get detailStageKombucha4Desc =>
      'Очень глубокая ферментация. Интенсивный уксусный вкус, подходит для кулинарии.';

  @override
  String get detailStageFruitKefir0Desc =>
      'Зерна начинают увлажняться и активировать ферментацию.';

  @override
  String get detailStageFruitKefir1Desc =>
      'Начинают образовываться маленькие пузырьки, сахар постепенно потребляется.';

  @override
  String get detailStageFruitKefir2Desc =>
      'Идеальный баланс сладости и кислотности. Освежающий и слегка газированный.';

  @override
  String get detailStageFruitKefir3Desc =>
      'Сахар почти полностью потреблен, вкус более сухой и менее сладкий.';

  @override
  String get detailStageFruitKefir4Desc =>
      'Продвинутая ферментация, интенсивный вкус с очень малым остатком сахара.';

  @override
  String get detailNotesTitle => 'Заметки';

  @override
  String get detailNotesHint => 'Добавьте детали о молоке, температуре и т.д.';

  @override
  String get detailHistoryTitle => 'Недавняя история';

  @override
  String get detailHistoryEmpty => 'Предыдущих сборов нет';

  @override
  String detailHistoryLastHarvest(Object duration) {
    return 'Последняя партия: $duration';
  }

  @override
  String get historyRepeat => 'Повторить партию';

  @override
  String get adjSheetTitle => 'Изменить длительность';

  @override
  String get adjSheetSetNoLimit => 'Переключить на «Без ограничений»';

  @override
  String get adjSheetSetTimed => 'Установить длительность';

  @override
  String get actionSaveIdealTime => 'Сохранить идеальное время';

  @override
  String get actionSaveIdealTimeSuccess => 'Идеальное время сохранено';

  @override
  String get dialogSaveIdealConfirm =>
      'Сохранить это время как ваше эталонное?';

  @override
  String get actionHarvestAndRestart => 'Собрать и перезапустить';

  @override
  String get dialogHarvestAndRestartConfirm =>
      'Собрать текущую партию и начать новую?';

  @override
  String get harvestNextStepTitle => 'Следующий цикл';

  @override
  String get actionDelete => 'Удалить';

  @override
  String get dialogResetConfirm =>
      'Будет сохранено в историю, и таймер начнётся заново.';

  @override
  String secondFermentationName(Object name) {
    return 'Ф2: $name';
  }

  @override
  String get secondFermentationDefaultName => 'Вторичная ферментация';

  @override
  String get infoKombuchaTitle => '🍵 Что такое комбуча?';

  @override
  String get infoKombuchaDesc =>
      'Это чай, ферментированный симбиотической колонией бактерий и дрожжей (SCOBY). Богат органическими кислотами и витаминами.';

  @override
  String get infoKombuchaProcessTitle => 'Цикл комбучи';

  @override
  String get infoKombuchaStep1Title => 'Подготовка';

  @override
  String get infoKombuchaStep1Desc =>
      'Чай настаивается с сахаром, и после остывания добавляется SCOBY с небольшим количеством стартовой жидкости от предыдущей партии.';

  @override
  String get infoKombuchaStep2Title => 'Ферментация (7–12 дней)';

  @override
  String get infoKombuchaStep2Desc =>
      'SCOBY потребляет сахар и чай. Приложение учится на ваших сборах и предлагает персональное «Идеальное время».';

  @override
  String get infoAdvancedCalendarTitle => 'Календарь';

  @override
  String get infoAdvancedCalendarDesc =>
      'Просматривайте прошлые сборы и планируйте будущие приготовления на вкладке Календарь.';

  @override
  String get infoAdvancedHistoryTitle => 'История';

  @override
  String get infoAdvancedHistoryDesc =>
      'Легко повторяйте прошлые партии. Время для комбучи корректируется автоматически на основе ваших предпочтений.';

  @override
  String get infoAdvancedDataTitle => 'Безопасность данных';

  @override
  String get infoAdvancedDataDesc =>
      'Используйте Экспорт и Восстановление для сохранности записей или переноса на другое устройство.';
}
