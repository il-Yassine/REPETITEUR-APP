
import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/text/app_text.dart';

class AppRadioTileButton<T> extends StatelessWidget {
  final String? title;
  final T? value;
  final T? groupValue;
  final Function(T?) onChanged;
  final Function()? onTap;

  const AppRadioTileButton({
    this.title,
    this.value,
    this.groupValue,
    required this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T?>(
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: kcPrimaryColor,
            fillColor:
                MaterialStateColor.resolveWith((states) => kcPrimaryColor),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          AppText.body(
            title,
            color: kcBlackColor,
          ),
        ],
      ),
    );
  }
}
