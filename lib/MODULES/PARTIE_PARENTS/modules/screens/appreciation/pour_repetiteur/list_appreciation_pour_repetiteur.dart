import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/appreciation/pour_repetiteur/widgets/appreciation_pour_repetiteur_body.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';

class AppreciationPourRepetiteur extends StatelessWidget {
  const AppreciationPourRepetiteur({super.key});

  static String routeName = '/appreciation_pour_repetiteur';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text("Appréciations", style: TextStyle(color: Colors.white),),
      ),
      body: AppreciationPourRepetiteurBody(),
    );
  }
}
