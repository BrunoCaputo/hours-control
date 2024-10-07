import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hours_control/core/mobx/platform_store.dart';
import 'package:hours_control/features/presentation/themes/grayscale_color_theme.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';

final platformStore = GetIt.I.get<PlatformStore>();

enum ButtonVariant {
  primary,
  secondary,
  alternate,
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.variant = ButtonVariant.primary,
    this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.tooltip,
  });

  final Widget icon;
  final ButtonVariant variant;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final String? tooltip;

  Color _getBackgroundColor(Set<WidgetState> states, BuildContext context) {
    if (states.contains(WidgetState.disabled)) {
      switch (variant) {
        case ButtonVariant.primary:
          return (Theme.of(context).extension<MainColorTheme>()?.blue ?? Colors.blue)
              .withOpacity(0.5);
        case ButtonVariant.secondary:
          return (Theme.of(context).extension<MainColorTheme>()?.purple ?? Colors.purple)
              .withOpacity(0.5);
        case ButtonVariant.alternate:
          return Colors.white;
      }
    }

    if (states.contains(WidgetState.hovered)) {
      switch (variant) {
        case ButtonVariant.primary:
          return Theme.of(context).extension<MainColorTheme>()?.blue2 ?? Colors.blueAccent;
        case ButtonVariant.secondary:
          return Theme.of(context).extension<MainColorTheme>()?.purple2 ?? Colors.deepPurple;
        case ButtonVariant.alternate:
          return Colors.white;
      }
    }

    switch (variant) {
      case ButtonVariant.primary:
        return Theme.of(context).extension<MainColorTheme>()?.blue ?? Colors.blue;
      case ButtonVariant.secondary:
        return Theme.of(context).extension<MainColorTheme>()?.purple ?? Colors.purple;
      case ButtonVariant.alternate:
        return Colors.white;
    }
  }

  Color _getTextColor(Set<WidgetState> states, BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
        return Colors.white;
      case ButtonVariant.alternate:
        return (Theme.of(context).extension<GrayscaleColorTheme>()?.gray4 ?? Colors.black)
            .withOpacity(
          states.contains(WidgetState.disabled) ? 0.3 : 1,
        );
    }
  }

  BorderSide? _getBorder(Set<WidgetState> states, BuildContext context) {
    if (variant == ButtonVariant.alternate) {
      return BorderSide(
        color: states.contains(WidgetState.hovered)
            ? Theme.of(context).extension<GrayscaleColorTheme>()?.black ?? Colors.black
            : Theme.of(context).extension<GrayscaleColorTheme>()?.gray3 ?? Colors.grey,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isDisabled ? null : onPressed,
      autofocus: true,
      icon: icon,
      tooltip: tooltip,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => _getBackgroundColor(states, context),
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => _getTextColor(states, context),
        ),
        side: WidgetStateProperty.resolveWith(
          (states) => _getBorder(states, context),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
    );
  }
}
