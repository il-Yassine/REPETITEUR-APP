import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/bibliotheque/widgets/teacher_bibliotheque_body.dart';

class TeacherBibliothequeScreen extends StatelessWidget {
  const TeacherBibliothequeScreen({super.key});

  static String routeName = "/teacher_bibliotheque_page";

  @override
  Widget build(BuildContext context) {
    return TeacherBibliothequeBody();
  }
}