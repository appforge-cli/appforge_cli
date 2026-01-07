class PubspecTemplate {
  static String generate({
    required String projectName,
    required String stateManagement,
    required bool includeFirebase,
    List<String> firebaseModules = const [],
    bool includeChatbot = false,
    List<String> selectedLanguages = const ['en'],
  }) {
    // Track if provider is already added
    bool hasProvider = false;

    // Build dependencies list
    final stateManagementDeps = <String>[];
    switch (stateManagement) {
      case 'riverpod':
        stateManagementDeps.add('  flutter_riverpod: ^2.6.1');
        // Add provider if localization is enabled (for LocaleProvider)
        if (selectedLanguages.length > 1) {
          stateManagementDeps.add('  provider: ^6.1.2');
          hasProvider = true;
        }
        break;
      case 'provider':
        stateManagementDeps.add('  provider: ^6.1.2');
        hasProvider = true;
        break;
      case 'bloc':
        stateManagementDeps.add('  flutter_bloc: ^8.1.6');
        stateManagementDeps.add('  equatable: ^2.0.7');
        // Add provider if localization is enabled (for LocaleProvider)
        if (selectedLanguages.length > 1) {
          stateManagementDeps.add('  provider: ^6.1.2');
          hasProvider = true;
        }
        break;
    }

    // Firebase dependencies based on selected modules
    final firebaseDeps = <String>[];
    if (includeFirebase) {
      if (firebaseModules.isEmpty) {
        // Backward compatibility - include all if no modules specified
        firebaseDeps.addAll([
          '  firebase_core: ^3.8.1',
          '  firebase_auth: ^5.3.4',
          '  cloud_firestore: ^5.5.2',
          '  firebase_storage: ^12.3.8',
          '  firebase_analytics: ^11.3.8',
        ]);
      } else {
        // Add only selected modules
        if (firebaseModules.contains('core') || firebaseModules.length > 1) {
          firebaseDeps.add('  firebase_core: ^3.8.1');
        }
        if (firebaseModules.contains('auth')) {
          firebaseDeps.add('  firebase_auth: ^5.3.4');
        }
        if (firebaseModules.contains('firestore')) {
          firebaseDeps.add('  cloud_firestore: ^5.5.2');
        }
        if (firebaseModules.contains('storage')) {
          firebaseDeps.add('  firebase_storage: ^12.3.8');
        }
        if (firebaseModules.contains('fcm')) {
          firebaseDeps.add('  firebase_messaging: ^15.1.5');
          firebaseDeps.add('  flutter_local_notifications: ^18.0.1');
        }
        firebaseDeps.add('  firebase_analytics: ^11.3.8');
      }
    }

    // Chatbot dependencies
    final chatbotDeps = <String>[];
    if (includeChatbot) {
      chatbotDeps.addAll([
        '  # AI Chatbot',
        '  dio: ^5.7.0',
        '  flutter_bloc: ^8.1.6',
        '  equatable: ^2.0.7',
      ]);

      // Remove duplicates if bloc is already added for state management
      if (stateManagement == 'bloc') {
        chatbotDeps.removeWhere(
            (dep) => dep.contains('flutter_bloc') || dep.contains('equatable'));
      }
    }

    // Build utilities section - only add provider if not already added
    final utilitiesDeps = StringBuffer();
    utilitiesDeps.writeln('  # Utilities');
    utilitiesDeps.writeln('  http: ^1.2.2');
    utilitiesDeps.writeln('  shared_preferences: ^2.3.3');
    utilitiesDeps.writeln('  image_picker: ^1.0.7');
    utilitiesDeps.writeln('  permission_handler: ^11.3.1');
    utilitiesDeps.writeln('  speech_to_text: ^7.3.0');
    utilitiesDeps.writeln('  flutter_tts: ^4.0.2');
    utilitiesDeps.writeln('  record: ^6.1.2');
    utilitiesDeps.writeln('  path_provider: ^2.1.4');
    utilitiesDeps.writeln('  url_launcher: ^6.3.0');
    utilitiesDeps.writeln('  flutter_contacts: ^1.1.7');
    utilitiesDeps.writeln('  geolocator: ^13.0.2');
    utilitiesDeps.writeln('  geocoding: ^3.0.0');
    // Only add provider if not already added by state management or localization
    if (!hasProvider) {
      utilitiesDeps.writeln('  provider: ^6.1.5+1');
    }

    utilitiesDeps.writeln('  ');
    utilitiesDeps.write(
        '  ${includeChatbot ? '# dio already included for chatbot' : 'dio: ^5.7.0'}');

    return '''
name: $projectName
description: A production-ready Flutter application
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.5.0

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any
  
  # Routing
  go_router: ^14.6.2
  
  # State Management
${stateManagementDeps.isEmpty ? '  # No state management selected' : stateManagementDeps.join('\n')}
  
${firebaseDeps.isEmpty ? '' : '  # Firebase\n${firebaseDeps.join('\n')}\n  '}
${chatbotDeps.isEmpty ? '' : '${chatbotDeps.join('\n')}\n  '}
${utilitiesDeps.toString()}

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.13

flutter:
  uses-material-design: true
  generate: true

  # assets:
  #   - images/
  #   - assets/

  # fonts:
  #   - family: CustomFont
  #     fonts:
  #       - asset: fonts/CustomFont-Regular.ttf
  #       - asset: fonts/CustomFont-Bold.ttf
  #         weight: 700
''';
  }
}
