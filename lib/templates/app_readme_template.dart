class AppReadmeTemplate {
  static String generate({
    required String projectName,
    required String stateManagement,
    required String authType,
    List<String> firebaseModules = const [],
    List<String> selectedModules = const [],
    List<String> selectedLanguages = const ['en'],
    bool includeChatbot = false,
    bool includeWeb = false,
    bool includeDocker = false,
  }) {
    final formattedProjectName = _formatProjectName(projectName);
    final authFeatures = _getAuthFeatures(authType);
    final firebaseFeatures = _getFirebaseFeatures(firebaseModules);
    final utilityModules = _getUtilityModules(selectedModules);
    final localizationFeatures = _getLocalizationFeatures(selectedLanguages);
    final authFlowExamples = _getAuthFlowExamples(authType);

    return '''
# 🚀 $formattedProjectName

A production-ready Flutter mobile application generated using **AppForge CLI**.

This project follows clean architecture, modern Flutter best practices, and comes with pre-configured authentication, theming, routing${firebaseModules.isNotEmpty ? ', and Firebase integration' : ''}.

---

## 🧱 Tech Stack

- **Flutter** ${includeWeb ? '(Android, iOS & Web)' : '(Android & iOS)'}
- **Dart**
- **State Management**: ${_formatStateManagement(stateManagement)}
- **Navigation**: GoRouter
- **Architecture**: Feature-based clean architecture${firebaseModules.isNotEmpty ? '\n- **Backend**: Firebase' : ''}${includeDocker ? '\n- **Deployment**: Docker + Nginx' : ''}

---

## ✨ Features Included

### 🎨 UI & Theming
- Material 3 design system
- Light & Dark mode support
- Responsive layouts (mobile & tablet)
- 12+ custom reusable widgets
- Smooth animations & transitions

### 🔐 Authentication
$authFeatures

${firebaseModules.isNotEmpty ? '''### 🔥 Firebase Integration
$firebaseFeatures
''' : ''}${selectedModules.isNotEmpty ? '''### 🧩 Utility Modules
$utilityModules
''' : ''}${includeChatbot ? '''### 🤖 AI Chatbot
- Powered by Google Gemini AI
- Beautiful chat UI with message bubbles
- Real-time typing indicators
- BLoC state management for chat
- Context-aware responses
''' : ''}${selectedLanguages.length > 1 ? '''### 🌍 Localization
$localizationFeatures
''' : ''}${includeDocker ? '''### 🐳 Docker Deployment (Web Only)
- Multi-stage Docker build
- Nginx reverse proxy
- Docker Compose orchestration
- Production-ready configuration
- CI/CD with GitHub Actions
''' : ''}
---

## 📂 Project Structure

\`\`\`
lib/
├── app/
│   ├── router/              # GoRouter configuration
│   └── theme/               # App theming (Light/Dark)
├── features/
│   ├── auth/                # Authentication feature
│   │   ├── screens/         # Login, Signup, OTP
│   │   └── services/        # Auth service layer
│   ├── home/                # Home screen
│   └── profile/             # Profile & settings${includeChatbot ? '\n│   └── chatbot/             # AI Chatbot feature\n│       ├── screens/\n│       ├── services/\n│       ├── models/\n│       └── bloc/' : ''}
├── core/
│   ├── firebase/            # Firebase operations${selectedModules.isNotEmpty ? '\n│   ├── modules/             # Utility modules\n│   │   ├── camera/\n│   │   ├── voice/\n│   │   └── call/' : ''}
│   └── providers/           # App-wide providers
├── shared/
│   └── widgets/             # Reusable UI components
│       ├── buttons/
│       ├── inputs/
│       ├── cards/
│       └── dialogs/
└── main.dart
\`\`\`

---

## ▶️ Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)${firebaseModules.isNotEmpty ? '\n- Firebase CLI (for Firebase setup)\n- Node.js (for Firebase CLI)' : ''}${includeDocker ? '\n- Docker & Docker Compose (for web deployment)' : ''}

### 1️⃣ Install dependencies
\`\`\`bash
cd $projectName
flutter pub get
\`\`\`

### 2️⃣ Run the app
\`\`\`bash
flutter run
\`\`\`
${includeWeb ? '''
### 🌐 Run on Web
\`\`\`bash
flutter run -d chrome
\`\`\`
''' : ''}
---
${firebaseModules.isNotEmpty ? '''
## 🔥 Firebase Setup

If Firebase was enabled during project creation, you need to configure it:

### Step 1: Login to Firebase
\`\`\`bash
firebase login
\`\`\`

### Step 2: Configure Firebase for your project
\`\`\`bash
cd $projectName
flutterfire configure
\`\`\`

This will:
- Let you select or create a Firebase project
- Configure iOS and Android automatically
- Generate \`firebase_options.dart\`

### Step 3: Re-run pub get
\`\`\`bash
flutter pub get
\`\`\`

### Firebase Console
Manage your project at: [Firebase Console](https://console.firebase.google.com)

---
''' : ''}
## 🔐 Authentication Flow

$authFlowExamples
${includeChatbot ? '''
---

## 🤖 AI Chatbot Setup

### Step 1: Get Gemini API Key
1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Copy the key

### Step 2: Add API Key
Open \`lib/core/constants/app_constants.dart\` and add your key:

\`\`\`dart
class AppConstants {
  static const String geminiApiKey = 'YOUR_API_KEY_HERE';
}
\`\`\`

### Step 3: Run the app
The chatbot will be accessible from the home screen.

---
''' : ''}${selectedModules.isNotEmpty ? '''
## 🧩 Utility Modules Usage

${selectedModules.contains('camera') ? '''### 📸 Camera
\`\`\`dart
import 'package:$projectName/core/modules/modules.dart';

// Pick image from camera
final image = await CameraService.pickImage(source: ImageSource.camera);

// Pick from gallery
final image = await CameraService.pickImage(source: ImageSource.gallery);
\`\`\`
''' : ''}${selectedModules.contains('speech') ? '''### 🎤 Speech-to-Text
\`\`\`dart
import 'package:$projectName/core/modules/modules.dart';

final speechService = SpeechService();

// Start listening
await speechService.startListening(
  onResult: (text) {
    print('Recognized: \$text');
  },
);

// Stop listening
await speechService.stopListening();
\`\`\`

### 🔊 Text-to-Speech
\`\`\`dart
import 'package:$projectName/core/modules/modules.dart';

final ttsService = TtsService();

// Speak text
await ttsService.speak('Hello, welcome to my app!');

// Stop speaking
await ttsService.stop();
\`\`\`
''' : ''}${selectedModules.contains('recorder') ? '''### 🎙️ Audio Recorder
\`\`\`dart
import 'package:$projectName/core/modules/modules.dart';

final recorder = AudioRecorderService();

// Start recording
await recorder.startRecording();

// Pause recording
await recorder.pauseRecording();

// Resume recording
await recorder.resumeRecording();

// Stop and get file path
final path = await recorder.stopRecording();
\`\`\`
''' : ''}${selectedModules.contains('call') ? '''### 📞 Phone Call
\`\`\`dart
import 'package:$projectName/core/modules/modules.dart';

// Make a phone call
await CallService.makeCall('+911234567890');

// Send SMS
await CallService.sendSMS('+911234567890', 'Hello!');
\`\`\`
''' : ''}
---
''' : ''}${selectedLanguages.length > 1 ? '''
## 🌍 Localization

This app supports multiple languages: **${selectedLanguages.join(', ')}**

### Change Language
\`\`\`dart
import 'package:$projectName/core/providers/locale_provider.dart';

// In your widget
final localeProvider = Provider.of<LocaleProvider>(context);

// Change to Spanish
localeProvider.setLocale(Locale('es'));
\`\`\`

### Add New Translations
1. Edit ARB files in \`lib/l10n/\`
2. Run: \`flutter gen-l10n\`
3. Restart the app

For more details, see \`LOCALIZATION.md\`

---
''' : ''}
## 📱 Permissions

This project automatically configures native permissions.

### Android
The following permissions are configured in \`android/app/src/main/AndroidManifest.xml\`:
- ✅ Internet access
- ✅ Network state${selectedModules.contains('camera') ? '\n- ✅ Camera\n- ✅ Storage' : ''}${selectedModules.contains('speech') || selectedModules.contains('recorder') ? '\n- ✅ Microphone\n- ✅ Record audio' : ''}${selectedModules.contains('call') ? '\n- ✅ Phone call\n- ✅ Phone state' : ''}${selectedModules.contains('contacts') ? '\n- ✅ Read contacts\n- ✅ Write contacts' : ''}

### iOS
The following permissions are configured in \`ios/Runner/Info.plist\`:
- ✅ Network access${selectedModules.contains('camera') ? '\n- ✅ Camera usage description\n- ✅ Photo library usage' : ''}${selectedModules.contains('speech') || selectedModules.contains('recorder') ? '\n- ✅ Microphone usage description\n- ✅ Speech recognition usage' : ''}${selectedModules.contains('contacts') ? '\n- ✅ Contacts usage description' : ''}

You can customize permission descriptions in the respective files.

---

## 🧪 Testing

\`\`\`bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
\`\`\`

---

## 🚀 Build & Deploy

### Android
\`\`\`bash
# Debug APK
flutter build apk

# Release APK
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release
\`\`\`

### iOS
\`\`\`bash
# Release build
flutter build ios --release

# Or open in Xcode
open ios/Runner.xcworkspace
\`\`\`
${includeWeb ? '''
### Web
\`\`\`bash
# Build for web
flutter build web --release

# Serve locally
flutter run -d chrome
\`\`\`
''' : ''}${includeDocker && includeWeb ? '''
### 🐳 Docker Deployment (Web Only)

\`\`\`bash
# Build Docker image
make build

# Run production
make run

# Run development with hot-reload
make dev

# Stop containers
make stop

# View logs
make logs
\`\`\`

For complete Docker documentation, see \`DOCKER.md\`
''' : ''}
---

## 🧠 Best Practices

### Code Organization
- ✅ Keep business logic inside \`features/\`
- ✅ Use shared widgets from \`shared/widgets/\`
- ✅ Avoid direct Firebase calls in UI
- ✅ Follow state management conventions (${stateManagement})

### State Management
${_getStateManagementBestPractices(stateManagement)}

### Performance
- ✅ Use \`const\` constructors where possible
- ✅ Avoid rebuilding entire widget trees
- ✅ Use \`ListView.builder\` for long lists
- ✅ Implement proper image caching

### Security
${firebaseModules.isNotEmpty ? '- ✅ Never commit Firebase config files to public repos\n' : ''}- ✅ Use environment variables for API keys
- ✅ Implement proper authentication flows
- ✅ Validate all user inputs
- ✅ Use HTTPS for all network calls

---

## 📚 Resources

### Flutter
- [Official Documentation](https://docs.flutter.dev/)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)

### State Management
${_getStateManagementResources(stateManagement)}
${firebaseModules.isNotEmpty ? '''
### Firebase
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
''' : ''}${includeChatbot ? '''
### Google Gemini AI
- [Google AI Studio](https://makersuite.google.com/)
- [Gemini API Documentation](https://ai.google.dev/docs)
''' : ''}
---

## 🐛 Troubleshooting

${firebaseModules.isNotEmpty ? '''### Firebase Issues
**Problem**: "Firebase not configured"
- **Solution**: Run \`flutterfire configure\` in your project directory

**Problem**: "Google Services missing"
- **Solution**: Download \`google-services.json\` (Android) and \`GoogleService-Info.plist\` (iOS) from Firebase Console
''' : ''}
### Build Issues
**Problem**: "Dependencies conflict"
- **Solution**: Run \`flutter pub get\` or \`flutter clean && flutter pub get\`

**Problem**: "Android build fails"
- **Solution**: Check that minSdk is set to 23 in \`android/app/build.gradle.kts\`

### Permission Issues
**Problem**: "Permission denied at runtime"
- **Solution**: Make sure permissions are requested before use. Check \`permission_handler\` documentation.

---

## 📄 License

This project is generated using AppForge CLI and is free to modify and distribute.

---

## 🙌 Generated Using

**AppForge CLI** - Production-ready Flutter App Generator

- 📦 [pub.dev/packages/appforge_cli](https://pub.dev/packages/appforge_cli)
- 🌟 [GitHub Repository](https://github.com/ajaychikshetty/appforge_cli)

### Features
✅ Clean Architecture  
✅ Multiple Auth Options  
✅ Firebase Integration  
✅ Utility Modules  
✅ Multi-language Support  
✅ Docker Support  
✅ Production Ready  

---

**Happy Coding! 🚀**

If you find this helpful, please give it a ⭐ on GitHub!
''';
  }

  static String _formatProjectName(String name) {
    return name
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static String _formatStateManagement(String stateManagement) {
    switch (stateManagement.toLowerCase()) {
      case 'riverpod':
        return 'Riverpod (Recommended)';
      case 'provider':
        return 'Provider';
      case 'bloc':
        return 'BLoC Pattern';
      default:
        return stateManagement;
    }
  }

  static String _getAuthFeatures(String authType) {
    switch (authType) {
      case 'email_password':
        return '''- Email & Password authentication
- Login screen with validation
- Signup screen with form
- Password visibility toggle
- Remember me functionality''';
      case 'username_password':
        return '''- Username & Password authentication
- Login screen with validation
- Signup screen with form
- Password visibility toggle
- Username availability check''';
      case 'phone_otp':
        return '''- Phone number authentication
- OTP verification screen
- Auto-read SMS OTP
- Resend OTP functionality
- Phone number validation''';
      case 'social_auth':
        return '''- Google Sign-In
- Apple Sign-In (iOS)
- Social auth buttons
- Profile picture from provider
- One-tap authentication''';
      case 'all':
        return '''- Email & Password authentication
- Username & Password authentication
- Phone OTP verification
- Google Sign-In
- Apple Sign-In (iOS)
- Unified login experience
- Multiple auth method support''';
      default:
        return '''- Email & Password authentication
- Login and Signup screens
- Form validation''';
    }
  }

  static String _getFirebaseFeatures(List<String> modules) {
    if (modules.isEmpty) return '';

    final features = <String>[];

    if (modules.contains('auth') || modules.contains('core')) {
      features.add('- 🔐 **Authentication**: Sign up, sign in, password reset');
    }
    if (modules.contains('firestore')) {
      features.add(
          '- 💾 **Firestore**: NoSQL database with real-time sync\n- CRUD operations ready\n- Query helpers included');
    }
    if (modules.contains('storage')) {
      features.add(
          '- 📁 **Cloud Storage**: File upload/download\n- Image optimization\n- Progress tracking');
    }
    if (modules.contains('fcm')) {
      features.add(
          '- 🔔 **Cloud Messaging**: Push notifications\n- Topic subscriptions\n- Background handlers');
    }

    return features.join('\n');
  }

  static String _getUtilityModules(List<String> modules) {
    if (modules.isEmpty) return 'No utility modules enabled';

    final features = <String>[];

    if (modules.contains('camera')) {
      features
          .add('- 📸 **Camera Module**: Photo/video capture, gallery picker');
    }
    if (modules.contains('speech')) {
      features.add(
          '- 🎤 **Speech Module**: Speech-to-text, text-to-speech, continuous listening');
    }
    if (modules.contains('recorder')) {
      features.add(
          '- 🎙️ **Recorder Module**: Audio recording, pause/resume, playback');
    }
    if (modules.contains('call')) {
      features.add('- 📞 **Call Module**: Phone calls, SMS, VoIP ready');
    }
    if (modules.contains('contacts')) {
      features.add(
          '- 📇 **Contacts Module**: Access phone contacts, search, pick contacts');
    }

    return features.join('\n');
  }

  static String _getLocalizationFeatures(List<String> languages) {
    if (languages.length <= 1) return '';

    return '''- Multi-language support (${languages.length} languages)
- Languages: ${languages.join(', ')}
- Language selector widget
- Persistent language preference
- RTL support for Arabic
- Easy to add new languages''';
  }

  static String _getAuthFlowExamples(String authType) {
    switch (authType) {
      case 'email_password':
        return '''This app uses **Email & Password** authentication.

### Login Flow
1. User enters email and password
2. Validates email format
3. Checks password length
4. Authenticates with Firebase/backend
5. Redirects to home screen

### Signup Flow
1. User enters email, password, confirm password
2. Validates all fields
3. Creates new account
4. Auto-login after signup

### Example Code
\`\`\`dart
// Login
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
);

// Signup
await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);
\`\`\`''';

      case 'phone_otp':
        return '''This app uses **Phone & OTP** authentication.

### Login Flow
1. User enters phone number
2. Validates phone format
3. Sends OTP via SMS
4. User enters OTP
5. Verifies OTP
6. Redirects to home screen

### OTP Flow
- 6-digit OTP
- Auto-read SMS (Android)
- Resend OTP after 30 seconds
- OTP expires in 5 minutes

### Example Code
\`\`\`dart
// Send OTP
await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: phoneNumber,
  verificationCompleted: (credential) {},
  verificationFailed: (error) {},
  codeSent: (verificationId, resendToken) {},
  codeAutoRetrievalTimeout: (verificationId) {},
);

// Verify OTP
final credential = PhoneAuthProvider.credential(
  verificationId: verificationId,
  smsCode: otpCode,
);
await FirebaseAuth.instance.signInWithCredential(credential);
\`\`\`''';

      case 'social_auth':
        return '''This app uses **Social Authentication** (Google & Apple).

### Google Sign-In Flow
1. User taps "Sign in with Google"
2. Google Sign-In popup appears
3. User selects account
4. Redirects to home screen

### Apple Sign-In Flow (iOS)
1. User taps "Sign in with Apple"
2. Face ID / Touch ID authentication
3. User approves
4. Redirects to home screen

### Example Code
\`\`\`dart
// Google Sign-In
final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
final credential = GoogleAuthProvider.credential(
  accessToken: googleAuth.accessToken,
  idToken: googleAuth.idToken,
);
await FirebaseAuth.instance.signInWithCredential(credential);
\`\`\`''';

      case 'all':
        return '''This app supports **All Authentication Methods**.

### Available Options
1. **Email & Password**: Traditional login
2. **Username & Password**: Alternative login
3. **Phone OTP**: SMS verification
4. **Google Sign-In**: One-tap login
5. **Apple Sign-In**: iOS native login

Users can choose their preferred method on the login screen.

### Example Code
See individual auth type examples above. All methods are supported!''';

      default:
        return '''This app uses authentication for secure access.

Check the auth screens in \`lib/features/auth/screens/\` for implementation details.''';
    }
  }

  static String _getStateManagementBestPractices(String stateManagement) {
    switch (stateManagement.toLowerCase()) {
      case 'riverpod':
        return '''- ✅ Use \`ConsumerWidget\` for widgets that need state
- ✅ Use \`ref.watch\` for reactive state
- ✅ Use \`ref.read\` for one-time reads
- ✅ Create separate provider files
- ✅ Use \`family\` and \`autoDispose\` modifiers''';
      case 'provider':
        return '''- ✅ Use \`ChangeNotifierProvider\` for mutable state
- ✅ Use \`Provider\` for immutable data
- ✅ Use \`Consumer\` widgets to limit rebuilds
- ✅ Call \`notifyListeners()\` after state changes''';
      case 'bloc':
        return '''- ✅ One BLoC per feature
- ✅ Use \`BlocBuilder\` for UI updates
- ✅ Use \`BlocListener\` for side effects
- ✅ Keep BLoCs small and focused
- ✅ Use sealed classes for events/states''';
      default:
        return '- ✅ Follow the state management pattern used in this project';
    }
  }

  static String _getStateManagementResources(String stateManagement) {
    switch (stateManagement.toLowerCase()) {
      case 'riverpod':
        return '''- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod Examples](https://github.com/rrousselGit/riverpod/tree/master/examples)''';
      case 'provider':
        return '''- [Provider Documentation](https://pub.dev/packages/provider)
- [Provider Examples](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)''';
      case 'bloc':
        return '''- [BLoC Documentation](https://bloclibrary.dev/)
- [BLoC Examples](https://github.com/felangel/bloc/tree/master/examples)''';
      default:
        return '';
    }
  }
}
