
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/landing/landing_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class TeacherPasswordResetMailSent extends StatelessWidget {
  const TeacherPasswordResetMailSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/WADOUNOU 01.png',
              height: SizeConfig.screenHeight * 0.25,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.05,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Un mail vous a été envoyé avec succès. Vérifiez votre boîte de réception"
                " et suivez le processus de réinitialisation"
                " de votre mot de passe !",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ),
            ),
            Lottie.asset(
              "assets/lotties/Animation - 1707306278755.json",
              height: SizeConfig.screenHeight * 0.3,
              width: SizeConfig.screenWidth * 1.5,
            ),
            AppFilledButton(
              text: "Se Reconnecter ",
              color: kPrimaryColor,
              txtColor: kWhite,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, TeacherLandingScreen.routeName, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
