import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hours_control/features/presentation/themes/grayscale_color_theme.dart';
import 'package:hours_control/features/presentation/themes/main_color_theme.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.initialValue,
    this.maxLines = 1,
    this.onChanged,
    this.onFieldSubmitted,
    this.placeholder,
    this.readOnly = false,
    this.validator,
  });

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? initialValue;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? placeholder;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        initialValue: initialValue,
        readOnly: readOnly,
        onFieldSubmitted: onFieldSubmitted,
        maxLines: maxLines,
        onChanged: onChanged,
        inputFormatters: keyboardType == TextInputType.number
            ? [
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            minHeight: 56,
            maxHeight: 2 * 56,
            minWidth: 350,
            maxWidth: MediaQuery.of(context).size.width,
          ),
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
          hintText: placeholder,
          hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray2,
              ),
        ),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).extension<GrayscaleColorTheme>()?.gray4,
            ),
      ),
    );
  }
}
