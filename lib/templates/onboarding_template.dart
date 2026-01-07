class OnboardingTemplate {
  static String generate(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/core/services/feature_service.dart';

class FeatureToggle {
  final String id;
  final String label;
  final String description;
  final IconData icon;
  bool isEnabled;

  FeatureToggle({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
    this.isEnabled = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'isEnabled': isEnabled,
      };
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late List<FeatureToggle> features;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeFeatures();
  }

  void _initializeFeatures() async {
    features = [
      FeatureToggle(
        id: 'camera',
        label: 'Camera',
        description: 'Access device camera for photos and videos',
        icon: Icons.camera_alt,
        isEnabled: FeatureService.isCameraEnabled,
      ),
      FeatureToggle(
        id: 'image_picker',
        label: 'Image Picker',
        description: 'Pick images from gallery',
        icon: Icons.image,
        isEnabled: FeatureService.isImagePickerEnabled,
      ),
      FeatureToggle(
        id: 'location',
        label: 'Location Services',
        description: 'Access device location',
        icon: Icons.location_on,
        isEnabled: FeatureService.isLocationEnabled,
      ),
      FeatureToggle(
        id: 'contacts',
        label: 'Contacts',
        description: 'Access device contacts',
        icon: Icons.contacts,
        isEnabled: FeatureService.isContactsEnabled,
      ),
      FeatureToggle(
        id: 'call',
        label: 'Call',
        description: 'Make phone calls',
        icon: Icons.call,
        isEnabled: FeatureService.isCallEnabled,
      ),
    ];

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveFeaturePreferences() async {
    for (var feature in features) {
      await FeatureService.setFeatureEnabled(feature.id, feature.isEnabled);
    }

    await FeatureService.completeOnboarding();

    if (!mounted) return;

    // Navigate to home after saving
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Your Experience'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Enable the features you want to use',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 24),
              ...features.map((feature) => _buildFeatureToggle(feature)).toList(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveFeaturePreferences,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      for (var feature in features) {
                        feature.isEnabled = true;
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Enable All',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      for (var feature in features) {
                        feature.isEnabled = false;
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Disable All',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureToggle(FeatureToggle feature) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              feature.icon,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    feature.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
            Switch(
              value: feature.isEnabled,
              onChanged: (value) {
                setState(() {
                  feature.isEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
''';
  }

  static String generateService() {
    return '''
import 'package:shared_preferences/shared_preferences.dart';

class FeatureService {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setFeatureEnabled(String featureId, bool enabled) async {
    await _prefs.setBool('feature_\$featureId', enabled);
  }

  static bool isFeatureEnabled(String featureId) {
    return _prefs.getBool('feature_\$featureId') ?? true;
  }

  static Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool('onboardingCompleted') ?? false;
  }

  static Future<void> completeOnboarding() async {
    await _prefs.setBool('onboardingCompleted', true);
  }

  static Future<void> resetOnboarding() async {
    await _prefs.setBool('onboardingCompleted', false);
  }

  // Specific feature checks
  static bool get isCameraEnabled => isFeatureEnabled('camera');
  static bool get isImagePickerEnabled => isFeatureEnabled('image_picker');
  static bool get isLocationEnabled => isFeatureEnabled('location');
  static bool get isContactsEnabled => isFeatureEnabled('contacts');
  static bool get isCallEnabled => isFeatureEnabled('call');
}
''';
  }
}
