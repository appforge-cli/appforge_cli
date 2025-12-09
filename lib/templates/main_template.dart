class MainTemplate {
  static String generate({
    required String projectName,
    required String stateManagement,
    required bool includeFirebase,
    required bool useRouter,
    required bool useTheme,
    bool includeLocalization = false,
  }) {
    final firebaseImports = includeFirebase
        ? '''
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
'''
        : '';

    final localizationImports = includeLocalization
        ? '''
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:$projectName/core/providers/locale_provider.dart';
'''
        : '';

    final firebaseInit = includeFirebase
        ? '''
//  await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  );
'''
        : '';

    final localizationSupport = includeLocalization
        ? '''
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('it'),
        Locale('pt'),
        Locale('ru'),
        Locale('zh'),
        Locale('ja'),
        Locale('ar'),
        Locale('hi'),
        Locale('bn'),
        Locale('te'),
        Locale('mr'),
        Locale('ta'),
        Locale('gu'),
        Locale('kn'),
        Locale('ml'),
        Locale('pa'),
        Locale('or'),
      ],
      locale: localeProvider.locale,
'''
        : '';

    // State management specific code
    String stateManagementSetup = '';
    String appWidget = '';

    switch (stateManagement) {
      case 'riverpod':
        stateManagementSetup = '''
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
  runApp(${includeLocalization ? 'const ProviderScope(child: LocaleWrapper())' : 'const ProviderScope(child: MyApp())'});
}
''';
        
        if (includeLocalization) {
          appWidget = '''
class LocaleWrapper extends ConsumerWidget {
  const LocaleWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) {
          return const MyApp();
        },
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
$localizationSupport
      routerConfig: router,
    );
  }
}
''';
        } else {
          appWidget = '''
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
''';
        }
        break;

      case 'provider':
        stateManagementSetup = '''
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
  runApp(${includeLocalization ? 'ChangeNotifierProvider(\n    create: (_) => LocaleProvider(),\n    child: const MyApp(),\n  )' : 'const MyApp()'});
}
''';

        if (includeLocalization) {
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
        stateManagementSetup = '''
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
  runApp(${includeLocalization ? 'ChangeNotifierProvider(\n    create: (_) => LocaleProvider(),\n    child: const MyApp(),\n  )' : 'const MyApp()'});
}
''';

        if (includeLocalization) {
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
        stateManagementSetup = '''
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
$firebaseInit
  runApp(${includeLocalization ? 'ChangeNotifierProvider(\n    create: (_) => LocaleProvider(),\n    child: const MyApp(),\n  )' : 'const MyApp()'});
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

    return '''
import 'package:flutter/material.dart';
import 'package:$projectName/app/theme/app_theme.dart';
import 'package:$projectName/app/router/app_router.dart';
$firebaseImports$localizationImports
$stateManagementSetup

$appWidget
''';
  }
}