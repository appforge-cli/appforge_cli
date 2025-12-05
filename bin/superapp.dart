import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:superapp_cli/commands/create_command.dart';
import 'package:mason_logger/mason_logger.dart';

void main(List<String> arguments) async {
  final logger = Logger();
  
  final runner = CommandRunner<int>(
    'superapp',
    'Generate production-ready Flutter apps instantly',
  )
    ..addCommand(CreateCommand(logger: logger))
    ..argParser.addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Print the current version.',
    );

  try {
    final results = runner.parse(arguments);
    
    if (results['version'] == true) {
      logger.info('superapp_cli version: 1.0.0');
      exit(0);
    }

    final exitCode = await runner.runCommand(results) ?? 0;
    exit(exitCode);
  } on UsageException catch (e) {
    logger
      ..err(e.message)
      ..info('')
      ..info(e.usage);
    exit(64);
  } catch (e) {
    logger.err('$e');
    exit(1);
  }
}