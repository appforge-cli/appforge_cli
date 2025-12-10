class ModulesTemplate {
  // 📷 Camera service
  static String cameraService() {
    return '''
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Simple camera/gallery helper.
///
/// Usage:
/// final file = await CameraService.pickImageFromCamera();
/// final file = await CameraService.pickImageFromGallery();
class CameraService {
  static final ImagePicker _picker = ImagePicker();

  /// Pick an image using the device camera.
  static Future<File?> pickImageFromCamera() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (picked == null) return null;
    return File(picked.path);
  }

  /// Pick an image from the gallery.
  static Future<File?> pickImageFromGallery() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return null;
    return File(picked.path);
  }
}
''';
  }

  // 🎤 Speech-to-text
  static String speechService() {
    return '''
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Simple wrapper around speech_to_text.
///
/// Usage:
/// final speech = SpeechService();
/// await speech.init();
/// await speech.startListening(onResult: (text) { /* use text */ });
/// await speech.stopListening();
class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _available = false;

  bool get isAvailable => _available;
  bool get isListening => _speech.isListening;

  Future<bool> init() async {
    _available = await _speech.initialize(
      onStatus: (status) {
        if (kDebugMode) {
          debugPrint('Speech status: \$status');
        }
      },
      onError: (error) {
        if (kDebugMode) {
          debugPrint('Speech error: \$error');
        }
      },
    );
    return _available;
  }

  Future<void> startListening({
    required ValueChanged<String> onResult,
    String localeId = 'en_US',
  }) async {
    if (!_available) {
      final ok = await init();
      if (!ok) return;
    }

    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      localeId: localeId,
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  Future<void> cancel() async {
    await _speech.cancel();
  }
}
''';
  }

  // 🔊 Text-to-speech
  static String ttsService() {
    return '''
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Text → Speech helper.
///
/// Usage:
/// final tts = TtsService();
/// await tts.speak("Hello there");
class TtsService {
  final FlutterTts _tts = FlutterTts();

  TtsService() {
    _tts.setSpeechRate(0.5);
    _tts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }

  Future<void> dispose() async {
    try {
      await _tts.stop();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('TTS dispose error: \$e');
      }
    }
  }
}
''';
  }

  // 🎙️ Audio recorder
  static String audioRecorderService() {
    return '''
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Simple audio recorder wrapper.
///
/// Usage:
/// final recorder = AudioRecorderService();
/// await recorder.startRecording();
/// final path = await recorder.stopRecording();
class AudioRecorderService {
  final AudioRecorder _record = AudioRecorder();

  Future<bool> hasPermission() async {
    return await _record.hasPermission();
  }

  Future<void> startRecording() async {
    if (!await hasPermission()) return;

    final dir = await getTemporaryDirectory();
    final filePath =
        '\${dir.path}/recording_\${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _record.start(
      RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: filePath,
    );
  }

  Future<String?> stopRecording() async {
    try {
      final path = await _record.stop();
      if (kDebugMode) {
        debugPrint('Recorded file: \$path');
      }
      return path;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Stop recording error: \$e');
      }
      return null;
    }
  }

  Future<void> dispose() async {
    await _record.dispose();
  }
}
''';
  }

  // 📞 Call intent
  static String callService() {
    return '''
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper to open the phone dialer or start a call.
///
/// Usage:
/// await CallService.callNumber("+919876543210");
class CallService {
  static Future<void> callNumber(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (kDebugMode) {
          debugPrint('Could not launch dialer for \$phoneNumber');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error launching dialer: \$e');
      }
    }
  }
}
''';
  }
}
