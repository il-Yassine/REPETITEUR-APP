import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/forgot_password/widgets/teacher_forgot_password_body.dart';

class TeacherForgotPasswordScreen extends StatelessWidget {
  const TeacherForgotPasswordScreen({super.key});

  static String routeName = "/teacher_forgot_password_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mot de passe oublié"),
        centerTitle: true,
      ),
      body: TeacherForgotPasswordBody(),
    );
  }
}