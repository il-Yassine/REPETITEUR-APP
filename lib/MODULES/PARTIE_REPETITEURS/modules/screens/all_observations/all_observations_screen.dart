import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/all_observations/widgets/all_observations_body.dart';

import '../../../../../core/constants/REPETITEURS/constants.dart';

class AllObservations extends StatelessWidget {
  const AllObservations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text("Observations", style: TextStyle(color: Colors.white),),
      ),
      body: const AllObservationsBody(),
    );
  }
}
