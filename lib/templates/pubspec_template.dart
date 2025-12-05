class PubspecTemplate {
  static String generate({
    required String projectName,
    required String stateManagement,
    required bool includeFirebase,
  }) {
    // Build dependencies list
    final stateManagementDeps = <String>[];
    switch (stateManagement) {
      case 'riverpod':
        stateManagementDeps.add('  flutter_riverpod: ^2.6.1');
        break;
      case 'provider':
        stateManagementDeps.add('  provider: ^6.1.2');
        break;
      case 'bloc':
        stateManagementDeps.add('  flutter_bloc: ^8.1.6');
        stateManagementDeps.add('  equatable: ^2.0.7');
        break;
    }

    // Firebase dependencies
    final firebaseDeps = <String>[];
    if (includeFirebase) {
      firebaseDeps.addAll([
        '  firebase_core: ^3.8.1',
        '  firebase_auth: ^5.3.4',
        '  cloud_firestore: ^5.5.2',
        '  firebase_storage: ^12.3.8',
        '  firebase_analytics: ^11.3.8',
      ]);
    }

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
  
  # Routing
  go_router: ^14.6.2
  
  # State Management
${stateManagementDeps.isEmpty ? '  # No state management selected' : stateManagementDeps.join('\n')}
  
${firebaseDeps.isEmpty ? '' : '  # Firebase\n${firebaseDeps.join('\n')}\n  '}
  # Utilities
  http: ^1.2.2
  shared_preferences: ^2.3.3
  dio: ^5.7.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.13

flutter:
  uses-material-design: true

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