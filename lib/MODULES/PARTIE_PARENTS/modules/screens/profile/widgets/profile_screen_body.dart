import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/login/login_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/authentication/register/register_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/demandList/demand_list_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/profile/widgets/profile_menu.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.04,
        ),
        if ((GetStorage().read('token')) != null &&
            (GetStorage().read('token')).isNotEmpty)
          /* ProfileMenu(icon: CupertinoIcons.profile_circled, text: "Mon Compte", press: () {},), */
          ProfileMenu(
            icon: Icons.schedule_send,
            text: "Mes Demandes",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DemandListScreen()));
            },
          ),
        /* if ((GetStorage().read('token')) != null &&
            (GetStorage().read('token')).isNotEmpty)
          ProfileMenu(
            icon: CupertinoIcons.settings,
            text: "Paramètres",
            press: () {},
          ), */
        if ((GetStorage().read('token')) != null &&
            (GetStorage().read('token')).isNotEmpty)
          Consumer<DatabaseProvider>(builder: (context, snapshot, child) {
            return ProfileMenu(
              icon: Icons.logout_outlined,
              text: "Déconnexion",
              press: () {
                GetStorage().remove('userName');
                GetStorage().remove('userMail');
                GetStorage().remove('userId');
                GetStorage().remove('token');
                snapshot.logOut(context);
              },
            );
          }),
        if ((GetStorage().read('token')) == null)
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.3,
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
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                const Text(
                  "ou",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
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
                ),
              ],
            ),
          )
      ],
    );
  }
}
