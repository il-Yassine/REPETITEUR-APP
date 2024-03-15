import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class AddingInfoSuccessScreen extends StatefulWidget {
  const AddingInfoSuccessScreen({super.key});

  static String routeName = "/adding_infos_success_screen";

  @override
  State<AddingInfoSuccessScreen> createState() =>
      _AddingInfoSuccessScreenState();
}

class _AddingInfoSuccessScreenState extends State<AddingInfoSuccessScreen> {
  bool showButton = false;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    // Attendre 3 secondes avant d'afficher le bouton
    Timer(const Duration(seconds: 3), () {
      setState(() {
        showButton = true;
      });
    });

    // Attendre 1 seconds avant d'afficher le text
    Timer(const Duration(seconds: 1), () {
      setState(() {
        showText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Column(
            children: [
              Lottie.asset("assets/lotties/success_edited(2).json", height: SizeConfig.screenHeight *0.5),
              /* SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ), */
              AnimatedOpacity(
                  opacity: showText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: showText
                      ? Text(
                          "Vos informations ont bien été mis à jour !",
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.050,
                              fontWeight: FontWeight.w600),
                        )
                      : const SizedBox())
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          AnimatedOpacity(
            opacity: showButton ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: showButton
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8.0),
                    child: AppFilledButton(
                      text: "Ouvrir ma session",
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.pushNamed(context, TeacherHomeScreen.routeName);
                      },
                    ))
                : const SizedBox(),
          ),
        ],
      )),
    );
  }
}
