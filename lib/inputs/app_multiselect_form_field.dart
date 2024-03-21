
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/ui_helpers.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/text/app_text.dart';

import 'base_input_field.dart';
import 'text/error_text.dart';

class AppMultiSelectFormField<T> extends FormField<List<T>> {
  AppMultiSelectFormField(
      {Key? key,
      String? title,
      FormFieldSetter<List<T>>? onSaved,
      FormFieldValidator<List<T>>? validator,
      List<T> initialValue = const [],
      AutovalidateMode autovalidateMode = AutovalidateMode.always,
      List<T> values = const [],
      required List<T> items,
      String Function(int index)? itemTextBuilder,
      Widget Function(int index)? itemBuilder,
      Widget Function(int index)? itemSelectedBuilder,
      required Function(T value) onItemSelected,
      required Function(T value) onItemUnSelected,
      Widget? childWidget,
      Color unselectedColor = kcBlueGrey50,
      Color selectedColor = kcPrimaryColor,
      Color selectedTextColor = kcWhiteColor,
      Color unSelectedTextColor = kcPrimaryColor})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<List<T>> state) {
              state.setValue(values);
              return BaseInputField(
                title: title,
                inputControl: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpaceTiny,
                    Wrap(
                      runSpacing: 12,
                      spacing: 8,
                      children: [
                        ..._buildItems<T>(
                            items,
                            values,
                            itemTextBuilder,
                            itemBuilder,
                            itemSelectedBuilder,
                            onItemSelected,
                            onItemUnSelected,
                            childWidget,
                            selectedColor,
                            unselectedColor,
                            selectedTextColor,
                            unSelectedTextColor,
                            state)
                      ],
                    ),
                    verticalSpaceTiny,
                    state.hasError ? ErrorText(state.errorText) : Container()
                  ],
                ),
              );
            });

  static List<Widget> _buildItems<T>(
      List<T> items,
      List<T> selectedItems,
      String Function(int index)? itemTextBuilder,
      Widget Function(int index)? itemBuilder,
      Widget Function(int index)? itemSelectedBuilder,
      Function(T value) onItemSelected,
      Function(T value) onItemUnSelected,
      Widget? childWidget,
      Color selectedColor,
      Color unselectedColor,
      Color selectedTextColor,
      Color unSelectedTextColor,
      FormFieldState<List<T>> state) {
    var widgets = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      var isSelected =
          selectedItems.firstWhereOrNull((element) => element == items[i]) !=
                  null
              ? true
              : false;
      String? displayText;
      Widget? unselectedDisplayWidget;
      Widget? selectedDisplayWidget;

      if (itemTextBuilder != null) {
        displayText = itemTextBuilder(i);
      }

      if (itemBuilder != null) {
        unselectedDisplayWidget = itemBuilder(i);
      }

      if (itemSelectedBuilder != null) {
        selectedDisplayWidget = itemSelectedBuilder(i);
      }

      Widget childWidget = AppText.body('N/A',
          color: isSelected ? selectedTextColor : unSelectedTextColor);

      if (displayText != null) {
        childWidget = AppText.body(displayText,
            color: isSelected ? selectedTextColor : unSelectedTextColor);
      } else {
        if (isSelected) {
          childWidget =
              selectedDisplayWidget ?? unselectedDisplayWidget ?? SizedBox();
        } else {
          childWidget =
              unselectedDisplayWidget ?? selectedDisplayWidget ?? SizedBox();
        }
      }

      // var containerColor = itemTextBuilder != null
      //     ? (isSelected ? selectedColor : unselectedColor)
      //     : null;

      var widget = InkWell(
        onTap: () {
          if (isSelected) {
            onItemUnSelected(items[i]);
            var values = state.value?.map((e) => e).toList() ?? [];
            values.remove(items[i]);
            state.didChange(values);
          } else {
            onItemSelected(items[i]);
            var values = state.value?.map((e) => e).toList() ?? [];
            values.add(items[i]);
            state.didChange(values);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: childWidget,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? selectedColor : unselectedColor),
        ),
      );
      widgets.add(widget);
    }
    return widgets;
  }
}
