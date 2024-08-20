import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/ecole_partenaires/pages/ecoles_partenaire.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/ecole_partenaires/pages/teacher_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/addChild/add_child_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/add_teacher_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/demandList/demand_list_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/paymentList/paymment_list_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/widgets/drawer_widget.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/ecole/school_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/ecole/school_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';

class ParentHomeScreenBody extends StatefulWidget {
  const ParentHomeScreenBody({super.key});

  @override
  State<ParentHomeScreenBody> createState() => _ParentHomeScreenBodyState();
}

class _ParentHomeScreenBodyState extends State<ParentHomeScreenBody> {
  String searchSchoolQuery = '';
  String searchTeacherQuery = '';

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  bool isRefresh = false;

  Future<void> _onRefresh() async {
    try {
      setState(() {
        isRefresh = true;
      });
      List<School> schools = await SchoolList.getAllSchool();
      List<Teachers> teachers = await TeacherList.getAllTeacher();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La page a été mis à jour'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Erreur lors de l'actualisation de la page. Vérifier votre connexion internet..."),
        ),
      );
      print(("Erreur: ${e}"));
    } finally {
      setState(() {
        isRefresh = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kWhite),
        title: const Text("Accueil", style: TextStyle(color: kWhite),),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          if ((GetStorage().read('token')) != null &&
              (GetStorage().read('token')).isNotEmpty)
            PopupMenuButton<String>(
              iconSize: 25,
              onSelected: (String choice) {
                /*if (choice == 'Ajouter un enfant') {
                  Navigator.pushNamed(context, AddChildScreen.routeName);
                }*/
                if (choice == 'Faire une demande') {
                  Navigator.pushNamed(context, AddTeacherScreen.routeName);
                }
                if (choice == 'Liste de mes demandes') {
                  Navigator.pushNamed(context, DemandListScreen.routeName);
                }
                if (choice == 'Mes paiements') {
                  Navigator.pushNamed(context, PayementListScreen.routeName);
                }
                if (choice == 'Quitter l\'application') {
                  GetStorage().remove('userName');
                  GetStorage().remove('userMail');
                  GetStorage().remove('userId');
                  GetStorage().remove('token');
                  DatabaseProvider().logOut(context);
                  SystemNavigator.pop();
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  /*'Ajouter un enfant',*/
                  'Faire une demande',
                  'Liste de mes demandes',
                  'Mes paiements',
                  'Quitter l\'application',
                ].map((String choice) {
                  return PopupMenuItem(value: choice, child: Text(choice));
                }).toList();
              },
            ),
        ],
      ),
      body: SafeArea(
          child: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(12),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: Text("Quelques Répétiteurs",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              TeacherScreen(
                searchTeacherQuery: searchTeacherQuery,
                press: () {},
              ),
              /*SizedBox(
                height: SizeConfig.screenHeight * 0.01,
              ),*/
              const Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  "Ecoles Partenaires",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              PatnerSchoolScreen(
                searchQuery: searchSchoolQuery,
                press: () {},
              ),
            ],
          ),
        ),
      )),
      drawer: DrawerWidget(),
    );
  }
}
