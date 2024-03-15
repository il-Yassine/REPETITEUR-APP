import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class AddChildButton extends StatelessWidget {
  const AddChildButton(
      {super.key,
      required this.text,
      required this.iconData,
      required this.press,
      required this.color});

  final String text;
  final IconData iconData;
  final Color color;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: SizeConfig.screenHeight * 0.06,
        decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                size: 18.0,
                color: color,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                text,
                style: TextStyle(color: color, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
