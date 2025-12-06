import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:superapp_cli/templates/app_router_template.dart';
import 'package:superapp_cli/templates/firebase_operations_template.dart';
import 'package:superapp_cli/templates/main_template.dart';
import 'package:superapp_cli/templates/pubspec_template.dart';
import 'package:superapp_cli/templates/theme_template.dart';
import 'package:superapp_cli/templates/screen_templates.dart';
import 'package:superapp_cli/templates/widgets_template.dart' show ReusableWidgetsTemplate;
import 'package:superapp_cli/utils/file_utils.dart';

class ProjectGenerator {
  ProjectGenerator({
    required this.projectName,
    required this.organization,
    required this.stateManagement,
    required this.includeFirebase,
    this.firebaseModules = const [],
    required this.themeColor,
    required this.authType,
    required this.logger,
  });

  final String projectName;
  final String organization;
  final String stateManagement;
  final bool includeFirebase;
  final List<String> firebaseModules;
  final String themeColor;
  final String authType;
  final Logger logger;

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
    await _generateReusableWidgets();

    // Step 6: Generate Firebase operations if enabled
    if (includeFirebase && firebaseModules.isNotEmpty) {
      await _generateFirebaseOperations();
    }

    // Step 7: Generate screens
    await _generateScreens();

    // Step 8: Generate router
    await _generateRouter();

    // Step 9: Generate main.dart
    await _generateMainFile();

    // Step 10: Replace default test with a compatible smoke test
    await _generateTestFile();

    // Step 11: Run flutter pub get
    await _runFlutterPubGet();

    // Step 12: Configure Firebase if needed
    if (includeFirebase) {
      await _configureFirebase();
    }

    logger.success('✨ Project generated successfully with $themeColor theme!');
  }

  Future<void> _generateTheme() async {
    final themePath = path.join(projectName, 'lib', 'app', 'theme', 'app_theme.dart');
    await Directory(path.dirname(themePath)).create(recursive: true);

    final content = ThemeTemplate.generate(themeColor);
    await FileUtils.writeFile(themePath, content);
    logger.detail('Generated theme at $themePath with $themeColor color scheme');
  }

  Future<void> _generateFirebaseOperations() async {
    final firebaseDir = path.join(projectName, 'lib', 'core', 'firebase');
    await Directory(firebaseDir).create(recursive: true);

    final content = FirebaseOperationsTemplate.generate(firebaseModules);
    final filePath = path.join(firebaseDir, 'firebase_operations.dart');
    
    await FileUtils.writeFile(filePath, content);
    logger.detail('Generated Firebase operations file with modules: ${firebaseModules.join(', ')}');
  }

  Future<void> _generateReusableWidgets() async {
    final widgetsDir = path.join(projectName, 'lib', 'shared', 'widgets');
    await Directory(widgetsDir).create(recursive: true);

    final widgets = {
      'custom_app_bar.dart': ReusableWidgetsTemplate.generateCustomAppBar(),
      'custom_bottom_nav_bar.dart': ReusableWidgetsTemplate.generateBottomNavBar(),
      'loading_indicators.dart': ReusableWidgetsTemplate.generateLoadingIndicators(),
      'custom_cards.dart': ReusableWidgetsTemplate.generateCustomCards(),
      'custom_buttons.dart': ReusableWidgetsTemplate.generateCustomButtons(),
      'empty_states.dart': ReusableWidgetsTemplate.generateEmptyStates(),
      'custom_input_fields.dart': ReusableWidgetsTemplate.generateCustomInputFields(),
      'dialog_helper.dart': ReusableWidgetsTemplate.generateDialogHelpers(),
      'snackbar_helper.dart': ReusableWidgetsTemplate.generateSnackbarHelpers(),
      'custom_list_tiles.dart': ReusableWidgetsTemplate.generateListTiles(),
      'custom_avatar.dart': ReusableWidgetsTemplate.generateAvatarWidget(),
      'custom_badge.dart': ReusableWidgetsTemplate.generateBadgeWidget(),
    };

    for (final entry in widgets.entries) {
      final widgetPath = path.join(widgetsDir, entry.key);
      await FileUtils.writeFile(widgetPath, entry.value);
      logger.detail('Generated ${entry.key}');
    }

    // Generate barrel file for easy imports
    await _generateWidgetsBarrelFile(widgetsDir, widgets.keys.toList());
  }

  Future<void> _generateWidgetsBarrelFile(String widgetsDir, List<String> fileNames) async {
    final exports = fileNames.map((name) => "export '$name';").join('\n');
    final barrelContent = '''
// Barrel file for shared widgets
// Import this file to access all reusable widgets
$exports
''';
    
    final barrelPath = path.join(widgetsDir, 'widgets.dart');
    await FileUtils.writeFile(barrelPath, barrelContent);
    logger.detail('Generated widgets barrel file');
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
    final authDir = path.join(projectName, 'lib', 'features', 'auth', 'screens');
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
    final routerPath = path.join(projectName, 'lib', 'app', 'router', 'app_router.dart');
    await Directory(path.dirname(routerPath)).create(recursive: true);

    final content = AppRouterTemplate.generate(projectName);
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
    );
    await FileUtils.writeFile(mainPath, content);
    logger.detail('Generated main.dart at $mainPath');
  }

  Future<void> _createFlutterProject() async {
    final result = await Process.run(
      'flutter',
      ['create', '--org', organization, projectName],
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
      'shared/widgets',
      'shared/services',
      'shared/utils',
      'shared/constants',
      'shared/repositories',
      'core/errors',
      'core/network',
      'core/storage',
      'core/config',
      'core/firebase',
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
    );
    await FileUtils.writeFile(pubspecPath, content);
    logger.detail('Generated pubspec.yaml');
  }

  Future<void> _runFlutterPubGet() async {
    final result = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: projectName,
    );

    if (result.exitCode != 0) {
      logger.warn('Warning: flutter pub get failed. Run it manually.');
    }
  }

  Future<void> _configureFirebase() async {
    logger.info('');
    logger.info('🔥 Setting up Firebase...');
    
    // Check if flutterfire CLI is installed
    final checkResult = await Process.run('flutterfire', ['--version']);
    
    if (checkResult.exitCode != 0) {
      logger.warn('FlutterFire CLI is not installed.');
      logger.info('');
      logger.info('📦 Installing FlutterFire CLI...');
      logger.info('Run this command:');
      logger.info('  dart pub global activate flutterfire_cli');
      logger.info('');
      logger.info('Then configure Firebase:');
      logger.info('  cd $projectName');
      logger.info('  flutterfire configure');
      logger.info('');
      return;
    }

    logger.info('Running flutterfire configure...');
    logger.info('');
    logger.info('⚠️  You will need:');
    logger.info('  • A Firebase project (create at https://console.firebase.google.com)');
    logger.info('  • Firebase CLI logged in (run: firebase login)');
    logger.info('');

    // Run flutterfire configure interactively
    final configResult = await Process.start(
      'flutterfire',
      ['configure', '--project=$projectName'],
      workingDirectory: projectName,
      mode: ProcessStartMode.inheritStdio,
    );

    final exitCode = await configResult.exitCode;

    if (exitCode == 0) {
      logger.success('✓ Firebase configured successfully!');
    } else {
      logger.warn('Firebase configuration incomplete.');
      logger.info('');
      logger.info('To configure manually:');
      logger.info('  cd $projectName');
      logger.info('  flutterfire configure');
    }
  }
}