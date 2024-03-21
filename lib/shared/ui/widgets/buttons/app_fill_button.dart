import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/ui_helpers.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/text/app_text.dart';

class AppFilledButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color color;
  final Color txtColor;
  final bool shouldShowIcon;
  final IconData icon;
  final bool? buttonStatus;
  final BuildContext? context;

  const AppFilledButton({
    this.onPressed,
    required this.text,
    this.color = kPrimaryColor,
    this.txtColor = kcWhiteColor,
    this.shouldShowIcon = false,
    this.icon = Icons.add,
    this.context,
    this.buttonStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: btnForeground(),
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: buttonStatus == false
                ? MaterialStateProperty.all<Color>(color)
                : MaterialStateProperty.all<Color>(Colors.grey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: color)))));
  }

  Widget btnForeground() {
    if (shouldShowIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          horizontalSpaceSmall,
          AppText.body(
            text,
            color: txtColor,
          ),
        ],
      );
    } else {
      return AppText.body(
        text,
        color: txtColor,
      );
    }
  }
}
