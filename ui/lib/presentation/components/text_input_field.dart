import 'package:flutter/material.dart';
import 'package:hours_control/presentation/themes/grayscale_color_theme.dart';
import 'package:hours_control/presentation/themes/main_color_theme.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.validator,
  });

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      initialValue: initialValue,
      readOnly: readOnly,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
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
        filled: false,
        hintMaxLines: 1,
        hintText: "Digite o nome da squad",
        hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray2,
            ),
      ),
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray4,
          ),
    );
  }
}
