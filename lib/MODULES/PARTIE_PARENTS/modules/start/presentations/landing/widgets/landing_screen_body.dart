import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/login/login_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/register/register_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/landing/widgets/landing_background.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/helpers/ui_helpers.dart';

class ParentLandingScreenBody extends StatefulWidget {
  const ParentLandingScreenBody({super.key, this.selectedRoleId});

  final String? selectedRoleId;

  @override
  State<ParentLandingScreenBody> createState() =>
      _ParentLandingScreenBodyState();
}

class _ParentLandingScreenBodyState extends State<ParentLandingScreenBody> {
  var ctime;
  final token = GetStorage().read("token");

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (ctime == null ||
            now.difference(ctime) > const Duration(seconds: 2)) {
          //add duration of press gap
          ctime = now;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Appuyer encore pour quitter'))); //scaffold message, you can show Toast message too.
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Stack(
        children: [
          const BackgroundImage(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.5,
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/logo_repetiteur/Mon Répétiteu rpng .png',
                            width: SizeConfig.screenHeight * 0.40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (token != null && token.isNotEmpty) 
                  Padding(padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       MaterialButton(
                              height: 55.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              color: kPrimaryColor,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ParentHomeScreen.routeName,
                                    arguments: widget.selectedRoleId);
                              },
                              child: const Text(
                                "Poursuivre votre session",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                    ],
                  ),),
                  if (token == null || token.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        
                          MaterialButton(
                              height: 55.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              color: kPrimaryColor,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ParentRegisterScreen.routeName,
                                    arguments: widget.selectedRoleId);
                              },
                              child: const Text(
                                "S'inscrire",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        verticalSpaceRegular,
                       
                          MaterialButton(
                              height: 55.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ParentLoginScreen.routeName);
                              },
                              child: const Text(
                                "Se Connecter",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )),
                        verticalSpaceRegular,
                        verticalSpaceRegular,
                        verticalSpaceRegular,
                         
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ParentHomeScreen.routeName);
                              },
                              child: const Text(
                                'Parcourir sans se connecter',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: kPrimaryColor,
                                    fontSize: 18),
                              )),
                        
                      ],
                    ),
                  )
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
