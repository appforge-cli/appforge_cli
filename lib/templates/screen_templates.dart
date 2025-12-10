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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      context.go('/');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    theme.colorScheme.surface,
                    theme.colorScheme.surface.withOpacity(0.8),
                  ]
                : [
                    theme.colorScheme.primary.withOpacity(0.1),
                    theme.colorScheme.secondary.withOpacity(0.1),
                  ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.rocket_launch_rounded,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '$projectName',
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Welcome to Your App',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
''';
  }

  /// Generates a responsive home screen with enhanced widgets
  static String generateHomeScreen(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              size: 24,
            ),
            onPressed: () {
              // TODO: Implement theme toggle
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;
            final crossAxisCount = isTablet ? 3 : 2;
            
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              child: CustomScrollView(
                slivers: [
                  // Welcome Section
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back! 👋',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Here\\'s what\\'s happening today',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Stats Cards
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InfoCard(
                                  title: 'Total Items',
                                  value: '124',
                                  icon: Icons.inventory_2_outlined,
                                  color: theme.colorScheme.primary,
                                  showTrend: true,
                                  trendValue: 12.5,
                                  onTap: () {},
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InfoCard(
                                  title: 'Completion',
                                  value: '89%',
                                  icon: Icons.trending_up_rounded,
                                  color: theme.colorScheme.secondary,
                                  showTrend: true,
                                  trendValue: 5.3,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: InfoCard(
                                  title: 'Active Users',
                                  value: '2.4K',
                                  icon: Icons.people_outline_rounded,
                                  color: Colors.blue,
                                  showTrend: true,
                                  trendValue: -2.1,
                                  onTap: () {},
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InfoCard(
                                  title: 'Revenue',
                                  value: '\\\$45K',
                                  icon: Icons.attach_money_rounded,
                                  color: Colors.green,
                                  showTrend: true,
                                  trendValue: 8.7,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 32)),

                  // Quick Actions Header
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Quick Actions',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Quick Actions Grid
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      delegate: SliverChildListDelegate([
                        _buildActionCard(
                          context,
                          'Profile',
                          Icons.person_outline_rounded,
                          theme.colorScheme.primary,
                          () => context.go('/profile'),
                        ),
                        _buildActionCard(
                          context,
                          'Analytics',
                          Icons.analytics_outlined,
                          Colors.blue,
                          () {},
                        ),
                        _buildActionCard(
                          context,
                          'Messages',
                          Icons.message_outlined,
                          Colors.orange,
                          () {},
                        ),
                        _buildActionCard(
                          context,
                          'Settings',
                          Icons.settings_outlined,
                          Colors.purple,
                          () {},
                        ),
                        _buildActionCard(
                          context,
                          'Reports',
                          Icons.assessment_outlined,
                          Colors.green,
                          () {},
                        ),
                        _buildActionCard(
                          context,
                          'Help',
                          Icons.help_outline_rounded,
                          Colors.red,
                          () {},
                        ),
                      ]),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Item'),
        elevation: 4,
      ),
      bottomNavigationBar: _buildBottomNav(theme),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              // Explore route
              break;
            case 2:
              // Notifications route
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        indicatorColor: theme.colorScheme.primary.withOpacity(0.15),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications_rounded),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
''';
  }

  /// Generates a responsive profile screen with enhanced widgets
  static String generateProfileScreen(String projectName) {
    return '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Gradient
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => context.go('/'),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
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
              ),
            ),
          ),

          // Profile Card
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            sliver: SliverToBoxAdapter(
              child: ProfileCard(
                name: 'John Doe',
                email: 'john.doe@example.com',
                subtitle: 'Premium Member',
                onTap: () {},
                actions: [
                  ProfileAction(
                    label: 'Edit',
                    icon: Icons.edit_outlined,
                    onTap: () {},
                  ),
                  ProfileAction(
                    label: 'Share',
                    icon: Icons.share_outlined,
                    onTap: () {},
                  ),
                  ProfileAction(
                    label: 'QR Code',
                    icon: Icons.qr_code_2_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Stats Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(context, '124', 'Posts'),
                      _buildDivider(theme),
                      _buildStatItem(context, '2.4K', 'Followers'),
                      _buildDivider(theme),
                      _buildStatItem(context, '892', 'Following'),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Settings Section
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Settings',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSettingsGroup(
                    context,
                    'Account Settings',
                    [
                      _buildSettingsTile(
                        context,
                        'Account Information',
                        Icons.person_outline_rounded,
                        () {},
                      ),
                      _buildSettingsTile(
                        context,
                        'Security',
                        Icons.security_outlined,
                        () {},
                      ),
                      _buildSettingsTile(
                        context,
                        'Privacy',
                        Icons.privacy_tip_outlined,
                        () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsGroup(
                    context,
                    'Preferences',
                    [
                      _buildSettingsTile(
                        context,
                        'Theme',
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        () {},
                        trailing: Switch(
                          value: isDark,
                          onChanged: (value) {
                            // TODO: Implement theme toggle
                          },
                        ),
                      ),
                      _buildSettingsTile(
                        context,
                        'Notifications',
                        Icons.notifications_outlined,
                        () {},
                      ),
                      _buildSettingsTile(
                        context,
                        'Language',
                        Icons.language_rounded,
                        () {},
                        subtitle: 'English',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsGroup(
                    context,
                    'Support',
                    [
                      _buildSettingsTile(
                        context,
                        'Help & Support',
                        Icons.help_outline_rounded,
                        () {},
                      ),
                      _buildSettingsTile(
                        context,
                        'Terms of Service',
                        Icons.description_outlined,
                        () {},
                      ),
                      _buildSettingsTile(
                        context,
                        'About',
                        Icons.info_outline_rounded,
                        () {},
                        subtitle: 'Version 1.0.0',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),

          // Logout Button
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final result = await ConfirmDialog.show(
                      context,
                      title: 'Logout',
                      message: 'Are you sure you want to logout?',
                      confirmText: 'Logout',
                      isDestructive: true,
                      icon: Icons.logout_rounded,
                    );

                    if (result == true) {
                      // TODO: Implement logout
                      if (context.mounted) {
                        context.go('/login');
                      }
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: theme.colorScheme.error,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: Icon(
                    Icons.logout_rounded,
                    color: theme.colorScheme.error,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Container(
      height: 40,
      width: 1,
      color: theme.colorScheme.outline.withOpacity(0.2),
    );
  }

  Widget _buildSettingsGroup(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    String? subtitle,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      onTap: trailing == null ? onTap : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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