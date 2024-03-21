import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/controllers/child_controller.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/widgets/add_teacher_success_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/child_models.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/routers.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/app_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/base_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/demand_provider/post_demande_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class TeacherQuickAskForm extends StatefulWidget {
  const TeacherQuickAskForm({Key? key}) : super(key: key);

  @override
  State<TeacherQuickAskForm> createState() => _TeacherQuickAskFormState();
}

class _TeacherQuickAskFormState extends State<TeacherQuickAskForm> {
  final _formKey = GlobalKey<FormState>();

  String? matricule;
  String? selectedChild;
  String selectedTarificationId = '';
  String? selectedTeacherId;

  final TextEditingController _classeController =
      TextEditingController(text: GetStorage().read("teacher_classe"));

  final TextEditingController _matiereController =
      TextEditingController(text: GetStorage().read("teacher_matiere"));

  final TextEditingController _remunerationController = TextEditingController();
  final TextEditingController _matriculeController =
      TextEditingController(text: GetStorage().read("teacher_matricule"));

  TextEditingController _descriptionController = TextEditingController();

  String selectedChildId = '';

  String teacherClasse = '';
  String teacherMatiere = '';
  List<Child> childrenList = [];
  List<String> allClasses = [];

  @override
  void initState() {
    super.initState();
    fetchAllClasses();
    fetchTarification();
  }

  Future<void> fetchTarification() async {
    const apiUrl =
        "http://apirepetiteur.sevenservicesplus.com/api/tarifications";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final apiData = jsonDecode(response.body);
        final dataList = List<Map<String, dynamic>>.from(apiData['data']);

        final classe = GetStorage().read("teacher_classe");
        final matiere = GetStorage().read("teacher_matiere");

        if (classe != null && matiere != null) {
          final tarification = dataList.firstWhere(
            (element) =>
                element['classe']['name'] == classe &&
                element['matiere']['name'] == matiere,
            orElse: () => <String, dynamic>{},
          );

          if (tarification.isNotEmpty) {
            String prix = tarification['prix']?.toString() ?? '0';

            selectedTarificationId = tarification['id'].toString();
            print(
                "ID de la tarification sélectionnée : $selectedTarificationId");

            _remunerationController.text = '$prix FCFA';
          } else {
            _remunerationController.text = '0 FCFA';
            print(
                "Tarification introuvable pour la classe: $classe et la matière: $matiere");
          }
        } else {
          _remunerationController.text = '';
        }
      } else {
        print("Erreur lors de la requête: ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur: $e");
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
        childrenList = children;
        allClasses = classeNames;
      });
      print(allClasses);
    } catch (e) {
      debugPrint(":: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demande de répétiteur"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  BaseInputField(
                    title: "Enfants",
                    inputControl: DropdownButtonFormField<String>(
                      items: childrenList.map((child) {
                        return DropdownMenuItem<String>(
                          value: "${child.nom} ${child.prenom}",
                          child: Text("${child.nom} ${child.prenom}"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedChild = value!;
                          selectedChildId = childrenList
                              .firstWhere((child) =>
                                  "${child.nom} ${child.prenom}" ==
                                  selectedChild)
                              .id;
                          print(
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
                            fontSize: 14.0),
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  BaseInputField(
                    title: "Classe",
                    inputControl: TextFormField(
                      readOnly: true,
                      controller: _classeController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintStyle: TextStyle(
                            color: kcLightGreyColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  BaseInputField(
                    title: "Matière",
                    inputControl: TextFormField(
                      readOnly: true,
                      controller: _matiereController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintStyle: TextStyle(
                            color: kcLightGreyColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  BaseInputField(
                    title: "Rémunération",
                    inputControl: TextFormField(
                      readOnly: true,
                      controller: _remunerationController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: '30000 FCFA',
                        hintStyle: TextStyle(
                            color: kcLightGreyColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  BaseInputField(
                    title: "Matricule du Repetiteur",
                    inputControl: TextFormField(
                      readOnly: true,
                      controller: _matriculeController,
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'M000001',
                        hintStyle: TextStyle(
                            color: kcLightGreyColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          matricule = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  AppInputField(
                    title: 'Informations complementaire',
                    controller: _descriptionController,
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<PostDemandProvider>(
                        builder: (context, quickDemand, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (quickDemand.resMessage != '') {
                          showMessage(
                              message: quickDemand.resMessage,
                              context: context);
                          quickDemand.clear();
                        }
                      });
                      return AppFilledButton(
                        text: "Envoyer",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            selectedTeacherId = GetStorage().read("teacher_id");
                            quickDemand.sendDemand(
                              tarification_id:
                                  selectedTarificationId.toString(),
                              enfants_id: selectedChildId.toString(),
                              repetiteur_id: selectedTeacherId.toString(),
                              description: _descriptionController.text.trim(),
                              context: context,
                            );
                            /* PageNavigator(ctx: context).nextPageOnly(
                                page: const AddTeacherSuccessScreen()); */
                          }
                          else if (selectedTarificationId.isEmpty ||
                              selectedChildId.isEmpty ||
                              selectedTeacherId!.isEmpty ||
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
