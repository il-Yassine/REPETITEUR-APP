import 'package:flutter/material.dart';

class AppRadioButton<T> extends StatelessWidget {
  final T? value;
  final T? groupValue;
  final Function(T? value) onChanged;

  const AppRadioButton(
      {Key? key, this.value, this.groupValue, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Radio<T?>(
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: value,
        groupValue: groupValue,
        onChanged: (value) {
          onChanged(value);
        });
  }
}
