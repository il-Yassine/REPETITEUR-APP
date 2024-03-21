import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/app_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/teacher_apprecication_provider/teacher_appreciation_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class TeacherDashboardScreenBody extends StatefulWidget {
  const TeacherDashboardScreenBody({
    super.key,
  });

  @override
  State<TeacherDashboardScreenBody> createState() =>
      _TeacherDashboardScreenBodyState();
}

class _TeacherDashboardScreenBodyState extends State<TeacherDashboardScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _appreciationController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  List<dynamic> demandes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.clear();
    _messageController.clear();
    _appreciationController.clear();
  }

  Future<void> fetchData() async {
    final teacherUserId = GetStorage().read("teacherUserId");

    final url =
        "http://apirepetiteur.sevenservicesplus.com/api/demandes?user_id=$teacherUserId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      setState(() {
        demandes = responseData;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Tableau de bord", style: TextStyle(color: kWhite),),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Ma Liste d'Enfants",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.screenHeight * 0.025),
              ),
            ),
            
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Expanded(
              child: ListView(
                children: [
                  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowHeight: SizeConfig.screenHeight *
                        0.06, // Hauteur de la ligne d'en-tête
                    dataRowMaxHeight: SizeConfig.screenHeight * 0.085,
                    columns: const [
                      DataColumn(label: Text('No.')),
                      DataColumn(label: Text('Nom')),
                      DataColumn(label: Text('Prénom(s)')),
                      DataColumn(label: Text('Classe')),
                      DataColumn(label: Text('Matière')),
                      DataColumn(label: Text('Répétiteur')),
                      DataColumn(label: Text('Appréciation')),
                    ],
                
                    rows: demandes.asMap().entries.map((entry) {
                      final int index = entry.key + 1;
                      final Map<String, dynamic> demande = entry.value;
                
                      final String nomEnfant = demande['enfants']['lname'];
                      final String prenomEnfant = demande['enfants']['fname'];
                      final String classe =
                          demande['tarification']['classe']['name'];
                      final String matiere =
                          demande['tarification']['matiere']['name'];
                      final String repetiteur =
                          demande['repetiteur']['user']['name'];
                      final String status = demande['status'];
                
                      return DataRow(cells: [
                        DataCell(Text('$index')),
                        DataCell(Text(nomEnfant)),
                        DataCell(Text(prenomEnfant)),
                        DataCell(Text(classe)),
                        DataCell(Text(matiere)),
                        DataCell(Text(repetiteur)),
                        DataCell(
                          TextButton(
                            onPressed: status == 'Validé'
                                ? () async {
                                    String demandeId = demande['id'];
                                    /* var parentId = await getParentId(); */
                
                                    // Afficher l'ID dans la console
                                    print('ID de la demande cliquée : $demandeId');
                
                                    /* print('ID du parent : $parentId'); */
                
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                              insetPadding:
                                                  const EdgeInsets.all(10),
                                              child: Container(
                                                  width: double.infinity,
                                                  height:
                                                      SizeConfig.screenHeight * 0.6,
                                                  decoration: BoxDecoration(
                                                    color: kWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          20, 50, 20, 20),
                                                  child: Form(
                                                      key: _formKey,
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Appréciation",
                                                              style: TextStyle(
                                                                  fontSize: 25.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .screenHeight *
                                                                  0.04,
                                                            ),
                                                            AppInputField(
                                                              title:
                                                                  "Appréciation sur l'enfant",
                                                              controller:
                                                                  _appreciationController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                            ),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .screenHeight *
                                                                  0.02,
                                                            ),
                                                            AppInputField(
                                                              title:
                                                                  "Presence au poste",
                                                              controller:
                                                                  _dateController,
                                                              suffixIcon:
                                                                  const Icon(Icons
                                                                      .calendar_today),
                                                              onTap: () {
                                                                _selectDate();
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .screenHeight *
                                                                  0.02,
                                                            ),
                                                            AppInputField(
                                                              title: "Observation",
                                                              controller: _messageController,
                                                              maxLines: 4,
                                                            ),
                                                            SizedBox(
                                                              height: SizeConfig
                                                                      .screenHeight *
                                                                  0.04,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                AppFilledButton(
                                                                  text: "Annuler",
                                                                  color: Colors.red,
                                                                  onPressed: () {
                                                                    dispose();
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  width: SizeConfig
                                                                          .screenWidth *
                                                                      0.03,
                                                                ),
                                                                Consumer<
                                                                        TeacherPostAppreciationProvider>(
                                                                    builder:
                                                                        (context,
                                                                            snapshot,
                                                                            child) {
                                                                  WidgetsBinding
                                                                      .instance
                                                                      .addPostFrameCallback(
                                                                          (_) {
                                                                    if (snapshot
                                                                            .resMessage !=
                                                                        '') {
                                                                      showMessage(
                                                                          message:
                                                                              snapshot
                                                                                  .resMessage,
                                                                          context:
                                                                              context);
                                                                      snapshot
                                                                          .clear();
                                                                    }
                                                                  });
                                                                  return AppFilledButton(
                                                                    text: "Envoyer",
                                                                    color: Colors
                                                                        .green,
                                                                    onPressed:
                                                                        () async {
                                                                      if (_formKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        _formKey
                                                                            .currentState!
                                                                            .save();
                                                                        final teacherId =
                                                                            GetStorage()
                                                                                .read("teacherId");
                
                                                                        snapshot
                                                                            .sendTeacherAppreciation(
                                                                          demandeId:
                                                                              demandeId,
                                                                          teacherId:
                                                                              teacherId,
                                                                          appreciation_repetiteur: _appreciationController
                                                                              .text
                                                                              .trim(),
                                                                          date: _dateController
                                                                              .text
                                                                              .trim(),
                                                                          message: _messageController
                                                                              .text
                                                                              .trim(),
                                                                          context:
                                                                              context,
                                                                        );
                                                                        dispose();
                                                                        showMessage(
                                                                          message:
                                                                              'Opération réussie ! ',
                                                                          backgroundColor:
                                                                              Colors
                                                                                  .green,
                                                                          context:
                                                                              context,
                                                                        );
                                                                        Navigator.of(
                                                                                context)
                                                                            .pop();
                                                                      } else if (_appreciationController.text.isEmpty ||
                                                                          _dateController
                                                                              .text
                                                                              .isEmpty ||
                                                                          _messageController
                                                                              .text
                                                                              .isEmpty) {
                                                                        showMessage(
                                                                          message:
                                                                              'Tout les champs sont obligatoires',
                                                                          backgroundColor:
                                                                              Colors
                                                                                  .red,
                                                                          context:
                                                                              context,
                                                                        );
                                                                      }
                                                                    },
                                                                  );
                                                                }),
                                                              ],
                                                            )
                                                            /* Consumer<
                                                                          ParentPostAppreciationProvider>(
                                                                      builder: (context,
                                                                          postAppreciation,
                                                                          child) {
                                                                    WidgetsBinding
                                                                        .instance
                                                                        .addPostFrameCallback(
                                                                            (_) {
                                                                      if (postAppreciation
                                                                              .resMessage !=
                                                                          '') {
                                                                        showMessage(
                                                                            message:
                                                                                postAppreciation
                                                                                    .resMessage,
                                                                            context:
                                                                                context);
                                                                        postAppreciation
                                                                            .clear();
                                                                      }
                                                                    });
                                                                    return AppFilledButton(
                                                                      text:
                                                                          "Envoyer",
                                                                      color: Colors
                                                                          .green,
                                                                      onPressed:
                                                                          () async {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          _formKey
                                                                              .currentState!
                                                                              .save();
                
                                                                          postAppreciation
                                                                              .sendAppreciation(
                                                                            demandeId:
                                                                                demandeId,
                                                                            parentId:
                                                                                parentId,
                                                                            objet: _objetController
                                                                                .text
                                                                                .trim(),
                                                                            appreciation_parents: _appreciationController
                                                                                .text
                                                                                .trim(),
                                                                            context:
                                                                                context,
                                                                          );
                                                                          dispose();
                                                                          showMessage(
                                                                            message:
                                                                                'Opération réussie ! ',
                                                                            backgroundColor:
                                                                                Colors.green,
                                                                            context:
                                                                                context,
                                                                          );
                                                                          Navigator.of(
                                                                                  context)
                                                                              .pop();
                                                                        } else if (_appreciationController
                                                                            .text
                                                                            .isEmpty) {
                                                                          showMessage(
                                                                            message:
                                                                                'Le champ appreciation est obligatoire',
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                            context:
                                                                                context,
                                                                          );
                                                                        }
                                                                      },
                                                                    );
                                                                  }) */
                                                          ],
                                                        ),
                                                      ))));
                                        });
                                  }
                                : null,
                            child: Text(
                              "Appréciation",
                              style: TextStyle(
                                fontSize: SizeConfig.screenHeight * 0.02,
                                color: status == 'Validé'
                                    ? kPrimaryColor
                                    : kcLightGreyColor,
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                    /* rows: demoStudent.asMap().entries.map((entry) {
                      final int index = entry.key + 1;
                      final Student student = entry.value;
                
                      return DataRow(cells: [
                        DataCell(Text('$index')),
                        DataCell(Text(student.lastname)),
                        DataCell(Text(student.firstname)),
                        DataCell(Text(student.studentClass)),
                        DataCell(Text(student.course)),
                        DataCell(Text(student.teacher)),
                        DataCell(
                            TextButton(
                              onPressed: () {
                                // Action à effectuer lors du clic sur le bouton d'appréciation
                              },
                              child: Text(
                                "Appréciation",
                                style: TextStyle(
                                  fontSize: SizeConfig.screenHeight * 0.02,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                      ]);
                    }).toList(), */
                  ),
                ),
                ]
              ),
            ),

            /* Expanded(
              child: ListView.builder(
                itemCount: demoStudent.length,
                itemBuilder: (context, index) =>
                    SingleStudentCard(student: demoStudent[index]),
              ),
            ), */

            /* const Padding(
              padding: EdgeInsets.only(top: 15, left: 10),
              child: Text(
                "Ecoles Partenaires",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
              //      const PatnerSchoolScreen(),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Center(child: SearchTeacherField()),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Text("Quelques Répétiteurs",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ), */
            // const TeacherScreen(),
          ],
        ),
      ),
    );
  }
}
