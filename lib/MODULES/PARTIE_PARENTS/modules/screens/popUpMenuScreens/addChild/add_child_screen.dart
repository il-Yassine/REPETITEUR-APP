import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/addChild/widgets/add_child_form.dart';

class AddChildScreen extends StatelessWidget {
  const AddChildScreen({super.key});

  static String routeName = "/add_child_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un enfant"),
        centerTitle: true,
        elevation: 0,
      ),
      body: AddChildForm(),
    );
  }
}
