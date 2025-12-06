import 'package:superapp_cli/templates/phone_otp_auth_templates.dart' show PhoneOTPAuthTemplates, UnifiedAuthTemplates, SocialAuthTemplates;
import 'package:superapp_cli/templates/auth_template.dart';

class ScreenTemplates {
  /// Generates a splash screen
  static String generateSplashScreen(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // TODO: Add initialization logic here (check auth, load data, etc.)
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rocket_launch,
                size: 100,
                color: theme.colorScheme.onPrimary,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome',
                style: theme.textTheme.displayMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              CircularProgressIndicator(
                color: theme.colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';
  }

  /// Generates a responsive home screen
  static String generateHomeScreen(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;
            final crossAxisCount = isTablet ? 3 : 2;
            
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: theme.textTheme.displaySmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Explore your dashboard',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: _buildStatsCards(context, isDark),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Quick Actions',
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    delegate: SliverChildListDelegate([
                      _buildActionCard(
                        context,
                        'Settings',
                        Icons.settings,
                        () => context.go('/profile'),
                      ),
                      _buildActionCard(
                        context,
                        'Analytics',
                        Icons.analytics,
                        () {},
                      ),
                      _buildActionCard(
                        context,
                        'Messages',
                        Icons.message,
                        () {},
                      ),
                      _buildActionCard(
                        context,
                        'Help',
                        Icons.help_outline,
                        () {},
                      ),
                    ]),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New Item'),
      ),
    );
  }

  Widget _buildStatsCards(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            '124',
            'Total Items',
            Icons.inventory,
            theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            '89%',
            'Completion',
            Icons.trending_up,
            theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';
  }

  /// Generates a responsive profile screen
  static String generateProfileScreen(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/'),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Profile'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                ),
                child: const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'john.doe@example.com',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Settings',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                _buildSettingsTile(
                  context,
                  'Account',
                  Icons.account_circle,
                  () {},
                ),
                _buildSettingsTile(
                  context,
                  'Notifications',
                  Icons.notifications,
                  () {},
                ),
                _buildSettingsTile(
                  context,
                  'Privacy',
                  Icons.privacy_tip,
                  () {},
                ),
                _buildSettingsTile(
                  context,
                  'Theme',
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  () {},
                ),
                const SizedBox(height: 24),
                Text(
                  'About',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                _buildSettingsTile(
                  context,
                  'Help & Support',
                  Icons.help,
                  () {},
                ),
                _buildSettingsTile(
                  context,
                  'Terms of Service',
                  Icons.description,
                  () {},
                ),
                _buildSettingsTile(
                  context,
                  'About App',
                  Icons.info,
                  () {},
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
''';
  }

  /// Generates a login screen
  static String generateLoginScreen(String projectName) {
    return generateEmailPasswordLogin(projectName);
  }

  // AUTH SCREEN GENERATORS
  static String generateEmailPasswordLogin(String projectName) {
    // Use the template from AuthScreenTemplates
    return AuthScreenTemplates.generateEmailPasswordLogin(projectName);
  }

  static String generateEmailPasswordSignup(String projectName) {
    return AuthScreenTemplates.generateEmailPasswordSignup(projectName);
  }

  static String generateUsernamePasswordLogin(String projectName) {
    return AuthScreenTemplates.generateUsernamePasswordLogin(projectName);
  }

  static String generateUsernamePasswordSignup(String projectName) {
    return AuthScreenTemplates.generateUsernamePasswordSignup(projectName);
  }

  static String generatePhoneOTPLogin(String projectName) {
    return PhoneOTPAuthTemplates.generatePhoneOTPLogin(projectName);
  }

  static String generateOTPVerification(String projectName) {
    return PhoneOTPAuthTemplates.generateOTPVerification(projectName);
  }

  static String generateSocialLogin(String projectName) {
    return SocialAuthTemplates.generateSocialLogin(projectName);
  }

  static String generateUnifiedLogin(String projectName) {
    return UnifiedAuthTemplates.generateUnifiedLogin(projectName);
  }

  static String generateUnifiedSignup(String projectName) {
    return UnifiedAuthTemplates.generateUnifiedSignup(projectName);
  }
}