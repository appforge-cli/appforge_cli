import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:superapp_cli/templates/app_router_template.dart';
import 'package:superapp_cli/templates/main_template.dart';
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
    required this.themeColor,
    required this.logger,
  });

  final String projectName;
  final String organization;
  final String stateManagement;
  final bool includeFirebase;
  final String themeColor;
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

    // Step 5: Generate screens
    await _generateScreens();

    // Step 6: Generate router
    await _generateRouter();

    // Step 7: Generate main.dart
    await _generateMainFile();

    // Step 8: Replace default test with a compatible smoke test
    await _generateTestFile();

    // Step 9: Run flutter pub get
    await _runFlutterPubGet();

    // Step 10: Configure Firebase if needed
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

  Future<void> _generateScreens() async {
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

    // Generate Login Screen
    final loginScreenPath = path.join(
      projectName,
      'lib',
      'features',
      'auth',
      'screens',
      'login_screen.dart',
    );
    await Directory(path.dirname(loginScreenPath)).create(recursive: true);
    await FileUtils.writeFile(
      loginScreenPath,
      ScreenTemplates.generateLoginScreen(projectName),
    );
    logger.detail('Generated LoginScreen at $loginScreenPath');
  }

  Future<void> _generateRouter() async {
    final routerPath = path.join(projectName, 'lib', 'app', 'router', 'app_router.dart');
    await Directory(path.dirname(routerPath)).create(recursive: true);

    final content = AppRouterTemplate.generate();
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
    );
    await FileUtils.writeFile(pubspecPath, content);
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