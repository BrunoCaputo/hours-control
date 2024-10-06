import 'package:flutter/material.dart';

class MainColorTheme extends ThemeExtension<MainColorTheme> {
  const MainColorTheme({
    required this.blue,
    required this.blue2,
    required this.purple,
    required this.purple2,
    required this.pink,
    required this.red,
  });

  final Color? blue;
  final Color? blue2;
  final Color? purple;
  final Color? purple2;
  final Color? pink;
  final Color? red;

  @override
  MainColorTheme copyWith({
    Color? blue,
    Color? blue2,
    Color? purple,
    Color? purple2,
    Color? pink,
    Color? red,
  }) {
    return MainColorTheme(
      blue: blue ?? this.blue,
      blue2: blue2 ?? this.blue2,
      purple: purple ?? this.purple,
      purple2: purple2 ?? this.purple2,
      pink: pink ?? this.pink,
      red: red ?? this.red,
    );
  }

  @override
  MainColorTheme lerp(
    ThemeExtension<MainColorTheme>? other,
    double t,
  ) {
    if (other is! MainColorTheme) {
      return this;
    }

    return MainColorTheme(
      blue: Color.lerp(blue, other.blue, t),
      blue2: Color.lerp(blue2, other.blue2, t),
      purple: Color.lerp(purple, other.purple, t),
      purple2: Color.lerp(purple2, other.purple2, t),
      pink: Color.lerp(pink, other.pink, t),
      red: Color.lerp(red, other.red, t),
    );
  }
}
