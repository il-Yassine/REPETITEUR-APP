import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/teacher_message_us/widgets/teacher_message_us_body.dart';

class TeacherMessageUsScreen extends StatelessWidget {
  const TeacherMessageUsScreen({super.key});

  static String routeName = "/teacher_message_us_page";

  @override
  Widget build(BuildContext context) {
    return TeacherMessageUsBody();
  }
}