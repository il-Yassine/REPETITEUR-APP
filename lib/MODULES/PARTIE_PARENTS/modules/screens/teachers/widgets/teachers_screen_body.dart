import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/details/teacher_details_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/teachers/widgets/single_teacher_card_widget.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/arguments/teacher_details_argument.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/base_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';

class TeachersScreenBody extends StatefulWidget {
  const TeachersScreenBody(
      {super.key, required this.searchTeacherQuery, required this.press});

  final String searchTeacherQuery;
  final VoidCallback press;

  @override
  State<TeachersScreenBody> createState() => _TeachersScreenBodyState();
}

class _TeachersScreenBodyState extends State<TeachersScreenBody> {
  final _formKey = GlobalKey<FormState>();
  String selectedCommune = '';
  String selectedMatiere = '';
  String selectedCycle = '';
  String selectedDisponibilite = '';
  List<String> allCommunes = [];
  List<String> allMatieres = [];
  List<String> cycles = ["Primaires", "Secondaires", "Universitaires"];
  List<String> disponibilites = ["Disponible", "Non Disponible"];

  @override
  void initState() {
    super.initState();
    fetchAllCommunes();
    fetchAllMatieres();
  }

  Future<void> fetchAllCommunes() async {
    try {
      final communes = await TeacherList.getAllCommunes();
      debugPrint("All Communes: $communes");

      final communeNames =
          communes.map<String>((commune) => commune.name).toList();
      setState(() {
        allCommunes = communeNames;
      });
      print(allCommunes);
    } catch (e) {
      debugPrint(":: $e");
    }
  }

  Future<void> fetchAllMatieres() async {
    try {
      final matieres = await TeacherList.getAllMatieres();
      debugPrint("All Matieres : $matieres");

      final matiereName =
          matieres.map<String>((matieres) => matieres.name).toList();
      setState(() {
        allMatieres = matiereName;
      });
      print(allMatieres);
    } catch (e) {
      debugPrint(":: $e");
    }
  }

  Future<void> fetchFilteredTeachers(
      {String? cycle, String? disponibilite}) async {
    try {
      final teachers = await TeacherList.getAllTeacher(
          cycle: cycle, disponibilite: disponibilite);
      print("Enseignants filtrés :");
      for (var teacher in teachers) {
        debugPrint(teacher.user.name);
      }
    } catch (e) {
      debugPrint("Erreur lors du chargement des enseignants filtrés : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
      key: _formKey,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                /* SizedBox(
                  width: SizeConfig.screenWidth * 0.8,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: BaseInputField(
                        title: "Commune",
                        inputControl: DropdownButtonFormField<String>(
                          items: allCommunes.map((commune) {
                            return DropdownMenuItem<String>(
                              value: commune,
                              child: Text(commune),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedCommune = value!;
                          },
                          isDense: true,
                          isExpanded: true,
                          iconSize: 22,
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          hint: const Text(
                            'Sélectionner une commune...',
                            style: TextStyle(
                                color: kcDarkGreyColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0),
                          ),
                          decoration: const InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        )),
                  ),
                ), */
                SizedBox(
                  width: SizeConfig.screenWidth * 0.8,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: BaseInputField(
                        title: "Cycle",
                        inputControl: DropdownButtonFormField<String>(
                          items: cycles.map((cycle) {
                            return DropdownMenuItem<String>(
                              value: cycle,
                              child: Text(cycle),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCycle = value!;
                              fetchFilteredTeachers(cycle: selectedCycle);
                            });
                          },
                          isDense: true,
                          isExpanded: true,
                          iconSize: 22,
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          hint: const Text(
                            'Sélectionner un cycle...',
                            style: TextStyle(
                                color: kcDarkGreyColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0),
                          ),
                          decoration: const InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        )),
                  ),
                ),
                /* SizedBox(
                  width: SizeConfig.screenWidth * 0.8,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: BaseInputField(
                        title: "Matière",
                        inputControl: DropdownButtonFormField<String>(
                          items: allMatieres.map((matiere) {
                            return DropdownMenuItem<String>(
                              value: matiere,
                              child: Text(matiere),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedMatiere = value!;
                          },
                          isDense: true,
                          isExpanded: true,
                          iconSize: 22,
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          hint: const Text(
                            'Choisissez une matière',
                            style: TextStyle(
                                color: kcDarkGreyColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0),
                          ),
                          decoration: const InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        )),
                  ),
                ), */
                SizedBox(
                  width: SizeConfig.screenWidth * 0.8,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: BaseInputField(
                        title: "Disponibilité",
                        inputControl: DropdownButtonFormField<String>(
                          items: disponibilites.map((disponibilite) {
                            return DropdownMenuItem<String>(
                              value: disponibilite,
                              child: Text(disponibilite),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedDisponibilite = value!;
                            fetchFilteredTeachers(
                              cycle: selectedCycle,
                              disponibilite: selectedDisponibilite,
                            );
                          },
                          isDense: true,
                          isExpanded: true,
                          iconSize: 22,
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          hint: const Text(
                            'Tous',
                            style: TextStyle(
                                color: kcDarkGreyColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0),
                          ),
                          decoration: const InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.02,
          ),
          FutureBuilder<List<Teachers>>(
            future: TeacherList.getAllTeacher(
                communeName: selectedCommune,
                cycle: selectedCycle,
                disponibilite: selectedDisponibilite),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text("Veuillez Patienter un moment..."),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "Une erreur s'est produite lors du chargement repetiteurs"),
                    ],
                  ),
                );
              }

              List<Teachers> allTeachers =
                  snapshot.data as List<Teachers>? ?? [];

              List<Teachers> filteredTeachers;
              if (selectedCycle.isNotEmpty ||
                  selectedDisponibilite.isNotEmpty) {
                filteredTeachers = allTeachers.where((teacher) {
                  String teacherName = teacher.user.name.toLowerCase();
                  bool matchesCycle = selectedCycle.isNotEmpty
                      ? teacher.cycle == selectedCycle
                      : true;

                  bool matchesDisponibilite = selectedDisponibilite.isNotEmpty
                      ? teacher.etats.toLowerCase() ==
                          selectedDisponibilite.toLowerCase()
                      : true;

                  return teacherName
                          .contains(widget.searchTeacherQuery.toLowerCase()) &&
                      matchesCycle &&
                      matchesDisponibilite;
                }).toList();
              } else {
                filteredTeachers = allTeachers;
              }

              if (filteredTeachers.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: SizeConfig.screenHeight * 0.18,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kWhite,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Center(
                      child: Text(
                        "Aucunes données n'est présentes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      itemCount: filteredTeachers.length,
                      itemBuilder: (context, index) => SingleTeacherCardWidget(
                          teachers: filteredTeachers[index],
                          press: () {
                            print(
                                "ID du répétiteur : ${filteredTeachers[index].id}");
                            Navigator.pushNamed(
                                context, TeacherDetailsScreen.routeName,
                                arguments: TeacherDetailsArgument(
                                    teachers: filteredTeachers[index],
                                    repetiteurId: filteredTeachers[index].id));
                          })),
                );
              }
            },
          ),
        ],
      ),
    ));
  }
}
