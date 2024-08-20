import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/onBoarding/onboarding_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/splash/widgets/splash_screen_body.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/fetch_all_users_role.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirst = false;

  @override
  void initState() {
    super.initState();
    checkFirstRun();
  }

  Future<void> checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();

    var isFr = prefs.getBool('isFirstRun');
    if (isFr == false) {
      setState(() {
        isFirst = false;
      });
    } else {
      setState(() {
        isFirst = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final teacherRoleId = fetchRepetiteurRoleId();
    final parentRoleId = fetchParentsRoleId();
    final roleCheck = GetStorage().read('role_id');
    SizeConfig().init(context);
    return Scaffold(
      body: SplashScreenBody(
          nextScreen: isFirst
              ? const OnBoardingScreen()
              : roleCheck == parentRoleId
                  ? const ParentHomeScreen()
                  : const TeacherHomeScreen()),
    );
  }
}
