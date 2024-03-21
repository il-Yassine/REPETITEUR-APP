import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/response_admin/widget/response_admin_body.dart';

class AdminResponseScreen extends StatelessWidget {
  const AdminResponseScreen({super.key});

  static String routeName = "/admin_response_page";

  @override
  Widget build(BuildContext context) {
    return AdminResponseBody();
  }
}