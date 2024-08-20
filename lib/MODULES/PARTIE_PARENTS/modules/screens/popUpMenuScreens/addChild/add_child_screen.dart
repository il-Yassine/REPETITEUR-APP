import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/addChild/widgets/add_child_form.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';

class AddChildScreen extends StatelessWidget {
  const AddChildScreen({super.key});

  static String routeName = "/add_child_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        backgroundColor: kPrimaryColor,
        title: Text("Ajouter un enfant", style: TextStyle(color: kWhite),),
        centerTitle: true,
        elevation: 0,
      ),
      body: AddChildForm(),
    );
  }
}
