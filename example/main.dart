import 'package:mason_logger/mason_logger.dart';

void main() {
  final logger = Logger();

  logger.info('AppForge CLI Example');
  logger.info('');
  logger.info('AppForge is a command-line tool for generating');
  logger.info('production-ready Flutter applications.');
  logger.info('');
  logger.info('To create a new Flutter app, run:');
  logger.info('');
  logger.info('  appforge create');
  logger.info('');
  logger.info('See example/README.md for detailed usage.');
}
