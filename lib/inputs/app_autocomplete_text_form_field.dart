import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'app_input_field.dart';

class AppAutoCompleteTextFormField<T extends Object> extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? Function(String?)? validator;
  final int itemCount;
  final FutureOr<Iterable<T>> Function(TextEditingValue textEditingValue)
      optionsBuilder;

  final Widget Function(BuildContext context, int index) itemBuilder;
  final Function(String) onSearchChange;
  final String Function(T) displayStringForOption;
  final Function onRemovePressed;
  final double height;
  final TextEditingController controller;

  const AppAutoCompleteTextFormField(
      {Key? key,
      this.title,
      this.hint,
      this.validator,
      required this.optionsBuilder,
      required this.itemCount,
      required this.itemBuilder,
      required this.displayStringForOption,
      this.height = 120,
      required this.onSearchChange,
      required this.onRemovePressed,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Autocomplete<T>(
            optionsBuilder: optionsBuilder,
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                void Function() onFieldSubmitted) {
              return AppInputField(
                title: title,
                hintText: hint,
                validator: validator,
                controller: textEditingController,
                autovalidateMode: AutovalidateMode.disabled,
                focusNode: focusNode,
                prefixIcon: Icon(Icons.search, color: kcDarkGreyColor),
                onChanged: (value) {
                  onSearchChange(value);
                },
                suffixIcon: IconButton(
                  color: kcDarkGreyColor,
                  onPressed: () {
                    textEditingController.text = '';
                    onRemovePressed();
                  },
                  icon: Icon(Icons.clear),
                ),
              );
            },
            displayStringForOption: displayStringForOption,
            optionsViewBuilder: (context, onSelected, options) => Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(4.0)),
                    ),
                    child: SizedBox(
                      height: height,
                      width: Get.width,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: itemCount,
                        shrinkWrap: false,
                        itemBuilder: (BuildContext context, int index) {
                          return itemBuilder(context, index);
                        },
                      ),
                    ),
                  ),
                )
        )
    );
  }
}
