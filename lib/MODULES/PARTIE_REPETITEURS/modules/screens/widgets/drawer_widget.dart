
import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/all_observations/all_observations_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/bibliotheque/teacher_bibliotheque_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/dashboard/teacher_dashboard_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/presence_au_poste/presence_poste_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/response_admin/response_admin_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/teacher_message_us/teacher_message_us_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/widgets/CustomListTileWidget.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final teacherName = GetStorage().read('teacherUserName') ?? 'Nom d\'utilisateur';

  final teacherEmail = GetStorage().read('teacherUserEmail') ?? 'test@gmail.com';

  String token = GetStorage().read('token').toString();

  int unreadRequests = 0;
  int unreadMessages = 0;

  List<String> unreadNotificationIds = [];

   verifyToken(String str){
     if(str.isNotEmpty){
       return str;
     }else{
       return Get.snackbar("Erreur", 'Token vide');
     }
   }

  Future<bool> logout(String token)async{
    try{
      String logoutUrl = "http://api-mon-encadreur.com/api/logout";
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

  Future<void> fetchData() async {
    final teacherUserId = GetStorage().read("teacherUserId");

    final url =
        "http://api-mon-encadreur.com/api/demandes?user_id=$teacherUserId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      // Mise à jour du nombre de demandes non lues
      setState(() {
        unreadRequests = responseData.length;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchNotificationsData() async {
    final teacherUserId = GetStorage().read("teacherUserId");

    final notificationsUrl =
        'http://api-mon-encadreur.com/api/notifications?user_id=$teacherUserId';

    final response = await http.get(Uri.parse(notificationsUrl));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = jsonDecode(response.body)['data'];

      // Compter les notifications non lues
      unreadNotificationIds = responseData
          .where((notification) => notification['status'] == 'Non lu')
          .map((notification) => notification['id'].toString())
          .toList();

      setState(() {
        unreadMessages = unreadNotificationIds.length;
      });
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> markNotificationsAsRead() async {
    for (String notificationId in unreadNotificationIds) {
      final notificationsUrl =
          'http://api-mon-encadreur.com/api/notifications/$notificationId';

      final response = await http.put(
        Uri.parse(notificationsUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'status': 'Lu', // Mettre à jour le statut de la notification à "Lu"
        }),
      );

      if (response.statusCode == 200) {
        // Notification marquée comme lue avec succès
        setState(() {
          unreadMessages -= 1; // Réduire le nombre de notifications non lues
        });
      } else {
        throw Exception('Failed to mark notification as read');
      }
    }
  }



  @override
  void initState() {
    super.initState();
    fetchData();
    fetchNotificationsData();
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
                text: 'Présence au poste',
                iconData: LineIcons.addressCard,
                iconColor: kPrimaryColor,
              ),
              onTap: () {
               // Navigator.pop(context);
                Navigator.pushNamed(
                    context, PresenceAuPosteScreen.routeName);
              },
            ),
          if (token.isNotEmpty)
            badges.Badge(
              position: BadgePosition.topEnd(top: 3, end: 100),
              badgeContent: Text(unreadRequests.toString(), style: TextStyle(color: Colors.white),),
              child: GestureDetector(
                  child: const CustomListTileWidget(
                    text: 'Tableau de bord',
                    iconData: Icons.bar_chart_rounded,
                    iconColor: kPrimaryColor,
                  ),
                  onTap: () {
                    setState(() {
                      unreadRequests = 0;
                    });
                    Navigator.pushNamed(
                        context, TeacherDashboardScreen.routeName);
                  }),
            ),
          if (token.isNotEmpty)
            GestureDetector(
              child: const CustomListTileWidget(
                text: 'Les Observations',
                iconData: LineIcons.list,
                iconColor: kPrimaryColor,
              ),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => AllObservations()));
              },
            ),
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
            badges.Badge(
              position: BadgePosition.topEnd(top: 3, end: 8),
              badgeContent: Text(unreadMessages.toString(), style: TextStyle(color: Colors.white),),
              child: GestureDetector(
                child: const CustomListTileWidget(
                  text: 'Réponse de l\'administrateur',
                  iconData: LineIcons.editAlt,
                  iconColor: kPrimaryColor,
                ),
                onTap: () async {
                  await markNotificationsAsRead();
                  unreadMessages = 0;
                  Navigator.pushNamed(context, TeacherAdminResponseScreen.routeName);
                },
              ),
            ),

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
