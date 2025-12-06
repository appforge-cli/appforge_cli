class AppRouterTemplate {
  static String generate(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import generated screens
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/profile/screens/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            state.uri.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.home),
            label: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
  // Optional: Add redirect logic for authentication
  // redirect: (context, state) {
  //   final isLoggedIn = false; // Check your auth state here
  //   final isLoggingIn = state.matchedLocation == '/login';
  //   
  //   if (!isLoggedIn && !isLoggingIn) {
  //     return '/login';
  //   }
  //   if (isLoggedIn && isLoggingIn) {
  //     return '/';
  //   }
  //   return null;
  // },
);
''';
  }
}