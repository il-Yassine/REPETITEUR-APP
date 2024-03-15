import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/select_role_page/selected_role_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

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
        nextScreen: /* checkRoleAndToken() ? TeacherHomeScreen() :  */const SelectedRoleScreen(),
    );
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