import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/splash/widgets/splash_screen_body.dart';
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
    SizeConfig().init(context);
    return const Scaffold(
      body: SplashScreenBody(),
    );
  }
}