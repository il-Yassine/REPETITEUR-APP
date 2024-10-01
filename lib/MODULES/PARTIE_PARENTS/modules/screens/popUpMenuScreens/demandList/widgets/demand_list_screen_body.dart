// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/addChild/add_child_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/add_teacher_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/demandList/widgets/add_child_button.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/demandList/widgets/demand_form_button.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';
import 'package:repetiteur_mobile_app_definitive/inputs/app_input_field.dart';
import 'package:repetiteur_mobile_app_definitive/provider/parent_appreciation_provider.dart/parent_appreciation_provider.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/colors.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class DemandListScreenBody extends StatefulWidget {
  const DemandListScreenBody({Key? key}) : super(key: key);

  @override
  State<DemandListScreenBody> createState() => _DemandListScreenBodyState();
}

class _DemandListScreenBodyState extends State<DemandListScreenBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _objetController = TextEditingController();
  final TextEditingController _appreciationController = TextEditingController();

  List<dynamic> demandes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _objetController.clear();
    _appreciationController.clear();
  }

  final userId = GetStorage().read("userId");

  Future<String> getParentId() async {
    // L'URL de votre API
    var url =
        Uri.parse('http://api-mon-encadreur.com/api/parents');

    // Récupérez le token de l'utilisateur connecté
    String token = GetStorage().read("token");

    // Effectuez la requête GET avec le token dans l'en-tête
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });

    // Vérifiez si la requête a réussi
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Si la requête a réussi, parsez la réponse en JSON
      var jsonResponse = jsonDecode(response.body);

      // Obtenez le parent_id du premier élément de la liste 'data'
      var parentId = jsonResponse['data'][0]['id'];

      // Retournez le parent_id
      return parentId;
    } else {
      // Si la requête a échoué, lancez une exception
      throw Exception('Failed to load parent_id');
    }
  }

  Future<void> fetchData() async {
    final userId = GetStorage().read("userId");

    final url =
        "http://api-mon-encadreur.com/api/demandes?user_id=$userId";

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                /*Expanded(
                  child: AddChildButton(
                    text: 'Ajouter un enfant',
                    iconData: CupertinoIcons.add,
                    press: () {
                      Navigator.pushNamed(context, AddChildScreen.routeName);
                    },
                    color: kWhite,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.04,
                ),*/
                Expanded(
                  child: DemandFormButton(
                    text: 'Nouvelle demande',
                    press: () {
                      Navigator.pushNamed(context, AddTeacherScreen.routeName);
                    },
                    color: kWhite,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.035,
            ),
            Expanded(
              child: ListView(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('No.')),
                        DataColumn(label: Text('Nom')),
                        DataColumn(label: Text('Prénom(s)')),
                        DataColumn(label: Text('Classe')),
                        DataColumn(label: Text('Matière')),
                        DataColumn(label: Text('Répétiteur')),
                        DataColumn(label: Text('Statut')),
                        DataColumn(label: Text('Motif')),
                        DataColumn(label: Text('Appréciation')),
                      ],
                      rows: demandes.asMap().entries.map((entry) {
                        final int index = entry.key + 1;
                        final Map<String, dynamic> demande = entry.value;

                        // Accéder aux informations souhaitées

                        final String nomEnfant = demande['enfants']['lname'];
                        final String prenomEnfant = demande['enfants']['fname'];
                        final String classe =
                            demande['tarification']['classe']['name'];
                        final String matiere =
                            demande['tarification']['matiere']['name'];
                        final String repetiteur =
                            demande['repetiteur']['user']['name'];
                        final String status = demande['status'];
                        final String motif = demande['motif'] ?? '';

                        return DataRow(cells: [
                          DataCell(Text('$index')),
                          DataCell(Text(nomEnfant)),
                          DataCell(Text(prenomEnfant)),
                          DataCell(Text(classe)),
                          DataCell(Text(matiere)),
                          DataCell(Text(repetiteur)),
                          DataCell(
                            Text(
                              status,
                              style: TextStyle(
                                color: () {
                                  if (status == 'Validé') {
                                    return Colors.green;
                                  } else if (status == 'En cours') {
                                    return Colors.orange;
                                  } else {
                                    return Colors.red;
                                  }
                                }(),
                              ),
                            ),
                          ),
                          DataCell(Text(motif)),
                          DataCell(
                            TextButton(
                              onPressed: status == 'Validé'
                                  ? () async {
                                      String demandeId = demande['id'];
                                      var parentId = await getParentId();

                                      // Afficher l'ID dans la console
                                      print(
                                          'ID de la demande cliquée : $demandeId');

                                      print('ID du parent : $parentId');

                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                                insetPadding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                    width: double.infinity,
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        0.6,
                                                    decoration: BoxDecoration(
                                                      color: kWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        20, 50, 20, 20),
                                                    child: Form(
                                                        key: _formKey,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                "Appréciation",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25.0,
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
                                                                title: "Objet",
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                controller:
                                                                    _objetController,
                                                              ),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .screenHeight *
                                                                    0.02,
                                                              ),
                                                              AppInputField(
                                                                title:
                                                                    "Votre appréciation",
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                controller:
                                                                    _appreciationController,
                                                                maxLines: 3,
                                                              ),
                                                              SizedBox(
                                                                height: SizeConfig
                                                                        .screenHeight *
                                                                    0.04,
                                                              ),
                                                              Consumer<
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
                                                              })
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
