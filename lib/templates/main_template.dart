class MainTemplate {
  static String generate({
    required String projectName,
    required String stateManagement,
    required bool includeFirebase,
    required bool useRouter,
    required bool useTheme,
    bool includeLocalization = false,
  }) {
    // --- Firebase imports block ---
    final firebaseImports = includeFirebase
        ? '''
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
'''
        : '';

    // --- Feature Service imports ---
    final featureServiceImports = '''
import 'package:$projectName/core/services/feature_service.dart';
''';

    // --- Localization imports block (your actual setup) ---
    final localizationImports = includeLocalization
        ? '''
import 'package:$projectName/l10n/app_localizations.dart';
import 'package:provider/provider.dart' as provider_pkg;
import 'package:$projectName/core/providers/locale_provider.dart';
'''
        : '';

    // --- Firebase init code in main() ---
    final firebaseInit = includeFirebase
        ? '''
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
'''
        : '';

    // --- Feature Service init code in main() ---
    final featureServiceInit = '''
  await FeatureService.initialize();
''';

    // --- Localization config inside MaterialApp.router ---
    final localizationSupport = includeLocalization
        ? '''
      // Localization
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localeProvider.locale,
'''
        : '';

    // State management specific code
    String stateManagementSetup = '';
    String appWidget = '';

    switch (stateManagement) {
      case 'riverpod':
        if (includeLocalization) {
          // riverpod + localization
          stateManagementSetup = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
$featureServiceInit
  runApp(
    ProviderScope(
      child: provider_pkg.ChangeNotifierProvider(
        create: (_) => LocaleProvider(),
        child: const MyApp(),
      ),
    ),
  );
}
''';
          appWidget = '''
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeProvider = provider_pkg.Provider.of<LocaleProvider>(context);

    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
$localizationSupport
      routerConfig: appRouter,
    );
  }
}
''';
        } else {
          // riverpod without localization
          stateManagementSetup = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
$featureServiceInit
  runApp(const ProviderScope(child: MyApp()));
}
''';
          appWidget = '''
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
''';
        }
        break;

      case 'provider':
        if (includeLocalization) {
          stateManagementSetup = '''
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
$featureServiceInit
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}
''';
          appWidget = '''
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
$localizationSupport
      routerConfig: appRouter,
    );
  }
}
''';
        } else {
          stateManagementSetup = '''
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
$featureServiceInit
  runApp(const MyApp());
}
''';
          appWidget = '''
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
''';
        }
        break;

      case 'bloc':
        if (includeLocalization) {
          stateManagementSetup = '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
$featureServiceInit
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}
''';
          appWidget = '''
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
$localizationSupport
      routerConfig: appRouter,
    );
  }
}
''';
        } else {
          stateManagementSetup = '''
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
$featureServiceInit
  runApp(const MyApp());
}
''';
          appWidget = '''
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
''';
        }
        break;

      default:
        if (includeLocalization) {
          stateManagementSetup = '''
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
$featureServiceInit
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}
''';
          appWidget = '''
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
$localizationSupport
      routerConfig: appRouter,
    );
  }
}
''';
        } else {
          stateManagementSetup = '''
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
$featureServiceInit
  runApp(const MyApp());
}
''';
          appWidget = '''
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
''';
        }
    }

    return '''
import 'package:flutter/material.dart';
import 'package:$projectName/app/theme/app_theme.dart';
import 'package:$projectName/app/router/app_router.dart';
$firebaseImports$localizationImports$featureServiceImports
$stateManagementSetup

$appWidget
''';
  }
}
