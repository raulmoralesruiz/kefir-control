<h1 align="center">
  <img src="../assets/icon/app_icon.png" style="border-radius: 50%;" alt="Логотип Kefir Control" width="120" />
  <br/>
  Kefir Control
</h1>

<p align="center">
  Минималистичное приложение с открытым исходным кодом без отслеживания данных для управления ферментацией молочного кефира и комбучи. С ним вы больше никогда не передержите свой напиток.
</p>

<p align="center">
  <img alt="GitHub Release" src="https://img.shields.io/github/v/release/raulmoralesruiz/kefir-control?style=flat-square">
  <img alt="License" src="https://img.shields.io/badge/License-AGPL--3.0--only-blue.svg">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter">
</p>

<p align="center">
  <a href="https://f-droid.org/packages/eu.raulmorales.kefircontrol" target="_blank">
    <img alt="Скачать в F-Droid" src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png" height="80">
  </a>
</p>

<p align="center">
  <a href="README_es.md">Испанский</a> |
  <a href="../README.md">Английский</a> |
  <a href="README_and.md">Андалузский</a> |
  <a href="README_ru.md">Русский</a>
</p>

<p align="center">
  <img src="../fastlane/metadata/android/en-US/images/phoneScreenshots/en-US_01_home_empty.png" alt="Главный экран" width="200" />
  <img src="../fastlane/metadata/android/en-US/images/phoneScreenshots/en-US_02_type_selection.png" alt="Выбор типа" width="200" />
  <img src="../fastlane/metadata/android/en-US/images/phoneScreenshots/en-US_03_duration_selection_kombucha.png" alt="Выбор длительности" width="200" />
  <img src="../fastlane/metadata/android/en-US/images/phoneScreenshots/en-US_04_progress_card.png" alt="Карточка прогресса" width="200" />
</p>

## 🥛 О проекте
**Kefir Control** родился из необходимости помнить, когда ваша ферментация достигает идеальной точки. Будь то молочный кефир или комбуча, это приложение упрощает процесс с помощью запланированных локальных уведомлений, живого таймера и обучения на основе ваших предпочтений.

Проект является **на 100% свободным ПО с открытым исходным кодом (FOSS)**, ориентирован на конфиденциальность и имеет современный интерфейс на базе Material Design 3.

## ✨ Основные возможности
- **🥛 Управление кефиром и комбучей**: Специальная поддержка различных типов ферментации с настраиваемыми этапами.
- **⏱️ Умное «Идеальное время»**: Приложение учится на ваших прошлых сборах, чтобы предлагать время ферментации, которое вам больше всего нравится.
- **🔔 Уведомления и оповещения**: Локальные сигналы (интернет не требуется), которые уведомляют вас о завершении и за 2 часа до него.
- **♾️ Экспериментальный режим**: Запускайте ферментацию без ограничения по времени для полного ручного контроля.
- **📅 Встроенный календарь**: Просматривайте историю и планируйте будущие партии визуально.
- **📱 Material You**: Поддержка динамических цветов и темная/светлая темы в соответствии с Material Design 3.
- **📳 Тактильная отдача**: Физическое взаимодействие через вибрацию для более глубокого погружения.
- **💾 Резервные копии**: Экспорт и импорт данных в формате JSON.
- **🌍 Многоязычность**: Доступно на испанском, английском, андалузском (EPA) и русском языках.
- **🔒 Конфиденциальность прежде всего**: Без аккаунтов, без трекеров и без аналитики. Ваши данные принадлежат только вам.

## 🛠️ Технологии и требования
- [Flutter SDK](https://flutter.dev/) (>= 3.0.0)
- Ключевые используемые пакеты:
  - `shared_preferences` (Локальное хранение)
  - `flutter_local_notifications` (Нативные уведомления)
  - `flutter_timezone` (Управление часовыми поясами)
  - `flex_color_scheme` (Расширенная стилизация M3)

## 🚀 Установка и сборка для разработчиков
Чтобы самостоятельно собрать приложение из исходного кода:

1. Клонируйте этот репозиторий:
   ```bash
   git clone https://github.com/raulmoralesruiz/kefir-control.git
   ```
2. Перейдите в папку проекта:
   ```bash
   cd kefir-control
   ```
3. Загрузите зависимости:
   ```bash
   flutter pub get
   ```
4. Запустите приложение на эмуляторе или реальном устройстве:
   ```bash
   flutter run
   ```

## 📜 Лицензия
Этот проект лицензирован под **GNU Affero General Public License v3.0 only (AGPLv3-only)**.
Вы можете свободно использовать, изменять и распространять программное обеспечение, но модификации и сетевые версии этого ПО должны распространяться под той же лицензией. Дополнительную информацию см. в файле [LICENSE](../LICENSE).
