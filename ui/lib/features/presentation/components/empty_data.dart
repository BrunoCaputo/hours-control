import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hours_control/features/presentation/themes/grayscale_color_theme.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    super.key,
    required this.emptyText,
  });

  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/empty_data.svg",
          width: 128,
          height: 128,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 24),
        Text(
          emptyText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray3 ?? Colors.grey,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
