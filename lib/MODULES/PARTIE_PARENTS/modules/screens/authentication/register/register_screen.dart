import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/register/widgets/register_form.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/role_model.dart';
import 'package:repetiteur_mobile_app_definitive/provider/role_provider.dart';

class ParentRegisterScreen extends StatelessWidget {
  const ParentRegisterScreen({super.key});

  static String routeName = '/parent_register_screen';

  @override
  Widget build(BuildContext context) {
    Role? selectedRole = Provider.of<RoleProvider>(context).selectedRole;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ParentRegisterFormScreen(selectedRole: selectedRole),
    );
  }
}
