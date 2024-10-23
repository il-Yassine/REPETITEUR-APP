import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/select_role_page/selected_role_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/onBoarding/onboarding_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/fetch_all_users_role.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key, required this.nextScreen});

  final Widget nextScreen;

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
      splash: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.35,
            ),
            // A remplacer par le logo de l'application
            Image.asset(
              'assets/logo_repetiteur/Mon Répétiteu rpng .png',
              width: SizeConfig.screenHeight * 0.25,
            ),
            const Spacer(
              flex: 4,
            ),
            Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'powered by ',
                      style: TextStyle(fontSize: 14, color: kTextColor),
                    ),

                    const SizedBox(width: 5,),
                    Image.asset('assets/logo_repetiteur/logo Digitalis.png', width: SizeConfig.screenHeight * 0.14,)
                  ],
                )),
          ],
        ),
        backgroundColor: kWhite,
        splashIconSize: SizeConfig.screenHeight * 0.95,
        duration: 6000,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(seconds: 2),
        nextScreen: widget.nextScreen,
    );
  }

  checkPreferences() async {
    final teacherRoleId = await fetchRepetiteurRoleId();
    final parentRoleId = await fetchParentsRoleId();
    final roleCheck = GetStorage().read('role_id');
    // Initialisation d'une instance de Shared Preferences
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Creation d'une preference
    final bool isFirstRun = preferences.getBool('isFirstRun') ?? true;

    if(isFirstRun){
      // Navigation vers l'interface de OnBoardingScreen
      Navigator.pushReplacementNamed(context, OnBoardingScreen.routeName);
      // Ici comme il n'y a aucune valeur dans la preference on initialise une preference à false
      preferences.setBool('isFirstRun', false);
    }else if (roleCheck == teacherRoleId){
      // ici il existe déjà une valeur dans la preference on passe directement à l'interface de HomeScreen
      Navigator.pushReplacementNamed(context, TeacherHomeScreen.routeName);
      preferences.setBool('isFirstRun', true);
    } else if (roleCheck == parentRoleId) {
      Navigator.pushReplacementNamed(context, ParentHomeScreen.routeName);
      preferences.setBool('isFirstRun', true);
    }
  }

  /* bool checkRoleAndToken(){
      final token = GetStorage().read('token');
      final roleId = GetStorage().read('role_id');
      if(roleId != null){
      return true;
      }else{
        return false;
      }
    } */
}