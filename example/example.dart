/// Example demonstrating how to use AppForge CLI programmatically
library;

import 'package:appforge_cli/generators/project_generator.dart';
import 'package:mason_logger/mason_logger.dart';

void main() async {
  final logger = Logger();

  // Basic project with minimal configuration
  await generateBasicProject(logger);

  // Advanced project with all features
  await generateAdvancedProject(logger);
}

/// Generates a basic Flutter project with Provider state management
Future<void> generateBasicProject(Logger logger) async {
  final generator = ProjectGenerator(
    projectName: 'basic_app',
    organization: 'com.example',
    stateManagement: 'provider',
    includeFirebase: false,
    themeColor: 'blue',
    authType: 'email_password',
    logger: logger,
  );

  await generator.generate();
  logger.success('Basic project generated successfully!');
}

/// Generates an advanced Flutter project with Firebase, chatbot, and localization
Future<void> generateAdvancedProject(Logger logger) async {
  final generator = ProjectGenerator(
    projectName: 'advanced_app',
    organization: 'com.example',
    stateManagement: 'bloc',
    includeFirebase: true,
    firebaseModules: ['auth', 'firestore', 'storage'],
    includeChatbot: true,
    includeDocker: true,
    includeWeb: true,
    selectedModules: ['camera', 'speech', 'recorder'],
    selectedLanguages: ['en', 'es', 'fr'],
    themeColor: 'purple',
    authType: 'all',
    logger: logger,
  );

  await generator.generate();
  logger.success('Advanced project generated successfully!');
}
