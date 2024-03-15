import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/login/widgets/login_form.dart';

class ParentLoginScreen extends StatelessWidget {
  const ParentLoginScreen({super.key});

  static String routeName = "/parent_login_form";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ParentLoginFormScreen(),
    );
  }
}