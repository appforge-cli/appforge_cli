# AppForge CLI — Example

This example demonstrates how to use **AppForge CLI** to generate a
production-ready Flutter application using an interactive command-line interface.

AppForge is a **CLI tool**, not a runtime Dart library.  
You do **not** import it into Flutter apps — you run it from the terminal.

---

## 📦 Install AppForge CLI

```bash
dart pub global activate appforge_cli
Verify installation:

bash
Copy code
appforge --version
🚀 Create a Flutter App
Run:

bash
Copy code
appforge create
You will be guided through an interactive setup where you can choose:

Project name

Organization ID (e.g. com.example)

State management (Provider / Riverpod / Bloc)

App theme

Authentication type

Firebase integration & modules

Flutter Web support

Docker setup (for Web)

Localization (multi-language support)

Optional AI chatbot integration

🧰 Requirements
Before running the CLI, make sure you have:

Flutter SDK installed

Dart SDK (comes with Flutter)

Firebase CLI (required only if Firebase is enabled)

bash
Copy code
flutter doctor
firebase --version
ℹ️ Notes
The generated project is production-ready

Mobile-first by default, with optional Web & Docker support

Works on Windows, macOS, and Linux

Programmatic usage is intended for advanced users and documented separately

For full documentation, visit the package README on pub.dev.