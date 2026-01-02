class AppRouterTemplate {
  static String generate(String projectName, {bool includeChatbot = false}) {
    final chatbotImport = includeChatbot
        ? "import '../../features/chatbot/screens/chatbot_screen.dart';"
        : '';

    final chatbotRoute = includeChatbot
        ? '''
        GoRoute(
          path: 'chatbot',
          name: 'chatbot',
          builder: (context, state) => const ChatbotScreen(),
        ),'''
        : '';

    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:$projectName/features/app/screens/splash_screen.dart';
import 'package:$projectName/features/app/screens/onboarding_screen.dart';

// Import generated screens
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
$chatbotImport

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    // Splash Screen
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    
    // Onboarding Screen
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    
    // Main App Routes
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    
    // Profile Route
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    
    // Auth Routes
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),$chatbotRoute
  ],
  
  // Error Page
  errorBuilder: (context, state) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 80,
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Page Not Found',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'The page you\\'re looking for doesn\\'t exist',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.home_rounded),
                  label: const Text(
                    'Go to Home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
  
  // Optional: Uncomment and implement authentication redirect logic
  // redirect: (context, state) {
  //   // Check if user is authenticated
  //   final isLoggedIn = false; // Replace with actual auth check
  //   final isGoingToLogin = state.matchedLocation == '/login';
  //   final isOnSplash = state.matchedLocation == '/splash';
  //   
  //   // Allow splash screen
  //   if (isOnSplash) return null;
  //   
  //   // If not logged in and not going to login, redirect to login
  //   if (!isLoggedIn && !isGoingToLogin) {
  //     return '/login';
  //   }
  //   
  //   // If logged in and going to login, redirect to home
  //   if (isLoggedIn && isGoingToLogin) {
  //     return '/';
  //   }
  //   
  //   return null; // No redirect needed
  // },
);
''';
  }
}
