// Flutter imports:
import 'package:flutter/material.dart';

/// Varnamala Peacock Theme
/// A vibrant theme inspired by peacock feathers with teal, cyan, and emerald tones
class VarnamalaTheme {
  VarnamalaTheme._();

  // ═══════════════════════════════════════════════════════════════════════════
  // PRIMARY PEACOCK COLORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Deep peacock blue - used for dark accents, headers
  static const Color peacockDeep = Color(0xFF1A0285);
  
  /// Peacock teal - primary brand color
  static const Color peacockTeal = Color(0xFF1F727E);
  
  /// Peacock cyan - secondary actions, highlights
  static const Color peacockCyan = Color(0xFF359CBB);
  
  /// Peacock turquoise - success states, progress
  static const Color peacockTurquoise = Color(0xFF46D1BF);
  
  /// Peacock mint - bright accents, glows
  static const Color peacockMint = Color(0xFF00FFC6);

  // ═══════════════════════════════════════════════════════════════════════════
  // SEMANTIC COLORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Primary color for main actions
  static const Color primary = peacockTeal;
  static const Color primaryLight = peacockCyan;
  static const Color primaryDark = Color(0xFF145A64);
  
  /// Secondary/Accent color
  static const Color secondary = peacockTurquoise;
  static const Color secondaryLight = peacockMint;
  
  /// Error/Danger - warm coral red
  static const Color error = Color(0xFFE74C3C);
  static const Color errorLight = Color(0xFFFF6B6B);
  static const Color errorDark = Color(0xFFC0392B);
  
  /// Success - golden amber (not green to differentiate)
  static const Color success = Color(0xFFFFD93D);
  static const Color successLight = Color(0xFFFFE066);
  static const Color successDark = Color(0xFFE5C235);
  
  /// Warning - orange
  static const Color warning = Color(0xFFFF9F43);
  static const Color warningLight = Color(0xFFFFBE76);
  
  /// Info - peacock cyan
  static const Color info = peacockCyan;

  // ═══════════════════════════════════════════════════════════════════════════
  // BACKGROUND COLORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Main background - soft off-white
  static const Color background = Color(0xFFF8FFFE);
  
  /// Surface color for cards, dialogs
  static const Color surface = Colors.white;
  
  /// Scaffold background with subtle tint
  static const Color scaffoldBackground = Color(0xFFF5FDFB);
  
  /// Card background
  static const Color cardBackground = Colors.white;
  
  /// Elevated surface
  static const Color elevatedSurface = Color(0xFFFFFFFF);

  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT COLORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Colors.white;
  static const Color textOnSecondary = Colors.white;

  // ═══════════════════════════════════════════════════════════════════════════
  // LEAGUE COLORS (Jewel Tones)
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color leagueBronze = Color(0xFFCD7F32);
  static const Color leagueSilver = Color(0xFFC0C0C0);
  static const Color leagueGold = Color(0xFFFFD700);
  static const Color leagueAmethyst = Color(0xFF9B59B6);
  static const Color leaguePearl = Color(0xFFF5F5F5);
  static const Color leagueRuby = Color(0xFFE74C3C);
  static const Color leagueEmerald = Color(0xFF27AE60);
  static const Color leagueDiamond = Color(0xFF3498DB);

  // ═══════════════════════════════════════════════════════════════════════════
  // GRADIENTS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Main peacock gradient - for backgrounds, headers
  static const LinearGradient peacockGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [peacockDeep, peacockTeal, peacockCyan],
  );
  
  /// Soft gradient for cards
  static const LinearGradient softGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8FFFE), Color(0xFFE8F8F5)],
  );
  
  /// Course tree background gradient
  static const LinearGradient courseTreeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF0FFFC),
      Color(0xFFE8F8F5),
      Color(0xFFE0F5F1),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  
  /// Button gradient
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [peacockCyan, peacockTurquoise],
  );
  
  /// Success gradient
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success, successLight],
  );
  
  /// Glow gradient for course nodes
  static const RadialGradient nodeGlowGradient = RadialGradient(
    colors: [
      Color(0x4046D1BF),
      Color(0x2046D1BF),
      Color(0x0046D1BF),
    ],
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SHADOWS
  // ═══════════════════════════════════════════════════════════════════════════
  
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: peacockTeal.withOpacity(0.08),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: peacockTeal.withOpacity(0.1),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
  ];
  
  static List<BoxShadow> get glowShadow => [
    BoxShadow(
      color: peacockMint.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];
  
  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: peacockTeal.withOpacity(0.3),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // BORDER RADIUS
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusRound = 100.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // MATERIAL THEME DATA
  // ═══════════════════════════════════════════════════════════════════════════
  
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Colors
    primaryColor: primary,
    scaffoldBackgroundColor: scaffoldBackground,
    
    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: primary,
      primaryContainer: primaryLight,
      secondary: secondary,
      secondaryContainer: secondaryLight,
      surface: surface,
      error: error,
      onPrimary: textOnPrimary,
      onSecondary: textOnSecondary,
      onSurface: textPrimary,
      onError: Colors.white,
    ),
    
    // AppBar Theme
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: textPrimary,
      surfaceTintColor: Colors.transparent,
      shadowColor: Color(0x1A1F727E),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: peacockTeal),
    ),
    
    // Card Theme
    cardTheme: CardThemeData(
      elevation: 0,
      color: cardBackground,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: textOnPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF5F8F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: error, width: 2),
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: peacockTeal,
      unselectedItemColor: textHint,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: peacockTurquoise,
      linearTrackColor: Color(0xFFE0E0E0),
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: peacockTurquoise,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE8E8E8),
      thickness: 1,
    ),
    
    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(color: textPrimary, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(color: textPrimary),
      bodyMedium: TextStyle(color: textSecondary),
      bodySmall: TextStyle(color: textHint),
      labelLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: textSecondary),
      labelSmall: TextStyle(color: textHint),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// LEGACY SUPPORT - Keep for backward compatibility
// ═══════════════════════════════════════════════════════════════════════════
const primaryColor = VarnamalaTheme.primary;
