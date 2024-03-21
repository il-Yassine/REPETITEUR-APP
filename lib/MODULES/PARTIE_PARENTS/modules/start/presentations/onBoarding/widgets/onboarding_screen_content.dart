import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class OnBoardingScreenContent extends StatelessWidget {
  const OnBoardingScreenContent(
      {super.key, required this.text, required this.images});

  final String text, images;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SizedBox(
          height: SizeConfig.screenHeight * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(text,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: SizeConfig.screenHeight * 0.024,
                  fontWeight: FontWeight.bold)),
        ),
        const Spacer(
          flex: 2,
        ),
        Image.asset(
          images,
          height: SizeConfig.screenHeight * 0.3,
          width: SizeConfig.screenWidth * 0.6,
        )
      ],
    );
  }
}
