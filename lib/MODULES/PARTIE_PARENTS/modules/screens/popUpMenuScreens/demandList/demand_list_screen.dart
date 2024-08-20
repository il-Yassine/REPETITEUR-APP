import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/demandList/widgets/demand_list_screen_body.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';

class DemandListScreen extends StatelessWidget {
  const DemandListScreen({super.key});

  static String routeName = '/demand_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimaryColor,
        title: const Text('Liste des demandes', style: TextStyle(color: kWhite)),
        centerTitle: true,
        elevation: 0,
      ),
      body: const DemandListScreenBody(),
    );
  }
}
