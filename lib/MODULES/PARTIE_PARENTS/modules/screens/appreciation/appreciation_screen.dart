import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/appreciation/widgets/appreciation_body.dart';

class AppreciationScreen extends StatelessWidget {
  const AppreciationScreen({super.key});

  static String routeName = '/parent_appreciation_screen';

  @override
  Widget build(BuildContext context) {
    return AppreciationBody();
  }
}