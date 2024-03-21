import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../ui_helpers.dart';
import '../text/app_text.dart';

class AppOutlineButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color outlineColor;
  final Color textColor;
  final bool shouldShowIcon;
  final Widget icon;

  const AppOutlineButton({
    this.onPressed,
    this.text,
    this.outlineColor = kcDarkGreyColor,
    this.textColor = kcDarkGreyColor,
    this.shouldShowIcon = false,
    this.icon = const Icon(Icons.add),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>(
              // As you said you dont need elevation. I'm returning 0 in both case
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return 0;
                }
                return 0; // Defer to the widget's default.
              },
            ),
            fixedSize: MaterialStateProperty.all<Size>(Size.fromHeight(50)),
            foregroundColor: MaterialStateProperty.all<Color>(outlineColor),
            backgroundColor: MaterialStateProperty.all<Color>(kcWhiteColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: outlineColor)))),
        child: btnForeground());
  }

  Widget btnForeground() {
    if (shouldShowIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          horizontalSpaceSmall,
          AppText.body(
            text,
            color: textColor,
          ),
        ],
      );
    } else {
      return AppText.body(
        text,
        color: textColor,
      );
    }
  }
}
