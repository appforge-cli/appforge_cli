class ModulesTemplate {
  static String locationService(String projectName) {
    return '''
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service for handling location operations
/// 
/// Features:
/// - Get current location (one-time)
/// - Stream location updates (continuous)
/// - Calculate distance between coordinates
/// - Check location services and permissions
/// - Open location settings
class LocationService {
  /// Get the current device location
  /// 
  /// Returns [Position] with latitude, longitude, altitude, etc.
  /// Throws [PermissionDeniedException] if permission denied
  /// Throws [LocationServiceDisabledException] if location services disabled
  Future<Position> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException('Location services are disabled');
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw PermissionDeniedException('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw PermissionDeniedException(
        'Location permissions are permanently denied',
      );
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Get continuous location updates as a stream
  /// 
  /// [distanceFilter] - minimum distance (in meters) before update
  /// [intervalDuration] - minimum time between updates
  Stream<Position> getLocationStream({
    double distanceFilter = 10, // 10 meters
    Duration intervalDuration = const Duration(seconds: 5),
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter.toInt(),
        timeLimit: intervalDuration,
      ),
    );
  }

  /// Calculate distance between two coordinates in meters
  /// 
  /// Returns distance in meters
  double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Calculate bearing between two coordinates in degrees
  /// 
  /// Returns bearing in degrees (0-360)
  double calculateBearing(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Check current location permission status
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Request location permission
  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  /// Open location settings page
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  /// Open app settings (for when permission is permanently denied)
  Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  /// Get last known position (may be null or outdated)
  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  /// Format position as a readable string
  String formatPosition(Position position) {
    return 'Lat: \${position.latitude.toStringAsFixed(6)}, '
        'Lon: \${position.longitude.toStringAsFixed(6)}';
  }

  /// Format distance in a human-readable way
  String formatDistance(double meters) {
    if (meters < 1000) {
      return '\${meters.toStringAsFixed(0)} m';
    } else {
      return '\${(meters / 1000).toStringAsFixed(2)} km';
    }
  }
}

/// Exception thrown when location services are disabled
class LocationServiceDisabledException implements Exception {
  final String message;
  LocationServiceDisabledException(this.message);
  
  @override
  String toString() => message;
}

/// Exception thrown when location permission is denied
class PermissionDeniedException implements Exception {
  final String message;
  PermissionDeniedException(this.message);
  
  @override
  String toString() => message;
}
''';
  }

  // 📷 Camera service
  static String cameraService(String projectName) {
    return '''
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:$projectName/core/services/feature_service.dart';

/// Simple camera/gallery helper.
///
/// Usage:
/// final file = await CameraService.pickImageFromCamera();
/// final file = await CameraService.pickImageFromGallery();
class CameraService {
  static final ImagePicker _picker = ImagePicker();

  /// Pick an image using the device camera.
  static Future<File?> pickImageFromCamera() async {
    if (!FeatureService.isCameraEnabled) {
      throw Exception('Camera feature is disabled. Enable it in settings.');
    }
    
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (picked == null) return null;
    return File(picked.path);
  }

  /// Pick an image from the gallery.
  static Future<File?> pickImageFromGallery() async {
    if (!FeatureService.isImagePickerEnabled) {
      throw Exception('Image picker feature is disabled. Enable it in settings.');
    }
    
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
  static String callService(String projectName) {
    return '''
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:$projectName/core/services/feature_service.dart';

/// Helper to open the phone dialer or start a call.
///
/// Usage:
/// await CallService.callNumber("+919876543210");
/// await CallService.callNumber("9876543210");
class CallService {
  static Future<void> callNumber(String phoneNumber) async {
    if (!FeatureService.isCallEnabled) {
      throw Exception('Call feature is disabled. Enable it in settings.');
    }

    // Normalize the phone number: remove spaces, dashes, parentheses
    String normalized = phoneNumber.replaceAll(RegExp(r'[\\s\\-\\(\\)]'), '');

    // If number doesn't start with +, add +91 (India default)
    if (!normalized.startsWith('+')) {
      // If it starts with 0, remove it and add +91
      if (normalized.startsWith('0')) {
        normalized = '+91\${normalized.substring(1)}';
      } else {
        normalized = '+91\$normalized';
      }
    }

    final uri = Uri.parse('tel:\$normalized');

    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Dialer launch failed: \$e');
      }
      throw Exception('Unable to open dialer');
    }
  }
}
''';
  }

  static String contactModel() {
    return '''
class Contact {
  final String name;
  final String phoneNumber;

  Contact({
    required this.name,
    required this.phoneNumber,
  });

  @override
  String toString() => '\$name - \$phoneNumber';
}
''';
  }

  static String contactsService(String projectName) {
    return '''
import 'package:flutter_contacts/flutter_contacts.dart' as fc;
import 'package:permission_handler/permission_handler.dart';
import 'package:$projectName/core/modules/contacts/contact.dart';
import 'package:$projectName/core/services/feature_service.dart';

class PhoneContactsService {
  static Future<Contact?> pickContact() async {
    if (!FeatureService.isContactsEnabled) {
      throw Exception('Contacts feature is disabled. Enable it in settings.');
    }

    final status = await Permission.contacts.request();
    if (!status.isGranted) {
      throw Exception('Contacts permission denied.');
    }

    try {
      final fc.Contact? picked = await fc.FlutterContacts.openExternalPick();
      if (picked == null) return null;

      final name = picked.displayName.isNotEmpty
          ? picked.displayName
          : 'Unknown';
      final phoneNumber = picked.phones.isNotEmpty
          ? picked.phones.first.number
          : '';

      if (phoneNumber.isEmpty) {
        throw Exception('Selected contact has no phone number.');
      }

      return Contact(name: name, phoneNumber: phoneNumber);
    } catch (e) {
      throw Exception('Error picking contact: \$e');
    }
  }
}
''';
  }
}
