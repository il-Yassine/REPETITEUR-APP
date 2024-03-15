import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/widgets/home_screen_body.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  static String routeName = "/teacher_home";

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  DateTime backPressedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return WillPopScope(
      onWillPop: () => _onBackButtonClickedDoubleClicked(context),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: TeacherHomeScreenBody(),
      ),
    );
  }

  Future<bool> _onBackButtonClickedDoubleClicked(BuildContext context) async {
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();

    if (difference >= const Duration(seconds: 2)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appuyer encore pour quitter')));
      return false;
    } else {
      GetStorage().remove('teacherUserName');
      GetStorage().remove('teacherUserEmail');
      GetStorage().remove('teacherUserId');
      GetStorage().remove('token');
      DatabaseProvider().logOut(context);
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}
