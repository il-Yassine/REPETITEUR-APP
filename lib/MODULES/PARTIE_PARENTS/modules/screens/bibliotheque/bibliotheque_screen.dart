import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/bibliotheque/widgets/bibliotheque_body.dart';

class BibliothequeScreen extends StatelessWidget {
  const BibliothequeScreen({super.key});

  static String routeName = "/parent_bibliotheque_page";

  @override
  Widget build(BuildContext context) {
    return BibliothequeBody();
  }
}