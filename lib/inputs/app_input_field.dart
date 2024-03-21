
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';

import 'base_input_field.dart';

class AppInputField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final bool obscureText;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final GestureTapCallback? onTap;
  final Function(String value)? onChanged;
  final String? Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? trailingIcon;
  final bool displayTitleArea;
  final bool displayOptionalText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color borderColor;
  final bool? filled;
  final TextInputAction textInputAction;
  final AutovalidateMode autovalidateMode;
  final bool enableInteractiveSelection;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final Color? textColor;

  const AppInputField(
      {Key? key,
      this.title,
      this.hintText,
      this.obscureText = false,
      this.inputFormatters,
      this.onTap,
      this.onChanged,
      this.onSaved,
      this.controller,
      this.keyboardType,
      this.errorText,
      this.trailingIcon,
      this.displayTitleArea = false,
      this.displayOptionalText = false,
      this.suffixIcon,  
      this.prefixIcon,
      this.fillColor,
      this.textColor,
      this.borderColor = kcBlackColor,
      this.filled = false,
      this.maxLength,
      this.textInputAction = TextInputAction.next,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.validator,
      this.enableInteractiveSelection = true,
      this.focusNode, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseInputField(
      title: title,
      displayOptionalText: displayOptionalText,
      inputControl: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        onTap: onTap,
        onSaved: onSaved,
        key: key,
        style: TextStyle(
            color: textColor,
            decoration: TextDecoration.none,
            decorationThickness: 0),
            maxLines: maxLines,
        maxLength: maxLength,
        enableInteractiveSelection: enableInteractiveSelection,
        focusNode: focusNode,
        autovalidateMode: autovalidateMode,
        validator: validator,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        controller: controller ?? TextEditingController(),
        decoration: InputDecoration(
            errorText:
                (errorText == "" || errorText == null) ? null : errorText,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            border: InputBorder.none,
            hintStyle: TextStyle(color: kcLightGreyColor),
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
