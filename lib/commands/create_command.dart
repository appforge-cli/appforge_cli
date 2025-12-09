// ignore: unused_import
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:interact/interact.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:superapp_cli/generators/project_generator.dart';

class CreateCommand extends Command<int> {
  CreateCommand({required this.logger}) {
    argParser
      ..addOption(
        'name',
        abbr: 'n',
        help: 'The name of the app',
      )
      ..addOption(
        'org',
        abbr: 'o',
        help: 'Organization identifier (com.example)',
        defaultsTo: 'com.example',
      )
      ..addOption(
        'state',
        abbr: 's',
        help: 'State management: provider, riverpod, or bloc',
        allowed: ['provider', 'riverpod', 'bloc'],
      )
      ..addOption(
        'theme',
        abbr: 't',
        help: 'Theme color: blue, green, coffee, purple, or orange',
        allowed: ['blue', 'green', 'coffee', 'purple', 'orange'],
      )
      ..addFlag(
        'firebase',
        abbr: 'f',
        help: 'Include Firebase configuration',
        defaultsTo: false,
      )
      ..addFlag(
        'docker',
        abbr: 'd',
        help: 'Include Docker setup for deployment',
        defaultsTo: false,
      )
      ..addFlag(
        'yes',
        abbr: 'y',
        help: 'Run non-interactively with sensible defaults',
        defaultsTo: false,
      )
      ..addFlag(
        'no-interactive',
        help: 'Alias: run non-interactively (same as --yes)',
        defaultsTo: false,
      );
  }

  final Logger logger;

  @override
  String get description => 'Create a new production-ready Flutter app';

  @override
  String get name => 'create';

  @override
  Future<int> run() async {
    // Read CLI options (may be null)
    final projectName = argResults?['name'] as String? ?? _promptForName();
    final org = argResults?['org'] as String;
    String? stateManagement = argResults?['state'] as String?; // nullable
    String? themeColor = argResults?['theme'] as String?; // nullable
    
    // Check if firebase flag was explicitly provided
    final firebaseFlagProvided = argResults?.wasParsed('firebase') ?? false;
    bool? includeFirebase = firebaseFlagProvided ? (argResults?['firebase'] as bool?) : null;

    // Check if docker flag was explicitly provided
    final dockerFlagProvided = argResults?.wasParsed('docker') ?? false;
    bool? includeDocker = dockerFlagProvided ? (argResults?['docker'] as bool?) : null;

    // Non-interactive flags
    final nonInteractive = (argResults?['yes'] as bool) == true ||
        (argResults?['no-interactive'] as bool) == true;

    if (!_isValidProjectName(projectName)) {
      logger.err('Invalid project name. Use lowercase with underscores.');
      return 1;
    }

    // Allowed options
    final allowedStates = ['provider', 'riverpod', 'bloc'];
    final allowedThemes = ['blue', 'green', 'coffee', 'purple', 'orange'];
    final allowedAuthTypes = [
      'email_password',
      'username_password',
      'phone_otp',
      'social_auth',
      'all'
    ];

    // Prompt for state management only if not provided and interactive allowed
    if (stateManagement == null) {
      if (!nonInteractive) {
        stateManagement = logger.chooseOne(
          '🔧 Choose state management:',
          choices: allowedStates,
          defaultValue: 'riverpod',
        );
      } else {
        stateManagement = 'riverpod';
        logger.detail('No state provided; defaulting to "riverpod" in non-interactive mode.');
      }
    } else {
      if (!allowedStates.contains(stateManagement)) {
        logger.err('Invalid --state value. Allowed: provider, riverpod, bloc');
        return 1;
      }
    }

    // Prompt for theme color only if not provided and interactive allowed
    if (themeColor == null) {
      if (!nonInteractive) {
        themeColor = logger.chooseOne(
          '🎨 Choose your theme color:',
          choices: allowedThemes,
          defaultValue: 'blue',
        );
      } else {
        themeColor = 'blue';
        logger.detail('No theme provided; defaulting to "blue" in non-interactive mode.');
      }
    } else {
      if (!allowedThemes.contains(themeColor)) {
        logger.err('Invalid --theme value. Allowed: blue, green, coffee, purple, orange');
        return 1;
      }
    }

    // Prompt for authentication type
    String authType;
    if (!nonInteractive) {
      logger.info('');
      authType = logger.chooseOne(
        '🔐 Choose authentication type:',
        choices: [
          'email_password - Email & Password',
          'username_password - Username & Password',
          'phone_otp - Phone Number & OTP',
          'social_auth - Google & Apple Sign-In',
          'all - All authentication methods',
        ],
        defaultValue: 'email_password - Email & Password',
      );
      // Extract the key before the dash
      authType = authType.split(' ').first;
    } else {
      authType = 'email_password';
      logger.detail('No auth type provided; defaulting to "email_password" in non-interactive mode.');
    }

    // Prompt for Chatbot
    bool includeChatbot = false;
    if (!nonInteractive) {
      logger.info('');
      includeChatbot = logger.confirm(
        '🤖 Include AI Chatbot (Gemini)?',
        defaultValue: false,
      );
    }

    // Prompt for Firebase if not provided
    List<String> firebaseModules = [];
    if (includeFirebase == null && !nonInteractive) {
      logger.info('');
      includeFirebase = logger.confirm(
        '🔥 Include Firebase?',
        defaultValue: false,
      );
      
      if (includeFirebase) {
        // Ask which Firebase modules to include
        logger.info('');
        final selectedModules = logger.chooseAny(
          '📦 Select Firebase modules (space to select, enter to continue):',
          choices: [
            'auth - Authentication',
            'firestore - Cloud Firestore (NoSQL Database)',
            'storage - Cloud Storage',
            'fcm - Cloud Messaging (Push Notifications)',
          ],
          defaultValues: ['auth - Authentication'],
        );
        
        // Extract module keys
        firebaseModules = selectedModules.map((m) => m.split(' ').first).toList();
        
        // Core is always included if any module is selected
        if (firebaseModules.isNotEmpty && !firebaseModules.contains('core')) {
          firebaseModules.insert(0, 'core');
        }
      }
    } else if (includeFirebase == null) {
      includeFirebase = false;
      logger.detail('Firebase not specified; defaulting to false in non-interactive mode.');
    } else if (includeFirebase) {
      // If Firebase enabled via flag, include all modules by default
      firebaseModules = ['core', 'auth', 'firestore', 'storage', 'fcm'];
    }

    // Prompt for Docker if not provided
    if (includeDocker == null && !nonInteractive) {
      logger.info('');
      includeDocker = logger.confirm(
        '🐳 Include Docker setup for deployment?',
        defaultValue: false,
      );
    } else if (includeDocker == null) {
      includeDocker = false;
      logger.detail('Docker not specified; defaulting to false in non-interactive mode.');
    }

    // Prompt for localization
    List<String> selectedLanguages = ['en']; // English is always included
    if (!nonInteractive) {
      logger.info('');
      final wantsLocalization = logger.confirm(
        '🌍 Enable multi-language support?',
        defaultValue: false,
      );

      if (wantsLocalization) {
        logger.info('');
        logger.info('Select additional languages (English is already included):');
        
        final availableLanguages = [
          'es - Spanish (Español)',
          'fr - French (Français)',
          'de - German (Deutsch)',
          'it - Italian (Italiano)',
          'pt - Portuguese (Português)',
          'ru - Russian (Русский)',
          'zh - Chinese (中文)',
          'ja - Japanese (日本語)',
          'ar - Arabic (العربية)',
          'hi - Hindi (हिन्दी)',
          'bn - Bengali (বাংলা)',
          'te - Telugu (తెలుగు)',
          'mr - Marathi (मराठी)',
          'ta - Tamil (தமிழ்)',
          'gu - Gujarati (ગુજરાતી)',
          'kn - Kannada (ಕನ್ನಡ)',
          'ml - Malayalam (മലയാളം)',
          'pa - Punjabi (ਪੰਜਾਬੀ)',
          'or - Odia (ଓଡ଼ିଆ)',
        ];

        final selected = logger.chooseAny(
          '📦 Select languages (space to select, enter to continue):',
          choices: availableLanguages,
          defaultValues: [],
        );

        // Extract language codes
        final langCodes = selected.map((s) => s.split(' ').first).toList();
        selectedLanguages.addAll(langCodes.cast<String>());
      }
    }

    // Show summary before proceeding
    if (!nonInteractive) {
      logger
        ..info('')
        ..info('📋 Project Summary:')
        ..info('  Name: $projectName')
        ..info('  Organization: $org')
        ..info('  State Management: $stateManagement')
        ..info('  Theme: ${_getThemeEmoji(themeColor!)} $themeColor')
        ..info('  Auth Type: ${_getAuthTypeDisplay(authType)}')
        ..info('  AI Chatbot: ${includeChatbot ? '🤖 Yes' : '✗ No'}')
        ..info('  Firebase: ${includeFirebase ? '🔥 Yes' : '✗ No'}')
        ..info('  Docker: ${includeDocker ? '🐳 Yes' : '✗ No'}')
        ..info('  Languages: 🌍 ${selectedLanguages.join(', ')}');
      
      if (includeFirebase && firebaseModules.isNotEmpty) {
        logger.info('  Firebase Modules: ${firebaseModules.join(', ')}');
      }
      
      logger.info('');

      final confirm = logger.confirm(
        'Continue with these settings?',
        defaultValue: true,
      );

      if (!confirm) {
        logger.info('❌ Project creation cancelled');
        return 0;
      }
    }

    final progress = logger.progress('Creating Flutter app: $projectName');

    try {
      final generator = ProjectGenerator(
        projectName: projectName,
        organization: org,
        stateManagement: stateManagement!,
        includeFirebase: includeFirebase,
        firebaseModules: firebaseModules,
        includeChatbot: includeChatbot,
        includeDocker: includeDocker,
        selectedLanguages: selectedLanguages,
        themeColor: themeColor!,
        authType: authType,
        logger: logger,
      );

      await generator.generate();
      progress.complete('Project created successfully!');
            // Run flutterfire configure inside the generated project folder
      if (includeFirebase == true) {
        logger.info('');
        logger.info('Running flutterfire configure inside ./$projectName ...');

        final success = await _runFlutterFireConfigure(
          projectName: projectName,
          logger: logger,
        );

        if (!success) {
          logger.warn('Firebase configuration incomplete.');

          logger.info('');
          logger.info('To configure manually later:');
          logger.info('  cd $projectName');
          logger.info('  flutterfire configure');
        }
      }

      logger
        ..info('')
        ..success('✨ Flutter app created: $projectName')
        ..success('🎨 Theme: ${_getThemeEmoji(themeColor)} $themeColor')
        ..success('🔐 Auth: ${_getAuthTypeDisplay(authType)}')
        ..success('🤖 AI Chatbot: ${includeChatbot ? 'Enabled (Gemini)' : 'Disabled'}')
        ..success('🔥 Firebase: ${includeFirebase ? 'Enabled' : 'Disabled'}')
        ..success('🐳 Docker: ${includeDocker ? 'Enabled' : 'Disabled'}')
        ..success('🌍 Languages: ${selectedLanguages.join(', ')}');
      
      if (includeFirebase && firebaseModules.isNotEmpty) {
        logger.success('   Modules: ${firebaseModules.join(', ')}');
      }
      
      logger
        ..info('')
        ..info('Next steps:')
        ..info('  1. cd $projectName');
      
      if (includeChatbot) {
        logger.info('  2. Add your Gemini API key in lib/core/constants/app_constants.dart');
        logger.info('  3. flutter run');
      } else {
        logger.info('  2. flutter run');
      }

      if (includeDocker) {
        logger
          ..info('')
          ..info('🐳 Docker is ready!')
          ..info('  • make build    - Build Docker image')
          ..info('  • make run      - Run production')
          ..info('  • make dev      - Development with hot-reload')
          ..info('  • See DOCKER.md for complete documentation');
      }
      
      logger
        ..info('')
        ..info('📱 Your app includes:')
        ..info('  • Splash Screen with smooth transitions')
        ..info('  • Home Screen with stats and quick actions')
        ..info('  • Profile Screen with settings')
        ..info('  • ${_getAuthScreensDescription(authType)}')
        ..info('  • Light & Dark mode support')
        ..info('  • Responsive design for phones and tablets')
        ..info('  • Go Router navigation with deep linking')
        ..info('  • 12+ reusable widgets (cards, buttons, loaders, etc.)')
        ..info('  • Custom app bar & bottom navigation')
        ..info('  • Dialog & snackbar helpers');

      if (includeChatbot) {
        logger.info('  • AI Chatbot powered by Google Gemini');
        logger.info('  • Beautiful chat UI with message bubbles');
        logger.info('  • Real-time typing indicators');
        logger.info('  • BLoC state management for chat');
      }

      if (includeFirebase && firebaseModules.isNotEmpty) {
        logger.info('  • Firebase operations file (CRUD ready)');
        if (firebaseModules.contains('auth')) {
          logger.info('    - Authentication (sign up, sign in, profile)');
        }
        if (firebaseModules.contains('firestore')) {
          logger.info('    - Firestore (CRUD, queries, real-time streams)');
        }
        if (firebaseModules.contains('storage')) {
          logger.info('    - Storage (upload, download, delete files)');
        }
        if (firebaseModules.contains('fcm')) {
          logger.info('    - Cloud Messaging (push notifications)');
        }
      }

      if (includeDocker) {
        logger.info('  • Docker multi-stage build (Flutter + Nginx)');
        logger.info('  • Docker Compose for easy orchestration');
        logger.info('  • Production-ready with PostgreSQL & Redis');
        logger.info('  • Makefile for convenient commands');
        logger.info('  • GitHub Actions CI/CD workflow');
      }

      if (selectedLanguages.length > 1) {
        logger.info('  • Multi-language support (${selectedLanguages.length} languages)');
        logger.info('  • Language selector widget');
        logger.info('  • Persistent language preference');
        logger.info('  • RTL support for Arabic');
      }
      
      logger.info('');

      return 0;
    } catch (e, st) {
      progress.fail('Failed to create project');
      logger.err('Error: $e');
      logger.detail(st.toString());
      return 1;
    }
  }
  Future<bool> _runFlutterFireConfigure({
    required String projectName,
    required Logger logger,
  }) async {
    try {
      // Start flutterfire configure in the generated app folder
      final process = await Process.start(
        'flutterfire',
        ['configure'],
        workingDirectory: projectName, // 👈 this is your "cd projectName"
        runInShell: true,
      );

      // Pipe stdout/stderr to current console so user sees prompts
      stdout.addStream(process.stdout);
      stderr.addStream(process.stderr);

      // Optional: if you want to allow user to type into flutterfire:
      // stdin.pipe(process.stdin);

      final exitCode = await process.exitCode;

      if (exitCode == 0) {
        logger.success('✓ flutterfire configure completed successfully.');
        return true;
      } else {
        logger.err('flutterfire configure exited with code $exitCode.');
        return false;
      }
    } on ProcessException catch (e) {
      logger.err('Failed to run flutterfire configure: ${e.message}');
      logger.info('Make sure FlutterFire CLI is installed:');
      logger.info('  dart pub global activate flutterfire_cli');
      logger.info('  flutterfire --version');
      return false;
    } catch (e) {
      logger.err('Unexpected error while running flutterfire configure: $e');
      return false;
    }
  }

  String _promptForName() {
    return logger.prompt(
      '📝 What is your app name?',
      defaultValue: 'my_app',
    );
  }

  bool _isValidProjectName(String name) {
    final regex = RegExp(r'^[a-z][a-z0-9_]*$');
    return regex.hasMatch(name);
  }

  String _getThemeEmoji(String theme) {
    switch (theme) {
      case 'blue':
        return '💙';
      case 'green':
        return '💚';
      case 'coffee':
        return '☕';
      case 'purple':
        return '💜';
      case 'orange':
        return '🧡';
      default:
        return '🎨';
    }
  }

  String _getAuthTypeDisplay(String authType) {
    switch (authType) {
      case 'email_password':
        return 'Email & Password';
      case 'username_password':
        return 'Username & Password';
      case 'phone_otp':
        return 'Phone Number & OTP';
      case 'social_auth':
        return 'Google & Apple Sign-In';
      case 'all':
        return 'All authentication methods';
      default:
        return 'Email & Password';
    }
  }

  String _getAuthScreensDescription(String authType) {
    switch (authType) {
      case 'email_password':
        return 'Login & Signup with Email/Password';
      case 'username_password':
        return 'Login & Signup with Username/Password';
      case 'phone_otp':
        return 'Login & Signup with Phone & OTP verification';
      case 'social_auth':
        return 'Social login with Google & Apple';
      case 'all':
        return 'Complete auth suite (Email, Username, Phone OTP, Social)';
      default:
        return 'Login & Signup screens';
    }
  }
}