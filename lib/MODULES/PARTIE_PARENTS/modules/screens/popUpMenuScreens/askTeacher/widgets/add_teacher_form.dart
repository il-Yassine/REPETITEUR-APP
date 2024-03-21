import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/addChild/add_child_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/controllers/child_controller.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/widgets/add_teacher_success_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/demandList/widgets/add_child_button.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/child_models.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/repetiteur_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/routers.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/base_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/demand_provider/post_demande_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddTeacherForm extends StatefulWidget {
  const AddTeacherForm({Key? key}) : super(key: key);

  @override
  State<AddTeacherForm> createState() => _AddTeacherFormState();
}

class _AddTeacherFormState extends State<AddTeacherForm> {
  final _formKey = GlobalKey<FormState>();
  String selectedClasse = '';
  String selectedMatiere = '';
  String selectedChild = '';
  String selectedRepetiteurMatricule = '';
  List<Child> chidrenList = [];
  List<String> allClasses = [];
  List<String> allMatieres = [];

  List<DropdownMenuItem<String>> repetiteurMatriculeDropdownItems = [];
  List<Repetiteur> matricule = [];

  String selectedChildId = '';
  String selectedTeacherId = '';
  String selectedTarificationId = '';
  String selctedRepetiteurName = '';

  final _remunerationController = TextEditingController();
  final _repetiteurNameController = TextEditingController();
  final _repetiteurMatriculeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchAllClasses();
    fetchAllMatieres();
  }

  Future<void> fetchTarification(String classe, String matiere) async {
    const apiUrl =
        "http://apirepetiteur.sevenservicesplus.com/api/tarifications";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiData = jsonDecode(response.body);
        final dataList = List<Map<String, dynamic>>.from(apiData['data']);

        if (classe.isNotEmpty && matiere.isNotEmpty) {
          final tarification = dataList.firstWhere(
            (element) =>
                element['classe']['name'] == classe &&
                element['matiere']['name'] == matiere,
            orElse: () => <String, dynamic>{},
          );

          if (tarification.isNotEmpty) {
            String prix = tarification['prix']?.toString() ?? '0';

            // Stockez l'id de la tarification dans la variable
            selectedTarificationId = tarification['id'].toString();
            debugPrint(
                "ID de la tarification sélectionnée : $selectedTarificationId");

            _remunerationController.text = '$prix FCFA';
          } else {
            _remunerationController.text = '0 FCFA';
            debugPrint(
                "Tarification introuvable pour la classe: $classe et la matière: $matiere");
          }
        } else {
          _remunerationController.text = '';
        }
      } else {
        debugPrint("Erreur lors de la requête: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Erreur: $e");
    }
  }

  Future<void> fetchRepetiteursMatricule(String classe, String matiere) async {
    // Remplacez l'URL avec l'API appropriée pour récupérer les répétiteurs
    const apiUrl =
        "http://apirepetiteur.sevenservicesplus.com/api/repetiteurmcs";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiData = jsonDecode(response.body);
        final dataList = List<Map<String, dynamic>>.from(apiData['data']);

        // Filtrer la liste des répétiteurs en fonction de la classe et de la matière
        final filteredRepetiteursMatricule = dataList
            .where((element) =>
                element['classe']['name'] == classe &&
                element['matiere']['name'] == matiere)
            .toList();

        // Convertir chaque élément en un objet Repetiteur
        final List<Repetiteur> repetiteursMatriculeList =
            filteredRepetiteursMatricule.map((element) {
          return Repetiteur(
            id: element['repetiteur']['id'],
            matricule: element['repetiteur']['matricule'],
            name: element['repetiteur']['user']['name'],
            // Ajoutez d'autres propriétés selon vos besoins
          );
        }).toList();
        // Mettre à jour la liste des répétiteurs dans l'état
        setState(() {
          matricule = repetiteursMatriculeList;
          repetiteurMatriculeDropdownItems =
              matricule.map((repetiteurMatricule) {
            return DropdownMenuItem<String>(
              value: repetiteurMatricule.id,
              child: Text(repetiteurMatricule.matricule),
            );
          }).toList();
        });
      } else {
        debugPrint("Erreur lors de la requête: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Erreur: $e");
    }
  }

  Future<void> fetchRepetiteurs(String repetiteurId) async {
    const apiUrl =
        "http://apirepetiteur.sevenservicesplus.com/api/repetiteurmcs";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiData = jsonDecode(response.body);
        final dataList = List<Map<String, dynamic>>.from(apiData['data']);

        if (repetiteurId.isNotEmpty) {
          final filteredRepetiteurs = dataList.firstWhere(
            (element) => element['repetiteur']['id'] == repetiteurId,
            orElse: () => <String, dynamic>{},
          );

          if (filteredRepetiteurs.isNotEmpty) {
            String repetiteurName =
                filteredRepetiteurs['repetiteur']['user']['name']?.toString() ??
                    '';

            // ignore: unnecessary_string_interpolations
            _repetiteurNameController.text = '$repetiteurName';
          } else {
            _repetiteurNameController.text = '';
            debugPrint("Repetiteur introuvable pour l'ID: $repetiteurId");
          }
        }
      } else {
        debugPrint("Erreur lors de la requête: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Erreur: $e");
    }
  }

  Future<void> fetchAllClasses() async {
    try {
      final childController = ChildController();
      final parentsId = GetStorage().read("userId");
      final children = await childController.getChildInfo(parentsId.toString());

      final classes = await TeacherList.getAllClasses();
      debugPrint("All Classes : $classes");

      final classeNames =
          classes.map<String>((classes) => classes.name).toList();
      setState(() {
        chidrenList = children;
        allClasses = classeNames;
      });
      debugPrint('$allClasses');
    } catch (e) {
      debugPrint("Erreur : $e");
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
      debugPrint('$allMatieres');
    } catch (e) {
      debugPrint("Erreur : $e");
    }
  }

  @override
  void dispose() {
    _remunerationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Demande de répétiteur", style: TextStyle(color: kWhite)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AddChildButton(
                text: 'Ajouter un enfant',
                iconData: CupertinoIcons.add,
                press: () {
                  Navigator.pushNamed(context, AddChildScreen.routeName);
                },
                color: kWhite,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      BaseInputField(
                        title: "Enfants",
                        inputControl: DropdownButtonFormField<String>(
                          items: chidrenList.map((child) {
                            return DropdownMenuItem<String>(
                              value: "${child.nom} ${child.prenom}",
                              child: Text("${child.nom} ${child.prenom}"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedChild = value!;
                              selectedChildId = chidrenList
                                  .firstWhere((child) =>
                                      "${child.nom} ${child.prenom}" ==
                                      selectedChild)
                                  .id;
                              debugPrint(
                                  "ID de l'enfant sélectionné : $selectedChildId");
                            });
                          },
                          isDense: true,
                          isExpanded: true,
                          iconSize: 22,
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          hint: const Text(
                            'Choisissez un enfant',
                            style: TextStyle(
                              color: kcDarkGreyColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      BaseInputField(
                        title: "Classe",
                        inputControl: DropdownButtonFormField<String>(
                          items: allClasses.map((classe) {
                            return DropdownMenuItem<String>(
                              value: classe,
                              child: Text(classe),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedClasse = value!;
                              fetchTarification(
                                  selectedClasse, selectedMatiere);

                              fetchRepetiteursMatricule(
                                  selectedClasse, selectedMatiere);
                            });
                          },
                          isDense: true,
                          isExpanded: true,
                          iconSize: 22,
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      BaseInputField(
                        title: "Matière",
                        inputControl: DropdownButtonFormField<String>(
                          items: allMatieres.map((matiere) {
                            return DropdownMenuItem<String>(
                              value: matiere,
                              child: Text(matiere),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMatiere = value!;
                              fetchTarification(
                                  selectedClasse, selectedMatiere);

                              fetchRepetiteursMatricule(
                                  selectedClasse, selectedMatiere);
                            });
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
                              fontSize: 14.0,
                            ),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      BaseInputField(
                        title: "Rémunération",
                        inputControl: TextFormField(
                          controller: _remunerationController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: '30000 FCFA',
                            hintStyle: TextStyle(
                              color: kcLightGreyColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      BaseInputField(
                        title: "Matricule",
                        inputControl: TypeAheadFormField<Repetiteur>(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: _repetiteurMatriculeController,
                            decoration: const InputDecoration(
                              hintText: 'Saisissez un matricule',
                              hintStyle: TextStyle(
                                color: kcLightGreyColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                              ),
                              isDense: true,
                              suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            // Filtrez les matricules en fonction du motif de saisie
                            return matricule
                                .where((repetiteurMatricule) =>
                                    repetiteurMatricule.matricule
                                        .toLowerCase()
                                        .contains(pattern.toLowerCase()))
                                .toList();
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.matricule),
                            );
                          },
                          onSuggestionSelected: (Repetiteur suggestion) {
                            setState(() {
                              selectedRepetiteurMatricule = suggestion.id;
                              selectedTeacherId = suggestion.id;
                              fetchRepetiteurs(selectedTeacherId);

                              // Mettez à jour le contrôleur avec le matricule sélectionné
                              _repetiteurMatriculeController.text =
                                  suggestion.matricule;
                            });
                          },
                        ),
                      ),
                      /* BaseInputField(
                        title: "Matricule",
                        inputControl: DropdownButtonFormField<String>(
                          items: repetiteurMatriculeDropdownItems,
                          onChanged: (value) {
                            setState(() {
                              selectedRepetiteurMatricule = value!;
                              selectedTeacherId = matricule
                                  .firstWhere((repetiteurMatricule) =>
                                      repetiteurMatricule.id ==
                                      selectedRepetiteurMatricule)
                                  .id;
                              debugPrint(
                                  "ID du répétiteur sélectionné : $selectedTeacherId");

                              fetchRepetiteurs(selectedTeacherId);
                            });
                          },
                          isDense: true,
                          isExpanded: true,
                          iconSize: 22,
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          hint: const Text(
                            'Choisissez un matricule',
                            style: TextStyle(
                              color: kcDarkGreyColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ), */
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      BaseInputField(
                        title: "Répétiteur",
                        inputControl: TextFormField(
                          controller: _repetiteurNameController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            isDense: true,
                            hintText: 'FANOU Jean',
                            hintStyle: TextStyle(
                              color: kcLightGreyColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      BaseInputField(
                        title: "Informations complémentaires",
                        inputControl: TextFormField(
                          maxLines: 3,
                          controller: _descriptionController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black54),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Consumer<PostDemandProvider>(
                            builder: (context, send_demand, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (send_demand.resMessage != '') {
                              showMessage(
                                  message: send_demand.resMessage,
                                  context: context);
                              send_demand.clear();
                            }
                          });
                          return AppFilledButton(
                            text: "Envoyer",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                send_demand.sendDemand(
                                  tarification_id:
                                      selectedTarificationId.toString(),
                                  enfants_id: selectedChildId.toString(),
                                  repetiteur_id: selectedTeacherId.toString(),
                                  description:
                                      _descriptionController.text.trim(),
                                  context: context,
                                );
                                showMessage(
                                  message: 'Demande envoyée avec succès !',
                                  backgroundColor: Colors.green,
                                  context: context,
                                );
                                PageNavigator(ctx: context).nextPageOnly(
                                    page: const AddTeacherSuccessScreen());
                              } else if (selectedTarificationId.isEmpty ||
                                  selectedChildId.isEmpty ||
                                  selectedTeacherId.isEmpty ||
                                  _descriptionController.text.isEmpty) {
                                showMessage(
                                  backgroundColor: Colors.red,
                                  message: 'Tous les champs sont obligatoires',
                                  context: context,
                                );
                              }
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
