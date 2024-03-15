/* import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/teacher_adding_infos_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/login/login_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/routers.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:http/http.dart' as http;

class TeacherLoginSuccessfulScreen extends StatefulWidget {
  const TeacherLoginSuccessfulScreen({super.key});

  @override
  State<TeacherLoginSuccessfulScreen> createState() =>
      _TeacherLoginSuccessfulScreenState();
}

class _TeacherLoginSuccessfulScreenState
    extends State<TeacherLoginSuccessfulScreen> {
  bool showButton = false;
  bool showText = false;

  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;

  @override
  void initState() {
    super.initState();
    // Attendre 3 secondes avant d'afficher le bouton
    Timer(const Duration(seconds: 3), () {
      setState(() {
        showButton = true;
      });
    });

    // Attendre 1 seconds avant d'afficher le text
    Timer(const Duration(seconds: 1), () {
      setState(() {
        showText = true;
      });
    });
  }

  // Récupérer le userId depuis GetStorage
  final storedUserId = GetStorage().read("teacherUserId");

  Future<List<Map<String, dynamic>>> fetchAllRepetiteurs() async {
    var client = http.Client();
    var repetiteursUrl = Uri.https(requestBaseUrl, 'api/repetiteurs');
    try {
      final response = await client.get(repetiteursUrl);
      debugPrint("etape 1");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        debugPrint("response data : $responseData");
        debugPrint("response body : ${response.body}");
        if (responseData != null && responseData['data'] != null) {
          return List<Map<String, dynamic>>.from(responseData['data']);
        }
      }
      return [];
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Column(
            children: [
              Lottie.asset("assets/lotties/success_edited(2).json",
                  height: SizeConfig.screenHeight * 0.5),
              /* SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ), */
              AnimatedOpacity(
                  opacity: showText ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: showText
                      ? Text(
                          "Vous avez réussi votre connexion",
                          style: TextStyle(
                              fontSize: SizeConfig.screenWidth * 0.050,
                              fontWeight: FontWeight.w600),
                        )
                      : const SizedBox())
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          AnimatedOpacity(
            opacity: showButton ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: showButton
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8.0),
                    child: AppFilledButton(
                      text: "Continuer",
                      onPressed: () async {
                        print("teacherUserId: $storedUserId");
                        // Vérifier si userId est déjà présent dans la liste des répétiteurs
                        final repetiteurs = await fetchAllRepetiteurs();
                        final bool isUserIdInList = repetiteurs.any(
                            (repetiteur) =>
                                repetiteur['user']['id'] == storedUserId);
                        
                        // Redirection en fonction de la présence du userId dans la liste des répétiteurs
                        if (isUserIdInList) {
                          // Rediriger vers la page d'accueil
                          PageNavigator(ctx: context)
                              .nextPageOnly(page: const TeacherHomeScreen());
                        } else {
                          // Rediriger vers la page d'ajout d'informations
                          PageNavigator(ctx: context).nextPageOnly(
                              page: const TeacherAddingInformationScreen());
                        }
                      },
                    ))
                : const SizedBox(),
          ),
        ],
      )),
    );
  }
}
 */