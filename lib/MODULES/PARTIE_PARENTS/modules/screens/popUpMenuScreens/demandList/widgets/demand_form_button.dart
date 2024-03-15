import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class DemandFormButton extends StatelessWidget {
  const DemandFormButton({super.key, required this.text,required this.press, required this.color});

  final String text;
  final Color color;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: SizeConfig.screenHeight * 0.06,
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Center(child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600),)),
      ),
    );
  }
}
