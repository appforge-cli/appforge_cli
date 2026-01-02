import 'dart:io';
import 'package:path/path.dart' as path;

class FileUtils {
  static Future<void> writeFile(String filePath, String content) async {
    final file = File(filePath);

    // Create parent directory if it doesn't exist
    final directory = file.parent;
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    await file.writeAsString(content);
  }

  static Future<String> readFile(String filePath) async {
    final file = File(filePath);
    return await file.readAsString();
  }

  static Future<bool> fileExists(String filePath) async {
    return await File(filePath).exists();
  }

  static Future<void> copyDirectory(
      Directory source, Directory destination) async {
    await destination.create(recursive: true);

    await for (final entity in source.list(recursive: false)) {
      if (entity is Directory) {
        final newDirectory = Directory(
          path.join(destination.path, path.basename(entity.path)),
        );
        await copyDirectory(entity, newDirectory);
      } else if (entity is File) {
        await entity.copy(
          path.join(destination.path, path.basename(entity.path)),
        );
      }
    }
  }

  static Future<void> deleteDirectory(Directory directory) async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }
}
