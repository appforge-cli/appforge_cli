class AppRouterTemplate {
  static String generate() {
    return r'''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// IMPORT YOUR REAL SCREENS HERE WHEN GENERATED
// import '../../features/auth/screens/login_screen.dart';
// import '../../features/home/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreenStub(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreenStub(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreenStub(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreenStub(),
    ),
  ],
  errorBuilder: (context, state) => const Scaffold(
    body: Center(child: Text('Page not found')),
  ),
);

// --- Stub screens (replace with your actual screens when generated) ---
class SplashScreenStub extends StatelessWidget {
  const SplashScreenStub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text('Splash')),
      );
}

class HomeScreenStub extends StatelessWidget {
  const HomeScreenStub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text('Home')),
      );
}

class LoginScreenStub extends StatelessWidget {
  const LoginScreenStub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text('Login')),
      );
}

class SignupScreenStub extends StatelessWidget {
  const SignupScreenStub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: Text('Signup')),
      );
}
''';
  }
}
