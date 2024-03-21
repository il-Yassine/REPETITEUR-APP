import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/forgot_password/widgets/parent_forgot_password_body.dart';

class ParentForgotPassworsScreen extends StatelessWidget {
  const ParentForgotPassworsScreen({super.key});

  static String routeName = '/parent_forgot_password_page';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Mot de passe oublié"),
        centerTitle: true,
      ),
      body: ParentForgotPasswordBody(),
    );
  }
}