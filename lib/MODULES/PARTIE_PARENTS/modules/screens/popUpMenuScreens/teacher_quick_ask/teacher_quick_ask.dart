import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/teacher_quick_ask/widgets/teacher_quick_ask_form.dart';

class TeacherQuickAskScreen extends StatelessWidget {
  const TeacherQuickAskScreen({super.key});

  static String routeName = '/teacher_quick_ask_screen';

  @override
  Widget build(BuildContext context) {
    return TeacherQuickAskForm();
  }
}