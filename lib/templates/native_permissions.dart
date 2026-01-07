// 1. UPDATE: native_permissions.dart - Add location permissions
class NativePermissions {
  static final Map<String, List<String>> android = {
    'camera': [
      'android.permission.CAMERA',
      'android.permission.RECORD_AUDIO',
      'android.permission.READ_MEDIA_IMAGES',
      'android.permission.READ_MEDIA_VIDEO',
    ],
    'speech': [
      'android.permission.RECORD_AUDIO',
    ],
    'recorder': [
      'android.permission.RECORD_AUDIO',
    ],
    'call': [
      'android.permission.CALL_PHONE',
    ],
    'contacts': [
      'android.permission.READ_CONTACTS',
      'android.permission.WRITE_CONTACTS',
    ],
    'location': [
      'android.permission.ACCESS_FINE_LOCATION',
      'android.permission.ACCESS_COARSE_LOCATION',
      'android.permission.ACCESS_BACKGROUND_LOCATION', // For background location
    ],
  };

  static final Map<String, Map<String, String>> ios = {
    'camera': {
      'NSCameraUsageDescription':
          'Camera access is required to capture photos and videos.',
      'NSPhotoLibraryUsageDescription':
          'Photo library access is required to select images.',
      'NSPhotoLibraryAddUsageDescription':
          'Photo library access is required to save images.',
      'NSMicrophoneUsageDescription':
          'Microphone access is required for video recording.',
    },
    'speech': {
      'NSMicrophoneUsageDescription':
          'Microphone access is required for speech recognition.',
      'NSSpeechRecognitionUsageDescription':
          'Speech recognition is used to convert speech to text.',
    },
    'recorder': {
      'NSMicrophoneUsageDescription':
          'Microphone access is required to record audio.',
    },
    'contacts': {
      'NSContactsUsageDescription':
          'Contacts access is required to select and save contacts.',
    },
    'location': {
      'NSLocationWhenInUseUsageDescription':
          'Location access is required to show your current position on the map.',
      'NSLocationAlwaysUsageDescription':
          'Location access is required to track your location in the background.',
      'NSLocationAlwaysAndWhenInUseUsageDescription':
          'Location access is required to provide location-based services.',
    },
  };
}