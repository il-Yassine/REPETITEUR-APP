import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/appreciation/appreciation_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/appreciation/pour_repetiteur/list_appreciation_pour_repetiteur.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/forgot_password/parent_forgot_password_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/login/login_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/register/register_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/bibliotheque/bibliotheque_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/details/teacher_details_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/message_us/message_us_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/addChild/add_child_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/add_teacher_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/demandList/demand_list_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/examList/exam_list_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/paymentList/paymment_list_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/teacher_quick_ask/teacher_quick_ask.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/profile/profile_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/response_admin/response_admin_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/landing/landing_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/onBoarding/onboarding_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/splash/splash_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/arguments/teacher_details_argument.dart';


final Map<String, WidgetBuilder> parents_routs = {


// ROUTE DES PAGES POUR LA PARTIE PARENTS

  SplashScreen.routeName: (context) => const SplashScreen(),
  OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
  ParentLandingScreen.routeName: (context) => const ParentLandingScreen(),
  ParentHomeScreen.routeName: (context) => const ParentHomeScreen(),
  ParentLoginScreen.routeName: (context) => const ParentLoginScreen(),
  ParentRegisterScreen.routeName: (context) => const ParentRegisterScreen(),
  ParentProfileScreen.routeName: (context) => const ParentProfileScreen(),
  TeacherDetailsScreen.routeName: (context) {
    final args = ModalRoute.of(context)!.settings.arguments as TeacherDetailsArgument;
    return TeacherDetailsScreen(
      teachers: args.teachers,
      repetiteurId: args.repetiteurId,
    );
  },
  AddChildScreen.routeName: (context) => const AddChildScreen(),
  AddTeacherScreen.routeName: (context) => const AddTeacherScreen(),
  DemandListScreen.routeName: (context) => const DemandListScreen(),
  PayementListScreen.routeName: (context) => const PayementListScreen(),
  ExamListScreen.routeName: (context) => const ExamListScreen(),
  ParentForgotPassworsScreen.routeName: (context) => const ParentForgotPassworsScreen(),
  MessageUsScreen.routeName: (context) => const MessageUsScreen(),
  AppreciationScreen.routeName: (context) => const AppreciationScreen(),
  BibliothequeScreen.routeName: (context) => const BibliothequeScreen(),
  /* MoreDetailsPage.routeName: (context) => MoreDetailsPage(), */
  TeacherQuickAskScreen.routeName: (context) => const TeacherQuickAskScreen(),
  AdminResponseScreen.routeName: (context) => const AdminResponseScreen(),
  AppreciationPourRepetiteur.routeName: (context) => const AppreciationPourRepetiteur()

//---------------------------------------------------------------------------------------------------

// ROUTE DES PAGES POUR LA PARTIE REPETITEURS

  

//---------------------------------------------------------------------------------------------------

};