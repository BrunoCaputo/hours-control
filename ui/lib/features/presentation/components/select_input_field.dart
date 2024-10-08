import 'package:flutter/material.dart';
import 'package:hours_control/features/presentation/components/action_button.dart';
import 'package:hours_control/features/presentation/themes/grayscale_color_theme.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';

class SelectInputField<T> extends StatelessWidget {
  const SelectInputField({
    super.key,
    required this.items,
    this.minHeight = 56,
    required this.onChanged,
    this.placeholder,
    this.selectedItem,
    this.style,
    this.validator,
  });

  final List<DropdownMenuItem<T>>? items;
  final double minHeight;
  final void Function(T?)? onChanged;
  final String? placeholder;
  final T? selectedItem;
  final TextStyle? style;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: validator,
      elevation: 0,
      decoration: InputDecoration(
        constraints: BoxConstraints(minHeight: minHeight),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray2 ?? Colors.grey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).extension<MainColorTheme>()?.red ?? Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).extension<MainColorTheme>()?.red ?? Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).extension<MainColorTheme>()?.blue ?? Colors.blue,
          ),
        ),
        contentPadding: minHeight < 56 && platformStore.isMobile
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
            : null,
        filled: false,
        hintMaxLines: 1,
        hintText: placeholder,
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray2,
            ),
      ),
      style: (style ?? Theme.of(context).textTheme.titleLarge)?.copyWith(
        color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray4,
      ),
      onChanged: onChanged,
      value: selectedItem,
      items: items,
    );
  }
}
