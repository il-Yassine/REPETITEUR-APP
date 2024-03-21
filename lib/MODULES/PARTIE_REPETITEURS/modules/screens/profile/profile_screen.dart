import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/profile/widgets/teacher_profile_screen_body.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  static String routeName = '/teacher_profile_screen';

  @override
  Widget build(BuildContext context) {
    return TeacherProfileScreenBody();
  }
}