import 'package:flutter/material.dart';
import 'start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom M3 Theme',

      // 🟩 LIGHT THEME CONFIGURATION
      theme: ThemeData(
        useMaterial3: true, // Forces Flutter engine to use Material 3 pipelines
        // 1. Generate an entire matching color spectrum from a single signature seed color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4), // Your primary brand color
          brightness: Brightness.light,
        ),

        // 2. Global Box Component Overrides (Clean & Modern)
        appBarTheme: const AppBarTheme(
          centerTitle: true, // Automatically looks great on iOS too!
          elevation: 0,
          scrolledUnderElevation: 2, // Slightly darkens when list scrolls underneath
          backgroundColor: Colors.transparent,
        ),

        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.grey.shade50, // Flat tonal cards instead of heavy shadows
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Deep M3 roundness margins
            side: BorderSide(color: Colors.grey.shade200, width: 1), // Subtle outlines
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF6750A4), width: 2),
          ),
        ),
      ),

      // 🟪 DARK THEME CONFIGURATION
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.dark, // Switches engine to deep dark tones
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        ),
      ),

      // Automatically switches base theme mapping depending on device system preference
      themeMode: ThemeMode.system,
      home: await Start.getHome(),
    ),
  );
}
