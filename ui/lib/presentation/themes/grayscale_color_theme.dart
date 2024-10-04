import 'package:flutter/material.dart';

class GrayscaleColorTheme extends ThemeExtension<GrayscaleColorTheme> {
  const GrayscaleColorTheme({
    required this.black,
    required this.gray1,
    required this.gray2,
    required this.gray3,
    required this.gray4,
    required this.grayBody,
  });

  final Color? black;
  final Color? gray1;
  final Color? gray2;
  final Color? gray3;
  final Color? gray4;
  final Color? grayBody;

  @override
  GrayscaleColorTheme copyWith({
    Color? black,
    Color? gray1,
    Color? gray2,
    Color? gray3,
    Color? gray4,
    Color? grayBody,
  }) {
    return GrayscaleColorTheme(
      black: black ?? this.black,
      gray1: gray1 ?? this.gray1,
      gray2: gray2 ?? this.gray2,
      gray3: gray3 ?? this.gray3,
      gray4: gray4 ?? this.gray4,
      grayBody: grayBody ?? this.grayBody,
    );
  }

  @override
  GrayscaleColorTheme lerp(
    ThemeExtension<GrayscaleColorTheme>? other,
    double t,
  ) {
    if (other is! GrayscaleColorTheme) {
      return this;
    }

    return GrayscaleColorTheme(
      black: Color.lerp(black, other.black, t),
      gray1: Color.lerp(gray1, other.gray1, t),
      gray2: Color.lerp(gray2, other.gray2, t),
      gray3: Color.lerp(gray3, other.gray3, t),
      gray4: Color.lerp(gray4, other.gray4, t),
      grayBody: Color.lerp(grayBody, other.grayBody, t),
    );
  }
}
