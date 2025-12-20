import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:superapp_cli/templates/EnhancedWidgetsPart2.dart';
import 'package:superapp_cli/templates/EnhancedWidgetsTemplate.dart';
import 'package:superapp_cli/templates/app_localization_template.dart';
import 'package:superapp_cli/templates/app_router_template.dart';
import 'package:superapp_cli/templates/onboarding_template.dart';
import 'package:superapp_cli/templates/chatbot_templates.dart'
    show ChatbotTemplates;
import 'package:superapp_cli/templates/docker_templates.dart'
    show DockerTemplates;
import 'package:superapp_cli/templates/firebase_operations_template.dart';
import 'package:superapp_cli/templates/main_template.dart';
import 'package:superapp_cli/templates/modules_template.dart'
    show ModulesTemplate;
import 'package:superapp_cli/templates/pubspec_template.dart';
import 'package:superapp_cli/templates/theme_template.dart';
import 'package:superapp_cli/templates/screen_templates.dart';
import 'package:superapp_cli/utils/file_utils.dart';

class ProjectGenerator {
  ProjectGenerator({
    required this.projectName,
    required this.organization,
    required this.stateManagement,
    required this.includeFirebase,
    this.firebaseModules = const [],
    this.includeChatbot = false,
    this.includeDocker = false,
    this.selectedModules = const [], // Add this
    List<String>? selectedLanguages,
    required this.themeColor,
    required this.authType,
    required this.logger,
  }) : selectedLanguages =
            (selectedLanguages == null || selectedLanguages.isEmpty)
                ? const ['en']
                : selectedLanguages;

  final String projectName;
  final String organization;
  final String stateManagement;
  final bool includeFirebase;
  final List<String> firebaseModules;
  final bool includeChatbot;
  final bool includeDocker;
  final List<String> selectedLanguages; // always non-null, at least ['en']
  final String themeColor;
  final String authType;
  final Logger logger;
  final List<String> selectedModules; // Add this field

  Future<void> generate() async {
    // Step 1: Create Flutter project
    await _createFlutterProject();

    // Step 2: Generate folder structure
    await _generateFolderStructure();

    // Step 3: Generate pubspec.yaml with all dependencies
    await _generatePubspec();

    // Step 4: Generate theme
    await _generateTheme();

    // Step 5: Generate reusable widgets
    await _generateEnhancedReusableWidgets();

    // Step 6: Generate chatbot if enabled
    if (includeChatbot) {
      await _generateChatbot();
    }

    // Step 7: Generate Firebase operations if enabled
    if (includeFirebase && firebaseModules.isNotEmpty) {
      await _generateFirebaseOperations();
    }
    await _generateUtilityModules();
    await _configureNative();
    // Step 8: Generate screens
    await _generateScreens();

    // Step 9: Generate router
    await _generateRouter();

    // Step 10: Generate main.dart
    await _generateMainFile();

    // Step 11: Replace default test with a compatible smoke test
    await _generateTestFile();

    // Step 12: Run flutter pub get
    await _runFlutterPubGet();

    // Step 13: Configure Firebase if needed
    if (includeFirebase) {
      await _configureFirebase();
    }

    // Step 14: Generate Docker setup if enabled
    if (includeDocker) {
      await _generateDockerSetup();
    }

    // Step 15: Generate localization files
    if (selectedLanguages.isNotEmpty && selectedLanguages.length > 1) {
      await _generateLocalization();
    }

    logger.success('✨ Project generated successfully with $themeColor theme!');
  }

  // Add this method to prompt for modules
  static Future<List<String>> promptForModules(Logger logger) async {
    final modules = <String>[];
    logger.info('📱 Utility Module Selection');
    logger.info('Select which utility modules to include:');

    // Define available modules with descriptions
    final availableModules = {
      'camera': {
        'name': '📸 Camera Module',
        'description': 'Camera service for capturing photos/videos',
        'dependencies': ['camera', 'image_picker'],
      },
      'speech': {
        'name': '🎤 Speech Module',
        'description': 'Speech-to-text and Text-to-speech services',
        'dependencies': ['speech_to_text', 'flutter_tts'],
      },
      'recorder': {
        'name': '🎙️ Audio Recorder Module',
        'description': 'Audio recording and playback service',
        'dependencies': ['record', 'path_provider'],
      },
      'call': {
        'name': '📞 Call Module',
        'description': 'Phone call and VoIP service',
        'dependencies': ['url_launcher', 'permission_handler'],
      },
    };

    for (final entry in availableModules.entries) {
      final moduleKey = entry.key;
      final moduleInfo = entry.value;

      logger.info('');
      logger.info('${moduleInfo['name']}');
      logger.info('  ${moduleInfo['description']}');
      logger.info(
          '  Dependencies: ${(moduleInfo['dependencies'] as List<String>).join(', ')}');

      final include = await logger.confirm(
        'Include ${moduleInfo['name']}?',
        defaultValue: false,
      );

      if (include) {
        modules.add(moduleKey);
        logger.success('✓ Added ${moduleInfo['name']}');
      } else {
        logger.detail('✗ Skipped ${moduleInfo['name']}');
      }
    }

    logger.info('');
    if (modules.isEmpty) {
      logger.info('⚠️  No utility modules selected');
    } else {
      logger.success('Selected modules: ${modules.join(', ')}');
    }

    return modules;
  }

// Add this method to your ProjectGenerator class
  Future<void> _configureNative() async {
    await _configureAndroidBuildGradle();
    await _configureAndroidManifest();
    await _configureIosInfoPlist();
  }

  Future<void> _configureAndroidBuildGradle() async {
    final buildGradlePath = path.join(
      projectName,
      'android',
      'app',
      'build.gradle.kts',
    );

    final buildGradleFile = File(buildGradlePath);
    if (!await buildGradleFile.exists()) {
      logger.warn('build.gradle.kts not found at $buildGradlePath');
      return;
    }

    var content = await buildGradleFile.readAsString();

    // Update NDK version to 27.0.12077973 (required by modern plugins)
    content = content.replaceAll(
      'ndkVersion = flutter.ndkVersion',
      'ndkVersion = "27.0.12077973"',
    );

    // Update minSdk to 23 (required by record_android and other plugins)
    content = content.replaceAll(
      'minSdk = flutter.minSdkVersion',
      'minSdk = 23',
    );

    // Enable core library desugaring for flutter_local_notifications and other plugins
    content = content.replaceAll(
      'sourceCompatibility = JavaVersion.VERSION_11\n        targetCompatibility = JavaVersion.VERSION_11\n    }',
      'sourceCompatibility = JavaVersion.VERSION_11\n        targetCompatibility = JavaVersion.VERSION_11\n        isCoreLibraryDesugaringEnabled = true\n    }',
    );

    // Add desugaring dependency if not already present
    if (!content.contains('coreLibraryDesugaring')) {
      // Find the flutter block and add dependencies after it
      final flutterBlockMatch =
          RegExp(r'flutter\s*\{\s*source\s*=\s*"\.\.\/\.\."\s*\}');
      if (flutterBlockMatch.hasMatch(content)) {
        content = content.replaceFirst(
          flutterBlockMatch,
          '''flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}''',
        );
      }
    }

    await buildGradleFile.writeAsString(content);
    logger.detail(
        '✓ Updated Android build.gradle.kts with NDK 27, minSdk 23, and core library desugaring');
  }

  Future<void> _configureAndroidManifest() async {
    final manifestPath = path.join(
      projectName,
      'android',
      'app',
      'src',
      'main',
      'AndroidManifest.xml',
    );

    final manifestFile = File(manifestPath);
    if (!await manifestFile.exists()) {
      logger.warn('AndroidManifest.xml not found at $manifestPath');
      return;
    }

    var content = await manifestFile.readAsString();

    // Build permissions based on selected modules
    final permissions = StringBuffer();
    permissions.writeln(
        '    <uses-permission android:name="android.permission.INTERNET" />');
    permissions.writeln(
        '    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />');

    // Add module-specific permissions
    if (selectedModules.contains('camera')
        //  || selectedModules.contains('recorder')
        ) {
      permissions.writeln(
          '    <uses-permission android:name="android.permission.CAMERA" />');
      // permissions.writeln(
      //     '    <uses-permission android:name="android.permission.RECORD_AUDIO" />');
    }
    if (selectedModules.contains('camera')) {
      permissions.writeln(
          '    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />');
      // permissions.writeln(
      //     '    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />');
      permissions.writeln(
          '    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />');
      permissions.writeln(
          '    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />');
    }
    if (selectedModules.contains('contacts')) {
      permissions.writeln(
          '    <uses-permission android:name="android.permission.READ_CONTACTS" />');
    }

    // Don't add twice – check a single known permission
    if (!content.contains('android.permission.INTERNET')) {
      // Insert just before <application ...>
      if (content.contains('<application')) {
        content = content.replaceFirst(
          '<application',
          '${permissions.toString()}\n    <application',
        );
      } else {
        // fallback: insert before closing </manifest>
        content = content.replaceFirst(
          '</manifest>',
          '${permissions.toString()}\n</manifest>',
        );
      }

      await manifestFile.writeAsString(content);
      logger.detail('✓ Updated AndroidManifest.xml with module permissions');
    } else {
      logger.detail(
          'AndroidManifest.xml already contains permissions, skipping.');
    }
  }

  Future<void> _configureIosInfoPlist() async {
    final infoPlistPath = path.join(
      projectName,
      'ios',
      'Runner',
      'Info.plist',
    );

    final plistFile = File(infoPlistPath);
    if (!await plistFile.exists()) {
      logger.warn('Info.plist not found at $infoPlistPath');
      return;
    }

    var content = await plistFile.readAsString();

    // Build usage descriptions based on selected modules
    final plistEntries = StringBuffer();

    if (selectedModules.contains('camera')) {
      plistEntries.writeln('    <key>NSCameraUsageDescription</key>');
      plistEntries.writeln(
          '    <string>This app requires access to the camera to capture photos and videos.</string>');
      plistEntries.writeln('    <key>NSMicrophoneUsageDescription</key>');
      plistEntries.writeln(
          '    <string>This app requires access to the microphone to record audio.</string>');
      plistEntries.writeln('    <key>NSPhotoLibraryUsageDescription</key>');
      plistEntries.writeln(
          '    <string>This app requires access to your photo library to select images.</string>');
      plistEntries.writeln('    <key>NSPhotoLibraryAddUsageDescription</key>');
      plistEntries.writeln(
          '    <string>This app saves photos to your library.</string>');
    }

    if (selectedModules.contains('speech') ||
        selectedModules.contains('recorder')) {
      plistEntries.writeln('    <key>NSMicrophoneUsageDescription</key>');
      plistEntries.writeln(
          '    <string>This app requires access to the microphone for speech recognition and audio recording.</string>');
    }

    if (selectedModules.contains('call')) {
      plistEntries.writeln('    <key>NSContactsUsageDescription</key>');
      plistEntries.writeln(
          '    <string>This app may access your contacts to make calls.</string>');
    }

    if (selectedModules.contains('contacts')) {
      plistEntries.writeln('    <key>NSContactsUsageDescription</key>');
      plistEntries.writeln(
          '    <string>This app requires access to your contacts.</string>');
    }

    // Avoid duplicating – check if we need to add any entries
    if (selectedModules.isNotEmpty &&
        !content.contains('NSCameraUsageDescription')) {
      // Insert before </dict>
      content = content.replaceFirst(
        '</dict>',
        '${plistEntries.toString()}\n</dict>',
      );

      await plistFile.writeAsString(content);
      logger.detail('✓ Updated iOS Info.plist with module usage descriptions');
    } else {
      logger.detail(
          'Info.plist already contains usage descriptions or no modules selected, skipping.');
    }
  }

  Future<void> _generateUtilityModules() async {
    if (selectedModules.isEmpty) {
      logger.info('⚙️  No utility modules selected, skipping...');
      return;
    }
    logger.info('⚙️ Generating utility modules (camera, voice, call)...');

    final modulesRoot = path.join(projectName, 'lib', 'core', 'modules');
    final cameraDir = path.join(modulesRoot, 'camera');
    final voiceDir = path.join(modulesRoot, 'voice');
    final callDir = path.join(modulesRoot, 'call');

    // Ensure directories exist
    await Directory(cameraDir).create(recursive: true);
    await Directory(voiceDir).create(recursive: true);
    await Directory(callDir).create(recursive: true);

    // Create modules root directory
    await Directory(modulesRoot).create(recursive: true);

    // Create module-specific directories only for selected modules
    for (final module in selectedModules) {
      final moduleDir = path.join(modulesRoot, module);
      await Directory(moduleDir).create(recursive: true);

      switch (module) {
        case 'camera':
          await FileUtils.writeFile(
            path.join(moduleDir, 'camera_service.dart'),
            ModulesTemplate.cameraService(projectName),
          );
          logger.detail('✓ Generated camera_service.dart');
          break;

        case 'speech':
          // Create voice directory for speech modules
          final voiceDir = path.join(modulesRoot, 'voice');
          await Directory(voiceDir).create(recursive: true);

          // Generate speech-to-text service
          await FileUtils.writeFile(
            path.join(voiceDir, 'speech_service.dart'),
            ModulesTemplate.speechService(),
          );
          logger.detail('✓ Generated speech_service.dart');

          // Generate text-to-speech service
          await FileUtils.writeFile(
            path.join(voiceDir, 'tts_service.dart'),
            ModulesTemplate.ttsService(),
          );
          logger.detail('✓ Generated tts_service.dart');
          break;

        case 'recorder':
          // Create voice directory for recorder
          final voiceDir = path.join(modulesRoot, 'voice');
          await Directory(voiceDir).create(recursive: true);

          // Generate audio recorder service
          await FileUtils.writeFile(
            path.join(voiceDir, 'audio_recorder_service.dart'),
            ModulesTemplate.audioRecorderService(),
          );
          logger.detail('✓ Generated audio_recorder_service.dart');
          break;

        case 'call':
          await FileUtils.writeFile(
            path.join(moduleDir, 'call_service.dart'),
            ModulesTemplate.callService(projectName),
          );
          logger.detail('✓ Generated call_service.dart');
          break;

        case 'contacts':
          // Create contacts directory
          final contactsDir = path.join(modulesRoot, 'contacts');
          await Directory(contactsDir).create(recursive: true);

          // Generate Contact model
          await FileUtils.writeFile(
            path.join(contactsDir, 'contact.dart'),
            ModulesTemplate.contactModel(),
          );
          logger.detail('✓ Generated contact.dart');

          // Generate PhoneContactsService
          await FileUtils.writeFile(
            path.join(contactsDir, 'phone_contacts_service.dart'),
            ModulesTemplate.contactsService(projectName),
          );
          logger.detail('✓ Generated phone_contacts_service.dart');
          break;
      }
    }

    // Generate barrel file for all selected modules
    await _generateModulesBarrelFile(modulesRoot, selectedModules);

    logger.success('✨ Utility modules generated successfully!');
  }

  Future<void> _generateModulesBarrelFile(
      String modulesRoot, List<String> selectedModules) async {
    final barrelContent = StringBuffer('''
// Barrel file for selected utility modules

''');

    for (final module in selectedModules) {
      switch (module) {
        case 'camera':
          barrelContent.writeln("export 'camera/camera_service.dart';");
          break;
        case 'speech':
          barrelContent.writeln("export 'voice/speech_service.dart';");
          barrelContent.writeln("export 'voice/tts_service.dart';");
          break;
        case 'recorder':
          barrelContent.writeln("export 'voice/audio_recorder_service.dart';");
          break;
        case 'call':
          barrelContent.writeln("export 'call/call_service.dart';");
          break;
        case 'contacts':
          barrelContent.writeln("export 'contacts/contact.dart';");
          barrelContent
              .writeln("export 'contacts/phone_contacts_service.dart';");
          break;
      }
    }

    final barrelPath = path.join(modulesRoot, 'modules.dart');
    await FileUtils.writeFile(barrelPath, barrelContent.toString());
    logger.detail('✓ Generated modules.dart (barrel file)');
  }

  Future<void> _generateEnhancedReusableWidgets() async {
    logger.info('🎨 Generating enhanced reusable widgets...');

    final widgetsBasePath = path.join(projectName, 'lib', 'shared', 'widgets');

    // Define widget structure
    final widgetFiles = {
      // Buttons
      'buttons/primary_button.dart':
          EnhancedWidgetsTemplate.generatePrimaryButton(),
      'buttons/secondary_button.dart':
          EnhancedWidgetsTemplate.generateSecondaryButton(),
      'buttons/social_auth_button.dart':
          EnhancedWidgetsTemplate.generateSocialAuthButton(),

      // Inputs
      'inputs/app_text_field.dart':
          EnhancedWidgetsTemplate.generateAppTextField(),
      'inputs/password_field.dart':
          EnhancedWidgetsTemplate.generatePasswordField(),
      'inputs/otp_input.dart': EnhancedWidgetsTemplate.generateOTPInput(),

      // Cards
      'cards/info_card.dart': EnhancedWidgetsPart2.generateInfoCard(),
      'cards/profile_card.dart': EnhancedWidgetsPart2.generateProfileCard(),

      // Navigation
      'navigation/custom_app_bar.dart':
          EnhancedWidgetsPart2.generateCustomAppBar(),
      'navigation/bottom_nav_bar.dart':
          EnhancedWidgetsPart2.generateBottomNavBar(),

      // States
      'states/app_loader.dart': EnhancedWidgetsPart2.generateAppLoader(),
      'states/empty_state.dart': EnhancedWidgetsPart2.generateEmptyState(),
      'states/error_state.dart': EnhancedWidgetsPart2.generateErrorState(),

      // Dialogs
      'dialogs/confirm_dialog.dart':
          EnhancedWidgetsPart2.generateConfirmDialog(),
    };

    // Create directories and generate files
    for (final entry in widgetFiles.entries) {
      final filePath = path.join(widgetsBasePath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      logger.detail('✓ Generated ${entry.key}');
    }

    // Generate barrel file
    await _generateWidgetsBarrelFile(widgetsBasePath);

    logger.success('✨ Enhanced widgets generated successfully!');
  }

  Future<void> _generateWidgetsBarrelFile(String widgetsDir) async {
    final barrelContent = '''
// Barrel file for shared widgets
// Import this file to access all reusable widgets

// Buttons
export 'buttons/primary_button.dart';
export 'buttons/secondary_button.dart';
export 'buttons/social_auth_button.dart';

// Inputs
export 'inputs/app_text_field.dart';
export 'inputs/password_field.dart';
export 'inputs/otp_input.dart';

// Cards
export 'cards/info_card.dart';
export 'cards/profile_card.dart';

// Navigation
export 'navigation/custom_app_bar.dart';
export 'navigation/bottom_nav_bar.dart';

// States
export 'states/app_loader.dart';
export 'states/empty_state.dart';
export 'states/error_state.dart';

// Dialogs
export 'dialogs/confirm_dialog.dart';
''';

    final barrelPath = path.join(widgetsDir, 'widgets.dart');
    await FileUtils.writeFile(barrelPath, barrelContent);
    logger.detail('✓ Generated widgets.dart (barrel file)');
  }

// UPDATE the generate() method in ProjectGenerator:
// Replace this line:
//   await _generateReusableWidgets();
// With:
//   await _generateEnhancedReusableWidgets();
  Future<void> _generateTheme() async {
    final themePath =
        path.join(projectName, 'lib', 'app', 'theme', 'app_theme.dart');
    await Directory(path.dirname(themePath)).create(recursive: true);

    final content = ThemeTemplate.generate(themeColor);
    await FileUtils.writeFile(themePath, content);
    logger
        .detail('Generated theme at $themePath with $themeColor color scheme');
  }

  Future<void> _generateFirebaseOperations() async {
    final firebaseDir = path.join(projectName, 'lib', 'core', 'firebase');
    await Directory(firebaseDir).create(recursive: true);

    final content = FirebaseOperationsTemplate.generate(firebaseModules);
    final filePath = path.join(firebaseDir, 'firebase_operations.dart');

    await FileUtils.writeFile(filePath, content);
    logger.detail(
        'Generated Firebase operations file with modules: ${firebaseModules.join(', ')}');
  }

  Future<void> _generateChatbot() async {
    logger.info('🤖 Generating AI Chatbot with BLoC...');

    final chatbotBasePath =
        path.join(projectName, 'lib', 'features', 'chatbot');

    // Create all necessary directories
    final directories = [
      path.join(chatbotBasePath, 'screens'),
      path.join(chatbotBasePath, 'services'),
      path.join(chatbotBasePath, 'models'),
      path.join(chatbotBasePath, 'bloc'),
    ];

    for (final dir in directories) {
      await Directory(dir).create(recursive: true);
    }

    // Generate Chatbot Screen (with BLoC)
    final chatbotScreenPath =
        path.join(chatbotBasePath, 'screens', 'chatbot_screen.dart');
    await FileUtils.writeFile(
      chatbotScreenPath,
      ChatbotTemplates.generateChatScreen(projectName),
    );
    logger.detail('✓ Generated chatbot_screen.dart');

    // Generate Chatbot Service
    final chatbotServicePath =
        path.join(chatbotBasePath, 'services', 'chatbot_service.dart');
    await FileUtils.writeFile(
      chatbotServicePath,
      ChatbotTemplates.generateChatbotService(projectName),
    );
    logger.detail('✓ Generated chatbot_service.dart');

    // Generate Chat Message Model
    final chatMessageModelPath =
        path.join(chatbotBasePath, 'models', 'chat_message_model.dart');
    await FileUtils.writeFile(
      chatMessageModelPath,
      ChatbotTemplates.generateChatMessageModel(),
    );
    logger.detail('✓ Generated chat_message_model.dart');

    // Generate BLoC files
    final blocPath = path.join(chatbotBasePath, 'bloc');

    // Generate chatbot_bloc.dart
    await FileUtils.writeFile(
      path.join(blocPath, 'chatbot_bloc.dart'),
      ChatbotTemplates.generateChatbotBloc(),
    );
    logger.detail('✓ Generated chatbot_bloc.dart');

    // Generate chatbot_event.dart
    await FileUtils.writeFile(
      path.join(blocPath, 'chatbot_event.dart'),
      ChatbotTemplates.generateChatbotEvent(),
    );
    logger.detail('✓ Generated chatbot_event.dart');

    // Generate chatbot_state.dart
    await FileUtils.writeFile(
      path.join(blocPath, 'chatbot_state.dart'),
      ChatbotTemplates.generateChatbotState(),
    );
    logger.detail('✓ Generated chatbot_state.dart');

    // Generate app_constants.dart
    final constantsDir = path.join(projectName, 'lib', 'core', 'constants');
    await Directory(constantsDir).create(recursive: true);

    final appConstantsPath = path.join(constantsDir, 'app_constants.dart');
    await FileUtils.writeFile(
      appConstantsPath,
      ChatbotTemplates.generateAppConstants(),
    );
    logger.detail('✓ Generated app_constants.dart');

    // Generate .env files
    final envPath = path.join(projectName, '.env');
    await FileUtils.writeFile(envPath, ChatbotTemplates.generateEnvFile());
    logger.detail('✓ Generated .env file');

    final envExamplePath = path.join(projectName, '.env.example');
    await FileUtils.writeFile(
        envExamplePath, ChatbotTemplates.generateEnvExampleFile());
    logger.detail('✓ Generated .env.example file');

    // Update .gitignore
    final gitignorePath = path.join(projectName, '.gitignore');
    final gitignoreExists = await File(gitignorePath).exists();

    if (gitignoreExists) {
      final currentContent = await File(gitignorePath).readAsString();
      final addition = ChatbotTemplates.generateGitignoreAddition();

      if (!currentContent.contains('.env')) {
        await File(gitignorePath).writeAsString(
          currentContent + addition,
          mode: FileMode.append,
        );
        logger.detail('✓ Updated .gitignore');
      }
    }

    logger.success(
        '✨ Chatbot generated successfully with BLoC state management!');
  }

  Future<void> _generateScreens() async {
    // Generate Splash Screen
    final splashScreenPath = path.join(
      projectName,
      'lib',
      'features',
      'app',
      'screens',
      'splash_screen.dart',
    );
    await Directory(path.dirname(splashScreenPath)).create(recursive: true);
    await FileUtils.writeFile(
      splashScreenPath,
      ScreenTemplates.generateSplashScreen(projectName),
    );
    logger.detail('Generated SplashScreen at $splashScreenPath');

    // Generate Onboarding Screen
    final onboardingScreenPath = path.join(
      projectName,
      'lib',
      'features',
      'app',
      'screens',
      'onboarding_screen.dart',
    );
    await FileUtils.writeFile(
      onboardingScreenPath,
      OnboardingTemplate.generate(projectName),
    );
    logger.detail('Generated OnboardingScreen at $onboardingScreenPath');

    // Generate Home Screen
    final homeScreenPath = path.join(
      projectName,
      'lib',
      'features',
      'home',
      'screens',
      'home_screen.dart',
    );
    await Directory(path.dirname(homeScreenPath)).create(recursive: true);
    await FileUtils.writeFile(
      homeScreenPath,
      ScreenTemplates.generateHomeScreen(projectName),
    );
    logger.detail('Generated HomeScreen at $homeScreenPath');

    // Generate Profile Screen
    final profileScreenPath = path.join(
      projectName,
      'lib',
      'features',
      'profile',
      'screens',
      'profile_screen.dart',
    );
    await Directory(path.dirname(profileScreenPath)).create(recursive: true);
    await FileUtils.writeFile(
      profileScreenPath,
      ScreenTemplates.generateProfileScreen(projectName),
    );
    logger.detail('Generated ProfileScreen at $profileScreenPath');

    // Generate Auth Screens based on authType
    await _generateAuthScreens();
  }

  Future<void> _generateAuthScreens() async {
    final authDir =
        path.join(projectName, 'lib', 'features', 'auth', 'screens');
    await Directory(authDir).create(recursive: true);

    switch (authType) {
      case 'email_password':
        await _generateEmailPasswordAuth(authDir);
        break;
      case 'username_password':
        await _generateUsernamePasswordAuth(authDir);
        break;
      case 'phone_otp':
        await _generatePhoneOTPAuth(authDir);
        break;
      case 'social_auth':
        await _generateSocialAuth(authDir);
        break;
      case 'all':
        await _generateAllAuth(authDir);
        break;
      default:
        await _generateEmailPasswordAuth(authDir);
    }
  }

  Future<void> _generateEmailPasswordAuth(String authDir) async {
    final loginPath = path.join(authDir, 'login_screen.dart');
    await FileUtils.writeFile(
      loginPath,
      ScreenTemplates.generateEmailPasswordLogin(projectName),
    );
    logger.detail('Generated Email/Password LoginScreen');

    final signupPath = path.join(authDir, 'signup_screen.dart');
    await FileUtils.writeFile(
      signupPath,
      ScreenTemplates.generateEmailPasswordSignup(projectName),
    );
    logger.detail('Generated Email/Password SignupScreen');
  }

  Future<void> _generateUsernamePasswordAuth(String authDir) async {
    final loginPath = path.join(authDir, 'login_screen.dart');
    await FileUtils.writeFile(
      loginPath,
      ScreenTemplates.generateUsernamePasswordLogin(projectName),
    );
    logger.detail('Generated Username/Password LoginScreen');

    final signupPath = path.join(authDir, 'signup_screen.dart');
    await FileUtils.writeFile(
      signupPath,
      ScreenTemplates.generateUsernamePasswordSignup(projectName),
    );
    logger.detail('Generated Username/Password SignupScreen');
  }

  Future<void> _generatePhoneOTPAuth(String authDir) async {
    final loginPath = path.join(authDir, 'login_screen.dart');
    await FileUtils.writeFile(
      loginPath,
      ScreenTemplates.generatePhoneOTPLogin(projectName),
    );
    logger.detail('Generated Phone/OTP LoginScreen');

    final otpPath = path.join(authDir, 'otp_verification_screen.dart');
    await FileUtils.writeFile(
      otpPath,
      ScreenTemplates.generateOTPVerification(projectName),
    );
    logger.detail('Generated OTP VerificationScreen');
  }

  Future<void> _generateSocialAuth(String authDir) async {
    final loginPath = path.join(authDir, 'login_screen.dart');
    await FileUtils.writeFile(
      loginPath,
      ScreenTemplates.generateSocialLogin(projectName),
    );
    logger.detail('Generated Social LoginScreen');
  }

  Future<void> _generateAllAuth(String authDir) async {
    final loginPath = path.join(authDir, 'login_screen.dart');
    await FileUtils.writeFile(
      loginPath,
      ScreenTemplates.generateUnifiedLogin(projectName),
    );
    logger.detail('Generated Unified LoginScreen');

    final signupPath = path.join(authDir, 'signup_screen.dart');
    await FileUtils.writeFile(
      signupPath,
      ScreenTemplates.generateUnifiedSignup(projectName),
    );
    logger.detail('Generated Unified SignupScreen');

    final otpPath = path.join(authDir, 'otp_verification_screen.dart');
    await FileUtils.writeFile(
      otpPath,
      ScreenTemplates.generateOTPVerification(projectName),
    );
    logger.detail('Generated OTP VerificationScreen');
  }

  Future<void> _generateRouter() async {
    final routerPath =
        path.join(projectName, 'lib', 'app', 'router', 'app_router.dart');
    await Directory(path.dirname(routerPath)).create(recursive: true);

    final content =
        AppRouterTemplate.generate(projectName, includeChatbot: includeChatbot);
    await FileUtils.writeFile(routerPath, content);
    logger.detail('Generated router at $routerPath');
  }

  Future<void> _generateTestFile() async {
    final testPath = path.join(projectName, 'test', 'widget_test.dart');

    final content = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:$projectName/main.dart';

void main() {
  testWidgets('App loads without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
  });
}
''';

    await FileUtils.writeFile(testPath, content);
    logger.detail('Wrote test widget_test.dart for $projectName');
  }

  Future<void> _generateMainFile() async {
    final mainPath = path.join(projectName, 'lib', 'main.dart');
    final content = MainTemplate.generate(
      projectName: projectName,
      stateManagement: stateManagement,
      includeFirebase: includeFirebase,
      useRouter: true,
      useTheme: true,
      includeLocalization: selectedLanguages.length > 1,
    );
    await FileUtils.writeFile(mainPath, content);
    logger.detail('Generated main.dart at $mainPath');

    // Generate FeatureService
    await _generateFeatureService();
  }

  Future<void> _generateFeatureService() async {
    final featureServicePath = path.join(
      projectName,
      'lib',
      'core',
      'services',
      'feature_service.dart',
    );
    await Directory(path.dirname(featureServicePath)).create(recursive: true);
    await FileUtils.writeFile(
      featureServicePath,
      OnboardingTemplate.generateService(),
    );
    logger.detail('Generated FeatureService at $featureServicePath');
  }

  Future<void> _createFlutterProject() async {
    final result = await Process.run(
      'flutter',
      ['create', '--org', organization, projectName],
      runInShell: true,
    );

    if (result.exitCode != 0) {
      throw Exception('Failed to create Flutter project: ${result.stderr}');
    }
  }

  Future<void> _generateFolderStructure() async {
    final libPath = path.join(projectName, 'lib');

    final folders = [
      'app',
      'app/router',
      'app/theme',
      'app/di',
      'features/app/screens',
      'features/auth/screens',
      'features/auth/widgets',
      'features/auth/services',
      'features/auth/models',
      'features/home/screens',
      'features/home/widgets',
      'features/home/services',
      'features/home/models',
      'features/profile/screens',
      'features/profile/widgets',
      'features/chatbot/screens',
      'features/chatbot/services',
      'features/chatbot/models',
      'features/chatbot/bloc',
      'shared/widgets',
      'shared/services',
      'shared/utils',
      'shared/constants',
      'shared/repositories',
      'core/errors',
      'core/network',
      'core/storage',
      'core/config',
      'core/services',
      'core/firebase',
      'core/constants',
      'config',
      'models',
      'providers',
    ];

    for (final folder in folders) {
      final dir = Directory(path.join(libPath, folder));
      if (!await dir.exists()) {
        await dir.create(recursive: true);
        logger.detail('Created folder: ${dir.path}');
      }
    }
  }

  Future<void> _generatePubspec() async {
    final pubspecPath = path.join(projectName, 'pubspec.yaml');
    final content = PubspecTemplate.generate(
      projectName: projectName,
      stateManagement: stateManagement,
      includeFirebase: includeFirebase,
      firebaseModules: firebaseModules,
      includeChatbot: includeChatbot,
    );
    await FileUtils.writeFile(pubspecPath, content);
    logger.detail('Generated pubspec.yaml');
  }

  Future<void> _runFlutterPubGet() async {
    final result = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: projectName,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      logger.warn('Warning: flutter pub get failed. Run it manually.');
    }
  }

  Future<void> _configureFirebase() async {
    logger.info('');
    logger.info('🔥 Setting up Firebase...');

    // Check if Firebase CLI is installed first (required for flutterfire)
    bool firebaseCliInstalled = await _isCommandAvailable('firebase');
    if (!firebaseCliInstalled) {
      logger.warn('Firebase CLI is not installed.');
      logger.info('📦 Installing Firebase CLI...');

      final installResult = await Process.run(
        'npm',
        ['install', '-g', 'firebase-tools'],
        runInShell: true,
      );

      if (installResult.exitCode != 0) {
        logger.warn('Failed to install Firebase CLI. Please install manually:');
        logger.info('  npm install -g firebase-tools');
        logger
            .info('  OR for Mac/Linux: curl -sL https://firebase.tools | bash');
        logger.info('Skipping Firebase configuration...');
        logger.info('');
        return;
      }
      logger.success('✓ Firebase CLI installed successfully!');
    }

    // Check if user is logged into Firebase
    bool isLoggedIn = await _isFirebaseLoggedIn();
    if (!isLoggedIn) {
      logger.warn('Not logged into Firebase CLI.');
      logger.info('Please login to Firebase:');
      logger.info('  1. Open a new terminal');
      logger.info('  2. Run: firebase login');
      logger.info('  3. Follow the authentication flow');
      logger.info('');
      logger.info('Skipping Firebase configuration for now...');
      logger.info('You can configure Firebase later with:');
      logger.info('  cd $projectName && flutterfire configure');
      logger.info('');
      return;
    }

    // Check if flutterfire CLI is installed
    bool flutterfireInstalled = await _isCommandAvailable('flutterfire');
    if (!flutterfireInstalled) {
      logger.warn('FlutterFire CLI is not installed.');
      logger.info('📦 Installing FlutterFire CLI...');

      final installResult = await Process.run(
        'dart',
        ['pub', 'global', 'activate', 'flutterfire_cli'],
        runInShell: true,
      );

      if (installResult.exitCode != 0) {
        logger.warn('Failed to install FlutterFire CLI.');
        logger.info('Please install manually:');
        logger.info('  dart pub global activate flutterfire_cli');
        logger.info('');
        logger.info('Skipping Firebase configuration for now...');
        logger.info('You can configure Firebase later with:');
        logger.info('  cd $projectName && flutterfire configure');
        logger.info('');
        return;
      }
      logger.success('✓ FlutterFire CLI installed successfully!');
    }

    logger.info('');
    logger.info('⚠️  Running flutterfire configure...');
    logger.info('This will:');
    logger.info('  1. Show available Firebase projects');
    logger.info('  2. Let you select platforms (iOS, Android, Web)');
    logger.info('  3. Download Firebase config files');
    logger.info('  4. Update pubspec.yaml with Firebase dependencies');
    logger.info('');

    // Ask for confirmation before running
    final confirm = await logger.prompt(
      'Continue with Firebase configuration? (y/N)',
      defaultValue: 'n',
    );

    if (confirm.toLowerCase() != 'y') {
      logger.info('Skipping Firebase configuration.');
      logger.info('You can configure later with:');
      logger.info('  cd $projectName && flutterfire configure');
      return;
    }

    try {
      // Run flutterfire configure interactively
      logger.info('Running: flutterfire configure --project=$projectName');

      final configProcess = Process.start(
        'flutterfire',
        ['configure', '--project=$projectName'],
        workingDirectory: projectName,
        mode: ProcessStartMode.inheritStdio,
      );

      final process = await configProcess;
      final exitCode = await process.exitCode;

      if (exitCode == 0) {
        logger.success('✓ Firebase configured successfully!');

        // Show next steps
        logger.info('');
        logger.info('📝 Next steps:');
        logger.info('  1. Add Firebase initialization code to your app');
        logger.info('  2. Implement Firebase services (Auth, Firestore, etc.)');
        logger.info('  3. Run: flutter pub get');
        logger.info('');
      } else {
        logger.warn('Firebase configuration exited with code: $exitCode');
        logger.info('You can try again later with:');
        logger.info('  cd $projectName && flutterfire configure');
      }
    } catch (e) {
      logger.warn('Error running flutterfire configure: $e');
      logger.info('');
      logger.info('You can configure Firebase manually:');
      logger.info(
          '  1. Create a Firebase project at: https://console.firebase.google.com/');
      logger.info('  2. Run: cd $projectName && flutterfire configure');
      logger.info('');
    }
  }

  // Helper method to check if a command is available
  Future<bool> _isCommandAvailable(String command) async {
    try {
      if (Platform.isWindows) {
        final result = await Process.run('where', [command], runInShell: true);
        return result.exitCode == 0;
      } else {
        final result = await Process.run('which', [command], runInShell: true);
        return result.exitCode == 0;
      }
    } catch (e) {
      return false;
    }
  }

  // Helper method to check if user is logged into Firebase
  Future<bool> _isFirebaseLoggedIn() async {
    try {
      final result = await Process.run(
        'firebase',
        ['projects:list'],
        runInShell: true,
      );
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  Future<void> _generateDockerSetup() async {
    logger.info('');
    logger.info('🐳 Generating Docker setup...');

    // Import Docker templates at the top
    // For now, we'll inline the templates or assume they're accessible

    // Generate Dockerfile
    final dockerfilePath = path.join(projectName, 'Dockerfile');
    await FileUtils.writeFile(
        dockerfilePath, DockerTemplates.generateDockerfile());
    logger.detail('✓ Generated Dockerfile');

    // Generate nginx.conf
    final nginxPath = path.join(projectName, 'nginx.conf');
    await FileUtils.writeFile(nginxPath, DockerTemplates.generateNginxConfig());
    logger.detail('✓ Generated nginx.conf');

    // Generate docker-compose.yml
    final dockerComposePath = path.join(projectName, 'docker-compose.yml');
    await FileUtils.writeFile(
      dockerComposePath,
      DockerTemplates.generateDockerCompose(projectName),
    );
    logger.detail('✓ Generated docker-compose.yml');

    // Generate docker-compose.prod.yml
    final dockerComposeProdPath =
        path.join(projectName, 'docker-compose.prod.yml');
    await FileUtils.writeFile(
      dockerComposeProdPath,
      DockerTemplates.generateDockerComposeProduction(projectName),
    );
    logger.detail('✓ Generated docker-compose.prod.yml');

    // Generate .dockerignore
    final dockerignorePath = path.join(projectName, '.dockerignore');
    await FileUtils.writeFile(
        dockerignorePath, DockerTemplates.generateDockerignore());
    logger.detail('✓ Generated .dockerignore');

    // Generate Makefile
    final makefilePath = path.join(projectName, 'Makefile');
    await FileUtils.writeFile(
        makefilePath, DockerTemplates.generateMakefile(projectName));
    logger.detail('✓ Generated Makefile');

    // Generate DOCKER.md
    final dockerReadmePath = path.join(projectName, 'DOCKER.md');
    await FileUtils.writeFile(
      dockerReadmePath,
      DockerTemplates.generateDockerReadme(projectName),
    );
    logger.detail('✓ Generated DOCKER.md');

    // Generate GitHub Actions workflow
    final workflowDir = path.join(projectName, '.github', 'workflows');
    await Directory(workflowDir).create(recursive: true);

    final workflowPath = path.join(workflowDir, 'docker-build.yml');
    await FileUtils.writeFile(
      workflowPath,
      DockerTemplates.generateGithubActionsDocker(projectName),
    );
    logger.detail('✓ Generated GitHub Actions workflow');

    logger.success('✨ Docker setup generated successfully!');
    logger.info('');
    logger.info('🐳 Docker Commands:');
    logger.info('  make build      - Build Docker image');
    logger.info('  make run        - Run production');
    logger.info('  make dev        - Run development with hot-reload');
    logger.info('  make stop       - Stop containers');
    logger.info('  make logs       - View logs');
    logger.info('');
    logger.info('📖 See DOCKER.md for complete documentation');
  }

  Future<void> _generateLocalization() async {
    // If for some reason list is empty, bail early (shouldn't happen now)
    if (selectedLanguages.isEmpty) {
      logger.detail('No languages selected, skipping localization.');
      return;
    }

    logger.info('');
    logger.info('🌍 Generating localization files...');

    // Always ensure 'en' is included as base/template
    final langs = {
      'en',
      ...selectedLanguages,
    }.toList();

    // Create l10n directory
    final l10nDir = path.join(projectName, 'lib', 'l10n');
    await Directory(l10nDir).create(recursive: true);

    // Generate l10n.yaml
    final l10nConfigPath = path.join(projectName, 'l10n.yaml');
    await FileUtils.writeFile(
      l10nConfigPath,
      LocalizationTemplates.generateL10nConfig(langs),
    );
    logger.detail('✓ Generated l10n.yaml');

    // Generate English ARB (template)
    final enArbPath = path.join(l10nDir, 'app_en.arb');
    await FileUtils.writeFile(
      enArbPath,
      LocalizationTemplates.generateEnglishArb(),
    );
    logger.detail('✓ Generated app_en.arb (template)');

    // Generate ARB files for other selected languages
    for (final lang in langs) {
      if (lang == 'en') continue;

      final arbPath = path.join(l10nDir, 'app_$lang.arb');
      await FileUtils.writeFile(
        arbPath,
        LocalizationTemplates.generateArbFile(lang),
      );
      logger.detail('✓ Generated app_$lang.arb');
    }

    // Generate LocaleProvider
    final providersDir = path.join(projectName, 'lib', 'core', 'providers');
    await Directory(providersDir).create(recursive: true);

    final localeProviderPath = path.join(providersDir, 'locale_provider.dart');
    await FileUtils.writeFile(
      localeProviderPath,
      LocalizationTemplates.generateLocaleProvider(projectName),
    );
    logger.detail('✓ Generated locale_provider.dart');

    // Generate LanguageSelector widget
    final languageSelectorPath = path.join(
      projectName,
      'lib',
      'shared',
      'widgets',
      'language_selector.dart',
    );
    await FileUtils.writeFile(
      languageSelectorPath,
      LocalizationTemplates.generateLanguageSelector(projectName),
    );
    logger.detail('✓ Generated language_selector.dart');

    // Generate LOCALIZATION.md
    final localizationReadmePath = path.join(projectName, 'LOCALIZATION.md');
    await FileUtils.writeFile(
      localizationReadmePath,
      LocalizationTemplates.generateLocalizationReadme(),
    );
    logger.detail('✓ Generated LOCALIZATION.md');

    logger.success('✨ Localization generated successfully!');
    logger.info('');
    logger.info('🌍 Supported Languages: ${langs.join(', ')}');
    logger.info('');
    logger.info('Generating localization files...');

    // Run flutter gen-l10n to generate the localization files
    final genL10nResult = await Process.run(
      'flutter',
      ['gen-l10n'],
      workingDirectory: projectName,
      runInShell: true,
    );

    if (genL10nResult.exitCode == 0) {
      logger.success('✓ Localization files generated successfully');
    } else {
      logger.warn(
          'Warning: flutter gen-l10n failed. You may need to run it manually.');
      logger.detail('stdout: ${genL10nResult.stdout}');
      logger.detail('stderr: ${genL10nResult.stderr}');
      logger.detail('Run: cd $projectName && flutter gen-l10n');
    }

    logger.info('');
    logger.info('📖 See LOCALIZATION.md for usage guide');
  }
}
