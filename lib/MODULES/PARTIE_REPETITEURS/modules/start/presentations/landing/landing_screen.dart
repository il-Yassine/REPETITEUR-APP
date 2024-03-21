import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/landing/widgets/landing_screen_body.dart';

class TeacherLandingScreen extends StatefulWidget {
  const TeacherLandingScreen({super.key, this.selectedRoleId});

  final String? selectedRoleId;

  static String routeName = '/teacher_landing';

  @override
  State<TeacherLandingScreen> createState() => _TeacherLandingScreenState();
}

class _TeacherLandingScreenState extends State<TeacherLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TeacherLandingScreenBody(selectedRoleId: widget.selectedRoleId),
    );
  }
}
