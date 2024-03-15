import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/profile/widgets/profile_screen_body.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  static String routeName = "/profile_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ProfileScreenBody(),
    );
  }
}
