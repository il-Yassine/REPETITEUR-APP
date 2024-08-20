import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/details/teacher_details_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/splash/splash_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/arguments/teacher_details_argument.dart';
import 'package:repetiteur_mobile_app_definitive/core/routing/PARENTS/parents_app_route.dart';
import 'package:repetiteur_mobile_app_definitive/core/routing/REPETIEURS/repetiteurs_app_routes.dart';
import 'package:repetiteur_mobile_app_definitive/provider/answer_provider/parent_answer_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_PARENT/add_children/parent_add_child_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_PARENT/login/parent_login_auth_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_PARENT/register/parent_register_auth_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/login/teacher_login_auth_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/presence_au_poste/presence_poste_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/register/teacher_adding_information_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/register/teacher_file_upload_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/register/teacher_register_auth_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/authentication_provider/AUTH_REPETITEUR/register/teacher_update_informations_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/demand_provider/post_demande_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/forgot_password_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/parent_appreciation_provider.dart/parent_appreciation_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/parent_sent_message_provider/parent_message_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/payment_provider/parent_payment_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/post_classe_matiere/post_classe_matiere_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/role_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/teacher_apprecication_provider/teacher_appreciation_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/teacher_forgot_password_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/teacher_sent_message_provider/teacher_sent_message_provider.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // await StorageService().init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  /*final splashScreenPrefs = await SharedPreferences.getInstance();
  final showSplashScreen =
      splashScreenPrefs.getBool('showSplashScreen') ?? true;

  final onBoardingPrefs = await SharedPreferences.getInstance();
  final showOnboarding = onBoardingPrefs.getBool('showOnboarding') ?? true;*/

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (context) => TeacherForgotPasswordProvider()),
        ChangeNotifierProvider(create: (context) => PresenceAuPosteProvider()),
        ChangeNotifierProvider(create: (context) => TeacherUpdateInformationsProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseProvider()),
        ChangeNotifierProvider(create: (context) => TeacherAddingInformationProvider()),
        ChangeNotifierProvider(create: (context) => AddClasseAndCoursesProvider()),
        ChangeNotifierProvider(create: (context) => ParentPaymentProvider()),
        ChangeNotifierProvider(create: (context) => ParentAnswerProvider()),
        ChangeNotifierProvider(create: (context) => ParentPostAppreciationProvider()),
        ChangeNotifierProvider(create: (context) => TeacherPostAppreciationProvider()),
        ChangeNotifierProvider(create: (context) => PostDemandProvider()),
        ChangeNotifierProvider(
            create: (context) => ParentSentMessageProvider()),
        ChangeNotifierProvider(
            create: (context) => TeacherSentMessageProvider()),
        ChangeNotifierProvider(create: (context) => ParentAddChildProvider()),
        ChangeNotifierProvider(
            create: (context) => TeacherFileUploadProvider()),
        ChangeNotifierProvider(create: (context) => ParentLoginProvider()),
        ChangeNotifierProvider(create: (context) => TeacherLoginingProvider()),
        ChangeNotifierProvider(
            create: (context) => ParentRegisteringProvider()),
        ChangeNotifierProvider(
            create: (context) => TeacherRegisteringProvider()),
        ChangeNotifierProvider(create: (context) => RoleProvider())
      ],
      child: GetMaterialApp(
        title: 'Mon Encadreur',
        defaultTransition: Transition.rightToLeft,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        routes: {
          ...parents_routs,
          ...teachers_routs,
        },
        onGenerateRoute: (settings) {
          if (settings.name == TeacherDetailsScreen.routeName) {
            final args = settings.arguments as TeacherDetailsArgument;

            return MaterialPageRoute(
              builder: (context) {
                return TeacherDetailsScreen(
                  teachers: args.teachers,
                  repetiteurId: args.repetiteurId,
                );
              },
            );
          }
        },
      ),
    );
  }
}
