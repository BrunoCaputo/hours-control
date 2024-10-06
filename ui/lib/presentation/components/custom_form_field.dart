import 'package:flutter/material.dart';
import 'package:hours_control/presentation/themes/grayscale_color_theme.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.fieldText,
    required this.child,
  });

  final String fieldText;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldText.toUpperCase(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).extension<GrayscaleColorTheme>()!.gray3,
              ),
        ),
        child,
      ],
    );
  }
}
