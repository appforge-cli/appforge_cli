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
    bool? includeFirebase = argResults?['firebase'] as bool?;

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

    // Prompt for Firebase if not provided
    if (includeFirebase == null && !nonInteractive) {
      logger.info('');
      includeFirebase = logger.confirm(
        '🔥 Include Firebase?',
        defaultValue: false,
      );
    } else if (includeFirebase == null) {
      includeFirebase = false;
      logger.detail('Firebase not specified; defaulting to false in non-interactive mode.');
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
        ..info('  Firebase: ${includeFirebase ? '🔥 Yes' : '✗ No'}')
        ..info('');

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
        themeColor: themeColor!,
        authType: authType,
        logger: logger,
      );

      await generator.generate();
      progress.complete('Project created successfully!');

      logger
        ..info('')
        ..success('✨ Flutter app created: $projectName')
        ..success('🎨 Theme: ${_getThemeEmoji(themeColor)} $themeColor')
        ..success('🔐 Auth: ${_getAuthTypeDisplay(authType)}')
        ..success('🔥 Firebase: ${includeFirebase ? 'Enabled' : 'Disabled'}')
        ..info('')
        ..info('Next steps:')
        ..info('  1. cd $projectName')
        ..info('  2. flutter run')
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

      if (includeFirebase) {
        logger.info('  • Firebase integration ready');
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