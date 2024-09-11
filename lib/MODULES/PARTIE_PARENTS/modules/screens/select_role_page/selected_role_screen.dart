import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/select_role_page/selected_role_screen_background.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/start/presentations/landing/landing_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/start/presentations/landing/landing_screen.dart';

import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/role_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/provider/role_provider.dart';

import '../../../../../core/constants/REPETITEURS/constants.dart';

class SelectedRoleScreen extends StatefulWidget {
  const SelectedRoleScreen({super.key});

  @override
  State<SelectedRoleScreen> createState() => _SelectedRoleScreenState();
}

class _SelectedRoleScreenState extends State<SelectedRoleScreen> {
  String selectedRole = '';
  String? selectedRoleId;
  late Future<List<String>> roles;

  @override
  void initState() {
    super.initState();
    roles = fetchRolesIds();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: roles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body:
                  SafeArea(child: Center(child: CircularProgressIndicator())));
        } else if (snapshot.hasError) {
          return const Scaffold(
              body: SafeArea(
                  child: Center(
                      child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Error 404: Erreur lors de la connexion au serveur. Vérifiez votre connexion internet et rééssayez',
              maxLines: 3,
            ),
          ))));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
              body: SafeArea(
                  child: Center(
                      child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error 500: Aucun rôle disponible'),
          ))));
        } else {
          List<String> roleIds = snapshot.data!;
          return ChangeNotifierProvider(
              create: (context) =>
                  RoleProvider(), // Assurez-vous d'avoir RoleProvider dans votre arbre de widget
              child:
                  Consumer<RoleProvider>(builder: (context, roleProvider, _) {
                // Utilisez roleProvider.selectedRole ici
                return buildRoleSelectionWidget(roleIds, roleProvider);
              }));
        }
      },
    );
  }

  Widget buildRoleSelectionWidget(
      List<String> roleIds, RoleProvider roleProvider) {
    return Stack(
      children: [
        const SelectedRoleScreenBackground(),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/logo_repetiteur/Mon Répétiteu rpng .png",
                  ),
                  radius: 30,
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.18,
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 6,
                          spreadRadius: 0.0,
                        )
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.035,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Radio(
                              value: 'Repetiteur',
                              groupValue: selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value!;
                                  selectedRoleId = roleIds.firstWhere(
                                      (role) => selectedRole == 'Repetiteur');
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Module de l\' Encadreur',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Radio(
                              value: 'Parents',
                              groupValue: selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value!;
                                  selectedRoleId = roleIds.firstWhere(
                                      (role) => selectedRole == 'Parents');
                                });
                              },
                            ),
                          ),
                          const Text('Module des Parents',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.35,
                ),
                selectedRole.isNotEmpty
                    ? SizedBox(
                        height: SizeConfig.screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            var storedToken = GetStorage().read('token');
                            print('Stored token: $storedToken');
                            if (selectedRole == "Repetiteur") {
                              debugPrint('Selected Role ID: $selectedRoleId');
                              GetStorage().write('role_id', selectedRoleId);
                              Navigator.pushNamed(
                                  context, TeacherLandingScreen.routeName,
                                  arguments: selectedRoleId);
                            } else if (selectedRole == "Parents") {
                              debugPrint('Selected Role ID: $selectedRoleId');
                              GetStorage().write('role_id', selectedRoleId);
                              if (storedToken != null &&
                                  storedToken.isNotEmpty) {
                                Navigator.pushNamed(
                                    context, ParentHomeScreen.routeName,
                                    arguments: selectedRoleId);
                              } else {
                                Navigator.pushNamed(
                                    context, ParentLandingScreen.routeName,
                                    arguments: selectedRoleId);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedRole == 'Repetiteur'
                                ? kPrimaryColor
                                : Colors.orange,
                          ),
                          child: Text(
                            selectedRole == 'Repetiteur'
                                ? 'Continuer en tant que Encadreurs'
                                : 'Continuer en tant que Parents',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : const Text('Sélectionnez un rôle pour continuer.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
