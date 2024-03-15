import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/widgets/teacher_adding_infos_body.dart';

class TeacherAddingInformationScreen extends StatelessWidget {
  const TeacherAddingInformationScreen({super.key});

  static String routeName = '/teacher_adding_informations_page';

  @override
  Widget build(BuildContext context) {
    return TeacherAddingInformationsBody();
  }
}