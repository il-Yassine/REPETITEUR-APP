import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/widgets/add_teacher_form.dart';

class AddTeacherScreen extends StatelessWidget {
  const AddTeacherScreen({super.key});

  static String routeName = '/add_teacher_screen';

  @override
  Widget build(BuildContext context) {
    return AddTeacherForm();
  }
}
