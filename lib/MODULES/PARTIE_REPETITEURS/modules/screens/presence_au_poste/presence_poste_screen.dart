import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/presence_au_poste/widgets/presence_au_poste_body.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/main_test_kkia.dart';

class PresenceAuPosteScreen extends StatelessWidget {
  const PresenceAuPosteScreen({super.key});

  static String routeName = '/presence_au_poste';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text("Suivi Mensuel", style: TextStyle(color: kWhite),),
      ),
      body: PresenceAuPosteBody(),
    );
  }
}
