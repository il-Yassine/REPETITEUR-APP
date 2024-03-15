import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class AddTeacherSuccessScreen extends StatelessWidget {
  const AddTeacherSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Demande envoyée avec succes !",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Lottie.asset(
              "assets/lotties/Animation - 1707306278755.json",
              height: SizeConfig.screenHeight * 0.3,
              width: SizeConfig.screenWidth * 1.5,
            ),
            AppFilledButton(
              text: "Retour à l'acceuil",
              color: kPrimaryColor,
              txtColor: kWhite,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, ParentHomeScreen.routeName, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
