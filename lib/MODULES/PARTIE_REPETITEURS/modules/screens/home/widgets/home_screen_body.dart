import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/profile/profile_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/widgets/drawer_widget.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/classes_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/matieres/matieres_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/base_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';
import 'package:repetiteur_mobile_app_definitive/provider/post_classe_matiere/post_classe_matiere_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class TeacherHomeScreenBody extends StatefulWidget {
  const TeacherHomeScreenBody({super.key});

  @override
  State<TeacherHomeScreenBody> createState() => _TeacherHomeScreenBodyState();
}

class _TeacherHomeScreenBodyState extends State<TeacherHomeScreenBody> {
  final TextEditingController _matiereController = TextEditingController();
  final TextEditingController _classeController = TextEditingController();

  List<Classes> allClasses = [];
  List<Matieres> allMatieres = [];
  String selectedClasse = '';
  String selectedMatiere = '';

  @override
  void initState() {
    super.initState();
    fetchAllClasses();
    fetchAllMatieres();
  }

  // http://apirepetiteur.sevenservicesplus.com/api/classes

  Future<List<Classes>> fetchAllClasses() async {
    try {
      final teacherUserId = GetStorage().read("teacherUserId");

      const allClassesUrl =
          'http://apirepetiteur.sevenservicesplus.com/api/classes';

      final response = await http.get(Uri.parse(allClassesUrl));

      final body = jsonDecode(response.body);

      final List<Classes> classes =
          List<Classes>.from(body['data'].map((e) => Classes.fromJson(e)));

      setState(() {
        allClasses = classes;
      });

      return classes;
    } catch (e) {
      debugPrint("Erreur : $e");
      return [];
    }
  }

  Future<List<Matieres>> fetchAllMatieres() async {
    try {
      const allMatieresUrl =
          'http://apirepetiteur.sevenservicesplus.com/api/matieres';
      final response = await http.get(Uri.parse(allMatieresUrl));

      final body = jsonDecode(response.body);

      final List<Matieres> matieres =
          List<Matieres>.from(body['data'].map((e) => Matieres.fromJson(e)));

      setState(() {
        allMatieres = matieres;
      });

      return matieres;
    } catch (e) {
      debugPrint("Erreur : $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            iconSize: 25,
            onSelected: (String choice) {
              if (choice == 'Ajouter votre classe et matière') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          insetPadding: const EdgeInsets.all(10),
                          child: Container(
                              width: double.infinity,
                              height: SizeConfig.screenHeight * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: kWhite,
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 50, 20, 20),
                              child: Form(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Matiere et Classe",
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.04,
                                  ),
                                  BaseInputField(
                                    title: "Matière",
                                    inputControl:
                                        DropdownButtonFormField<Matieres>(
                                      items: allMatieres.map((matiere) {
                                        return DropdownMenuItem<Matieres>(
                                          value: matiere,
                                          child: Text(matiere.name),
                                        );
                                      }).toList(),
                                      onChanged: (Matieres? value) {
                                        setState(() {
                                          selectedMatiere = value!.id;
                                          print(
                                              "ID de la matière sélectionnée : $selectedMatiere");
                                        });
                                      },
                                      isDense: true,
                                      isExpanded: true,
                                      iconSize: 22,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_sharp),
                                      hint: const Text(
                                        'Choisissez une matière',
                                        style: TextStyle(
                                          color: kcDarkGreyColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.02,
                                  ),
                                  BaseInputField(
                                    title: "Classe",
                                    inputControl:
                                        DropdownButtonFormField<Classes>(
                                      items: allClasses.map((classe) {
                                        return DropdownMenuItem<Classes>(
                                          value: classe,
                                          child: Text(classe.name),
                                        );
                                      }).toList(),
                                      onChanged: (Classes? value) {
                                        setState(() {
                                          selectedClasse = value!.id;
                                          print(
                                              "ID de la matière sélectionnée : $selectedClasse");
                                        });
                                      },
                                      isDense: true,
                                      isExpanded: true,
                                      iconSize: 22,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_sharp),
                                      hint: const Text(
                                        'Choisissez une classe',
                                        style: TextStyle(
                                          color: kcDarkGreyColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.04,
                                  ),
                                  Consumer<AddClasseAndCoursesProvider>(builder:
                                      (context, snapshot, addClassMatiere) {
                                    return AppFilledButton(
                                      text: "Enregistrer",
                                      color: Colors.green,
                                      onPressed: () {
                                        snapshot.addClasseAndCourses(
                                          matiereId: selectedMatiere.toString(),
                                          classeId: selectedClasse.toString(),
                                          context: context,
                                        );
                                        showMessage(
                                            message:
                                                "Classe et Matière Enregistrés",
                                            backgroundColor: Colors.green,
                                            context: context);

                                        Navigator.pop(context);
                                      },
                                    );
                                  })
                                ],
                              ))));
                    });
              }
              if (choice == 'Quitter l\'application') {
                GetStorage().remove('teacherUserName');
                GetStorage().remove('teacherUserEmail');
                GetStorage().remove('teacherUserId');
                GetStorage().remove('token');
                DatabaseProvider().logOut(context);
                SystemNavigator.pop();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                'Ajouter votre classe et matière',
                'Quitter l\'application',
              ].map((String choice) {
                return PopupMenuItem(value: choice, child: Text(choice));
              }).toList();
            },
          ),
        ],
      ),
      body: const SafeArea(child: TeacherProfileScreen()),
      drawer: DrawerWidget(),
    );
  }
}
