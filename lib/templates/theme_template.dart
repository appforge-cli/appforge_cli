class ThemeTemplate {
  /// Generates a complete theme configuration file with light and dark modes
  static String generate(String themeColor) {
    final colorData = _getThemeColors(themeColor);
    
    return '''
import 'package:flutter/material.dart';

class AppTheme {
  // Color definitions
  static const Color primaryLight = Color(${colorData['primaryLight']});
  static const Color primaryDark = Color(${colorData['primaryDark']});
  static const Color secondaryLight = Color(${colorData['secondaryLight']});
  static const Color secondaryDark = Color(${colorData['secondaryDark']});
  static const Color accentLight = Color(${colorData['accentLight']});
  static const Color accentDark = Color(${colorData['accentDark']});

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryLight,
      secondary: secondaryLight,
      tertiary: accentLight,
      surface: Colors.white,
      background: const Color(0xFFF5F5F5),
      error: const Color(0xFFD32F2F),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFF1A1A1A),
      onBackground: const Color(0xFF1A1A1A),
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1A1A1A),
      iconTheme: IconThemeData(color: Color(0xFF1A1A1A)),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryLight, width: 2),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF1A1A1A)),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF666666)),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF999999)),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: primaryDark,
      secondary: secondaryDark,
      tertiary: accentDark,
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF121212),
      error: const Color(0xFFCF6679),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFFE0E0E0),
      onBackground: const Color(0xFFE0E0E0),
      onError: Colors.black,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Color(0xFFE0E0E0),
      iconTheme: IconThemeData(color: Color(0xFFE0E0E0)),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFF1E1E1E),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF424242)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF424242)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryDark, width: 2),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFE0E0E0)),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFE0E0E0)),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFE0E0E0)),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFFE0E0E0)),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFE0E0E0)),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFE0E0E0)),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFFE0E0E0)),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFFB0B0B0)),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF808080)),
    ),
  );

  static Map<String, String> _getThemeColors(String theme) {
    switch (theme) {
      case 'blue':
        return {
          'primaryLight': '0xFF2196F3',
          'primaryDark': '0xFF42A5F5',
          'secondaryLight': '0xFF1976D2',
          'secondaryDark': '0xFF1E88E5',
          'accentLight': '0xFF03A9F4',
          'accentDark': '0xFF29B6F6',
        };
      case 'green':
        return {
          'primaryLight': '0xFF4CAF50',
          'primaryDark': '0xFF66BB6A',
          'secondaryLight': '0xFF388E3C',
          'secondaryDark': '0xFF43A047',
          'accentLight': '0xFF8BC34A',
          'accentDark': '0xFF9CCC65',
        };
      case 'coffee':
        return {
          'primaryLight': '0xFF795548',
          'primaryDark': '0xFF8D6E63',
          'secondaryLight': '0xFF5D4037',
          'secondaryDark': '0xFF6D4C41',
          'accentLight': '0xFFBCAAA4',
          'accentDark': '0xFFA1887F',
        };
      case 'purple':
        return {
          'primaryLight': '0xFF9C27B0',
          'primaryDark': '0xFFAB47BC',
          'secondaryLight': '0xFF7B1FA2',
          'secondaryDark': '0xFF8E24AA',
          'accentLight': '0xFFE91E63',
          'accentDark': '0xFFEC407A',
        };
      case 'orange':
        return {
          'primaryLight': '0xFFFF9800',
          'primaryDark': '0xFFFFB74D',
          'secondaryLight': '0xFFF57C00',
          'secondaryDark': '0xFFFB8C00',
          'accentLight': '0xFFFF5722',
          'accentDark': '0xFFFF7043',
        };
      default:
        return {
          'primaryLight': '0xFF2196F3',
          'primaryDark': '0xFF42A5F5',
          'secondaryLight': '0xFF1976D2',
          'secondaryDark': '0xFF1E88E5',
          'accentLight': '0xFF03A9F4',
          'accentDark': '0xFF29B6F6',
        };
    }
  }
}
''';
  }

  static Map<String, String> _getThemeColors(String theme) {
    // This is duplicated but kept for external use
    switch (theme) {
      case 'blue':
        return {
          'primaryLight': '0xFF2196F3',
          'primaryDark': '0xFF42A5F5',
          'secondaryLight': '0xFF1976D2',
          'secondaryDark': '0xFF1E88E5',
          'accentLight': '0xFF03A9F4',
          'accentDark': '0xFF29B6F6',
        };
      case 'green':
        return {
          'primaryLight': '0xFF4CAF50',
          'primaryDark': '0xFF66BB6A',
          'secondaryLight': '0xFF388E3C',
          'secondaryDark': '0xFF43A047',
          'accentLight': '0xFF8BC34A',
          'accentDark': '0xFF9CCC65',
        };
      case 'coffee':
        return {
          'primaryLight': '0xFF795548',
          'primaryDark': '0xFF8D6E63',
          'secondaryLight': '0xFF5D4037',
          'secondaryDark': '0xFF6D4C41',
          'accentLight': '0xFFBCAAA4',
          'accentDark': '0xFFA1887F',
        };
      case 'purple':
        return {
          'primaryLight': '0xFF9C27B0',
          'primaryDark': '0xFFAB47BC',
          'secondaryLight': '0xFF7B1FA2',
          'secondaryDark': '0xFF8E24AA',
          'accentLight': '0xFFE91E63',
          'accentDark': '0xFFEC407A',
        };
      case 'orange':
        return {
          'primaryLight': '0xFFFF9800',
          'primaryDark': '0xFFFFB74D',
          'secondaryLight': '0xFFF57C00',
          'secondaryDark': '0xFFFB8C00',
          'accentLight': '0xFFFF5722',
          'accentDark': '0xFFFF7043',
        };
      default:
        return {
          'primaryLight': '0xFF2196F3',
          'primaryDark': '0xFF42A5F5',
          'secondaryLight': '0xFF1976D2',
          'secondaryDark': '0xFF1E88E5',
          'accentLight': '0xFF03A9F4',
          'accentDark': '0xFF29B6F6',
        };
    }
  }
}