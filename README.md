<h1 align="center">
  <img src="assets/icon/app_icon.png" style="border-radius: 50%;" alt="Kéfir Control Logo" width="120" />
  <br/>
  Kéfir Control
</h1>

<p align="center">
  Una aplicación minimalista, open-source y libre de rastreadores para gestionar tus fermentaciones de kéfir de leche, asegurando que nunca más se pasen de tiempo.
</p>

<p align="center">
  <img alt="GitHub Release" src="https://img.shields.io/github/v/release/raulmoralesruiz/kefir-control?style=flat-square">
  <img alt="License" src="https://img.shields.io/github/license/raulmoralesruiz/kefir-control?style=flat-square&color=blue">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter">
</p>

<p align="center">
  <a href="https://f-droid.org/packages/eu.raulmorales.kefircontrol">
    <img alt="Get it on F-Droid" src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png" height="80">
  </a>
</p>

## 🥛 Sobre el Proyecto
**Kéfir Control** nació de la necesidad de recordar cuándo la fermentación del kéfir de leche está en su punto perfecto (normalmente entre 24 y 48 horas). Si se deja demasiado tiempo, el kéfir se vuelve excesivamente ácido y el suero se separa en exceso. Esta aplicación simplifica ese proceso con notificaciones locales programadas y un temporizador en vivo.

El proyecto es **100% Free and Open Source Software (FOSS)**, centrado en la privacidad y con una interfaz moderna basada en Material Design 3.

## ✨ Características Principales
- **Temporizadores Rápidos**: Selecciona entre 24h, 36h o 48h de fermentación.
- **Registro de Fermentaciones Pasadas**: ¿Olvidaste iniciar el temporizador en el momento exacto? Puedes configurar la hora de inicio manualmente.
- **Notificaciones Locales (Off-grid)**: La app programa una alarma usando tu propio dispositivo (sin servidores externos ni internet). Recibirás un aviso incluso si la app está completamente cerrada.
- **Historial Completo**: Guarda un registro de todas tus cosechas pasadas para llevar un control de la salud de tus nódulos.
- **Tema Dinámico y Minimalista**: Diseño limpio y sin sombras ('flat design') adherido a Material 3.
- **Privacidad Primero**: Sin cuentas de usuario, sin analytics y sin seguimiento cruzado. Los datos viven en tu dispositivo.

## 🛠️ Tecnologías y Requisitos
- [Flutter SDK](https://flutter.dev/) (>= 3.0.0)
- Paquetes clave utilizados:
  - `shared_preferences` (Persistencia local)
  - `flutter_local_notifications` (Notificadores Nativos)
  - `flutter_timezone` (Gestión de alarmas en la zona horaria del sistema)

## 🚀 Instalación y Compilación para Desarrolladores
Si deseas compilar la aplicación tú mismo desde el código fuente:

1. Clona este repositorio:
   ```bash
   git clone https://github.com/raulmoralesruiz/kefir-control.git
   ```
2. Accede a la carpeta del proyecto:
   ```bash
   cd kefir-control
   ```
3. Descarga las dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la aplicación en tu emulador o dispositivo físico:
   ```bash
   flutter run
   ```

## 📜 Licencia
Este proyecto está licenciado bajo la **GNU Affero General Public License v3.0 (AGPLv3)**.
Eres libre de usar, modificar y distribuir el software, pero las modificaciones y versiones de red de este software deben ser distribuidas bajo la misma licencia. Consulta el archivo [LICENSE](LICENSE) para más información.
