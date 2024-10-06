import 'package:flutter/material.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';

enum SnackbarType {
  success,
  error,
  warning,
  info,
}

class FeedbackSnackBar {
  static Color? _getBackgroundColor(BuildContext context, SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Colors.green;
      case SnackbarType.error:
        return Theme.of(context).extension<MainColorTheme>()?.red;
      case SnackbarType.warning:
        return Colors.yellow;
      default:
        return Theme.of(context).extension<MainColorTheme>()?.blue;
    }
  }

  static Color _getTextColor(BuildContext context, SnackbarType type) {
    switch (type) {
      case SnackbarType.warning:
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  static SnackBar build(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
  }) {
    return SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: _getTextColor(context, type),
            ),
      ),
      backgroundColor: _getBackgroundColor(context, type),
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 3),
    );
  }
}
