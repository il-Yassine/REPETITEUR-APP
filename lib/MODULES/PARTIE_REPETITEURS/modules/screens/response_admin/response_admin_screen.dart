import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/response_admin/widget/response_admin_body.dart';

class TeacherAdminResponseScreen extends StatelessWidget {
  const TeacherAdminResponseScreen({super.key});

  static String routeName = "/admin_response_page_for_teacher";

  @override
  Widget build(BuildContext context) {
    return TeacherAdminResponseBody();
  }
}