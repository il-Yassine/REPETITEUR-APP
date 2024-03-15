
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/bibliotheque/teacher_bibliotheque_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/dashboard/teacher_dashboard_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/response_admin/response_admin_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/teacher_message_us/teacher_message_us_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/widgets/CustomListTileWidget.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final teacherName = GetStorage().read('teacherUserName') ?? 'Nom d\'utilisateur';
  final teacherEmail = GetStorage().read('teacherUserEmail') ?? 'test@gmail.com';
  String token = GetStorage().read('token').toString();

   verifyToken(String str){
     if(str.isNotEmpty){
       return str;
     }else{
       return Get.snackbar("Erreur", 'Token vide');
     }
   }

  Future<bool> logout(String token)async{
    try{
      String logoutUrl = "http://apirepetiteur.sevenservicesplus.com/api/logout";
      final request = await http.get(Uri.parse(logoutUrl),
      headers:<String, String>{'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
      }
      );
      if(request.statusCode == 204){
       // final response = jsonDecode(request.body);
        showMessage(
          message: "Deconnexion avec succès!" //response["message"]
        );
        return true;
      }else {
        return false;
      }
    }catch(error){
      throw Exception('Erreur lors de la deconnexion: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              accountName: Text("$teacherName"),
              accountEmail: Text('$teacherEmail'),
              decoration: const BoxDecoration(
                color: kPrimaryColor,
              ),
            ),
          ),
          if (token.isNotEmpty)
            GestureDetector(
              child: const CustomListTileWidget(
                text: 'Profil',
                iconData: LineIcons.userAlt,
                iconColor: kPrimaryColor,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          if (token.isNotEmpty)
            GestureDetector(
                child: const CustomListTileWidget(
                  text: 'Tableau de bord',
                  iconData: Icons.bar_chart_rounded,
                  iconColor: kPrimaryColor,
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, TeacherDashboardScreen.routeName);
                }),
          if (token.isNotEmpty)
            GestureDetector(
              child: const CustomListTileWidget(
                text: 'Bibliothèque',
                iconData: LineIcons.file,
                iconColor: kPrimaryColor,
              ),
              onTap: () {
                Navigator.pushNamed(
                    context, TeacherBibliothequeScreen.routeName);
              },
            ),
          if (token.isNotEmpty)
            GestureDetector(
              child: const CustomListTileWidget(
                text: 'Boîte d\'envoie',
                iconData: Icons.send,
                iconColor: kPrimaryColor,
              ),
              onTap: () {
                Navigator.pushNamed(context, TeacherMessageUsScreen.routeName);
              },
            ),
            if (token.isNotEmpty)
            GestureDetector(
              child: const CustomListTileWidget(
                text: 'Réponse de l\'administrateur',
                iconData: LineIcons.editAlt,
                iconColor: kPrimaryColor,
              ),
              onTap: () {
                Navigator.pushNamed(context, TeacherAdminResponseScreen.routeName);
              },
            ),
          /* const CustomListTileWidget(
            text: 'Paramètres',
            iconData: CupertinoIcons.settings_solid,
            iconColor: kPrimaryColor,
          ), */
          if (token.isNotEmpty)
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Deconnexion"),
                        content: const Text(
                            "Etes-vous sûr de vouloir quitter l'application?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Non")),
                          Consumer<DatabaseProvider>(
                              builder: (context, snapshot, child) {
                            return TextButton(
                                onPressed: () async{
                                //  String newToken = verifyToken(token);
                                //   bool isOk = await logout(token);
                                //   if(isOk == true) {
                                    GetStorage().remove('teacherUserName');
                                    GetStorage().remove('teacherUserEmail');
                                    GetStorage().remove('teacherUserId');
                                    GetStorage().remove('token');
                                    snapshot.logOut(context);
                                   // Get.snackbar('Erreur', 'Une erreur s\'est produite lors de la déconnexion',backgroundColor: Colors.green);

                                  // }else{
                                  //   Get.snackbar('Erreur', 'Une erreur s\'est produite lors de la déconnexion',backgroundColor: Colors.red);
                                  // }
                                },
                                child: const Text("Oui"));
                          })
                        ],
                      );
                    });
              },
              child: const CustomListTileWidget(
                text: 'Déconnexion',
                iconData: Icons.exit_to_app_outlined,
                iconColor: kPrimaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
