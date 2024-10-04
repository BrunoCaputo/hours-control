import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hours_control/presentation/screens/home_screen.dart';
import 'package:hours_control/presentation/themes/grayscale_color_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PD Hours control',
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        primaryColor: const Color(0xFF4263EB),
        textTheme: GoogleFonts.robotoTextTheme(
          TextTheme(
            headlineLarge: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 50,
              color: const Color(0xFF212429),
            ),
            headlineMedium: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 38,
              color: const Color(0xFF212429),
            ),
            headlineSmall: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 28,
              color: const Color(0xFF212429),
            ),
            titleLarge: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 21,
              color: const Color(0xFF212429),
            ),
            titleMedium: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: const Color(0xFF212429),
            ),
            bodyMedium: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: const Color(0xFF212429),
            ),
            bodySmall: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: const Color(0xFF212429),
            ),
          ),
        ),
        extensions: const [
          GrayscaleColorTheme(
            black: Color(0xFF212429),
            gray1: Color(0xFFF8F9FA),
            gray2: Color(0xFFDDE2E5),
            gray3: Color(0xFFACB5BD),
            gray4: Color(0xFF495057),
            grayBody: Color(0xFFF9FAFC),
          ),
        ],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        primaryColor: const Color(0xFF4263EB),
        textTheme: GoogleFonts.robotoTextTheme(
          TextTheme(
            headlineLarge: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 50,
              color: Colors.white,
            ),
            headlineMedium: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 38,
              color: Colors.white,
            ),
            headlineSmall: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 28,
              color: Colors.white,
            ),
            titleLarge: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 21,
              color: Colors.white,
            ),
            titleMedium: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.white,
            ),
            bodyMedium: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white,
            ),
            bodySmall: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
        extensions: const [
          GrayscaleColorTheme(
            black: Color(0xFF212429),
            gray1: Color(0xFFF8F9FA),
            gray2: Color(0xFFDDE2E5),
            gray3: Color(0xFFACB5BD),
            gray4: Color(0xFF495057),
            grayBody: Color(0xFFF9FAFC),
          ),
        ],
      ),
    );
  }
}
