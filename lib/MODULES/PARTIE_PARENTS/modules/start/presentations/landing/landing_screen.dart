import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/landing/widgets/landing_screen_body.dart';

class ParentLandingScreen extends StatefulWidget {
  const ParentLandingScreen({super.key, this.selectedRoleId});

  final String? selectedRoleId;

  static String routeName = '/parent_landing';

  @override
  State<ParentLandingScreen> createState() => _ParentLandingScreenState();
}

class _ParentLandingScreenState extends State<ParentLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParentLandingScreenBody(selectedRoleId: widget.selectedRoleId),
    );
  }
}
