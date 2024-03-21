import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/appreciation/appreciation_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/login/login_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/register/register_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/bibliotheque/bibliotheque_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/message_us/message_us_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/response_admin/response_admin_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/widgets/CustomListTileWidget.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final nomUser = GetStorage().read('userName') ?? 'Nom d\'utilisateur';

  final token = GetStorage().read('token');

  final mailUser = GetStorage().read('userMail') ?? 'test@gmail.com';

  int unreadRequests = 0;
  int unreadMessages = 0;

  List<String> unreadNotificationIds = [];

  Future<void> fetchData() async {

    final userId = GetStorage().read("userId");

    final url =
        "http://apirepetiteur.sevenservicesplus.com/api/postes?user_id=$userId";

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
    final userId = GetStorage().read("userId");

    final notificationsUrl =
        'http://apirepetiteur.sevenservicesplus.com/api/notifications?user_id=$userId';

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
          'http://apirepetiteur.sevenservicesplus.com/api/notifications/$notificationId';

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
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: kPrimaryColor),
                accountName: Text("$nomUser"),
                accountEmail: Text('$mailUser')),
          ),
          if (token != null && token.isNotEmpty)
            badges.Badge(
              position: BadgePosition.topEnd(top: 3, end: 88),
              badgeContent: Text(unreadRequests.toString(), style: TextStyle(color: Colors.white),),
              child: GestureDetector(
                child: const CustomListTileWidget(
                  text: 'Boîte de réception',
                  iconData: Icons.note_add_outlined,
                  iconColor: kPrimaryColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AppreciationScreen.routeName);
                },
              ),
            ),
          if (token != null && token.isNotEmpty)
            GestureDetector(
              child: const CustomListTileWidget(
                text: 'Contactez-nous',
                iconData: Icons.send_rounded,
                iconColor: kPrimaryColor,
              ),
              onTap: () {
                Navigator.pushNamed(context, MessageUsScreen.routeName);
              },
            ),
          if (token != null && token.isNotEmpty)
            badges.Badge(
              position: BadgePosition.topEnd(top: 3, end: 8),
              badgeContent: Text(unreadMessages.toString(), style: TextStyle(color: Colors.white),),
              child: GestureDetector(
                child: const CustomListTileWidget(
                  text: 'Réponse de l\'administrateur',
                  iconData: LineIcons.editAlt,
                  iconColor: kPrimaryColor,
                ),
                onTap: () {
                  Navigator.pushNamed(context, AdminResponseScreen.routeName);
                },
              ),
            ),
          if (token != null && token.isNotEmpty)
            GestureDetector(
              child: const CustomListTileWidget(
                text: 'Bibliothèque',
                iconData: LineIcons.file,
                iconColor: kPrimaryColor,
              ),
              onTap: () {
                Navigator.pushNamed(context, BibliothequeScreen.routeName);
              },
            ),

          /* GestureDetector(
            child: CustomListTileWidget(
              text: 'Paramètres',
              iconData: CupertinoIcons.settings_solid,
              iconColor: kPrimaryColor,
            ),
          ), */
          if (token != null && token.isNotEmpty)
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Deconnexion"),
                        content: const Text(
                            "Etes-vous de voulir quitter l'application?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Non")),
                          Consumer<DatabaseProvider>(
                              builder: (context, snapshot, child) {
                            return TextButton(
                                onPressed: () {
                                  GetStorage().remove('userName');
                                  GetStorage().remove('userMail');
                                  GetStorage().remove('userId');
                                  GetStorage().remove('token');
                                  snapshot.logOut(context);
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
          if (token == null)
            Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      text: "Se connecter",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ParentLoginScreen.routeName);
                      },
                      color: kWhite,
                      txtColor: kPrimaryColor,
                    ),
                  ),
                ),
                const Text("ou", style: TextStyle(fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      text: "S'inscrire",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ParentRegisterScreen.routeName);
                      },
                      color: kPrimaryColor,
                      txtColor: kWhite,
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
