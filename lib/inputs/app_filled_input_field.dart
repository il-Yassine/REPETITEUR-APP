
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';

import 'base_input_field.dart';

class AppFilledInputField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final bool obscureText;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? trailingIcon;
  final bool displayTitleArea;
  final bool displayOptionalText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final bool? filled;
  final TextInputAction textInputAction;
  final AutovalidateMode autovalidateMode;
  final bool enableInteractiveSelection;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const AppFilledInputField(
      {Key? key,
      this.title,
      this.hintText,
      this.obscureText = false,
      this.inputFormatters,
      this.onChanged,
      this.controller,
      this.keyboardType,
      this.errorText,
      this.trailingIcon,
      this.displayTitleArea = false,
      this.displayOptionalText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.fillColor,
      this.filled = false,
      this.textInputAction = TextInputAction.next,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.validator,
      this.enableInteractiveSelection = true,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInputField(
      title: title,
      displayOptionalText: displayOptionalText,
      inputControl: TextFormField(
        key: key,
        enableInteractiveSelection: enableInteractiveSelection,
        focusNode: focusNode,
        autovalidateMode: autovalidateMode,
        validator: validator,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        cursorColor: Colors.white,
        controller: controller ?? TextEditingController(),
        style: TextStyle(color: kcWhiteColor),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.white24,
            errorText:
                (errorText == "" || errorText == null) ? null : errorText,
            hintStyle: TextStyle(color: Colors.white24),
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            isDense: true),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
      ),
    );
  }
}
