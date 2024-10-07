import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/domain/usecases/fetch_squads.dart';
import 'package:hours_control/features/presentation/screens/main_screen.dart';
import 'package:hours_control/features/presentation/themes/grayscale_color_theme.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';

final platformStore = GetIt.I.get<PlatformStore>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _checkRegistration() {
    try {
      if (!GetIt.I.isRegistered<PlatformStore>()) {
        GetIt.I.registerSingleton<PlatformStore>(
          PlatformStore(),
        );
      }
      if (!GetIt.I.isRegistered<FetchSquadsUseCase>()) {
        GetIt.I.registerSingleton<FetchSquadsUseCase>(FetchSquadsUseCase());
      }
    } catch (err) {
      throw Exception("Failed to register: $err");
    }
  }

  void _init() async {
    _checkRegistration();
    try {
      platformStore.setIsMobile(Platform.isAndroid || Platform.isIOS);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();

    return MaterialApp(
      title: 'PD Hours control',
      themeMode: ThemeMode.light,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
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
          MainColorTheme(
            blue: Color(0xFF4263EB),
            blue2: Color(0xFF2342C0),
            purple: Color(0xFF7048E8),
            purple2: Color(0xFF5028C6),
            pink: Color(0xFF51CF66),
            red: Color(0xFFF03D3E),
          ),
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
          MainColorTheme(
            blue: Color(0xFF4263EB),
            blue2: Color(0xFF2342C0),
            purple: Color(0xFF7048E8),
            purple2: Color(0xFF5028C6),
            pink: Color(0xFF51CF66),
            red: Color(0xFFF03D3E),
          ),
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
