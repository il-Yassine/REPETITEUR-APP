import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/widgets/teacher_adding_infos_body.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_updating/widgets/teacher_update_informations_body.dart';

class TeacherUpdatingInfoScreen extends StatelessWidget {
  const TeacherUpdatingInfoScreen({super.key});

  static String routeName = '/teacher_update_informations_page';

  @override
  Widget build(BuildContext context) {
    return TeacherUpdatingInformationsBody();
  }
}