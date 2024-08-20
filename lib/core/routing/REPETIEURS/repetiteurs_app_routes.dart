import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/forgot_password/teacher_forgot_password_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/teacher_adding_infos_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/widgets/adding_info_success_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_updating/teacher_updating_infos_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/login/login_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/register/register_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/bibliotheque/teacher_bibliotheque_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/dashboard/teacher_dashboard_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/presence_au_poste/presence_poste_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/profile/profile_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/response_admin/response_admin_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/teacher_message_us/teacher_message_us_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/landing/landing_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/splash/splash_screen.dart';

final Map<String, WidgetBuilder> teachers_routs = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  TeacherLandingScreen.routeName: (context) => const TeacherLandingScreen(),
  TeacherHomeScreen.routeName: (context) => const TeacherHomeScreen(),
  TeacherRegisterScreen.routeName: (context) => const TeacherRegisterScreen(),
  TeacherLoginScreen.routeName: (context) => const TeacherLoginScreen(),
  TeacherAddingInformationScreen.routeName: (context) =>
      const TeacherAddingInformationScreen(),
  TeacherUpdatingInfoScreen.routeName: (context) =>
      const TeacherUpdatingInfoScreen(),
  TeacherForgotPasswordScreen.routeName: (context) =>
      const TeacherForgotPasswordScreen(),
  AddingInfoSuccessScreen.routeName: (context) =>
      const AddingInfoSuccessScreen(),
  TeacherProfileScreen.routeName: (context) => const TeacherProfileScreen(),
  TeacherDashboardScreen.routeName: (context) => const TeacherDashboardScreen(),
  TeacherMessageUsScreen.routeName: (context) => const TeacherMessageUsScreen(),
  TeacherBibliothequeScreen.routeName: (context) =>
      const TeacherBibliothequeScreen(),
  TeacherAdminResponseScreen.routeName: (context) =>
      const TeacherAdminResponseScreen(),
  PresenceAuPosteScreen.routeName: (context) => const PresenceAuPosteScreen(),

  /* TeacherDetailsScreen.routeName: (context) => TeacherDetailsScreen(),


  ProfileScreen.routeName: (context) => ProfileScreen(),
  OTPScreen.routeName: (context) => OTPScreen(),
  AddChildScreen.routeName: (context) => AddChildScreen(),
  AddTeacherScreen.routeName: (context) => AddTeacherScreen(),
  DemandListScreen.routeName: (context) => DemandListScreen(),
  PayementListScreen.routeName: (context) => PayementListScreen(),
  ExamListScreen.routeName: (context) => ExamListScreen(), */
};
