import 'dart:convert';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/teacher_quick_ask/teacher_quick_ask.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/arguments/teacher_details_argument.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/ui_helpers.dart';
import 'package:http/http.dart' as http;

class TeacherDetailsScreen extends StatefulWidget {
  static String routeName = '/teacher_detail_screen';

  final Teachers teachers; // Assurez-vous que la classe Teachers est correcte
  final String repetiteurId;

  const TeacherDetailsScreen({
    Key? key,
    required this.teachers,
    required this.repetiteurId,
  }) : super(key: key);

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  String classe = '';
  String matiere = '';

  @override
  void initState() {
    super.initState();
    fetchRepetiteurDetails();
  }

  Future<void> fetchRepetiteurDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://apirepetiteur.sevenservicesplus.com/api/repetiteurmcs?repetiteur_id=${widget.repetiteurId}'),
      );

      print(' ::::::::::::::::::::: ${widget.repetiteurId}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        setState(() {
          classe = responseData['data'][0]['classe']['name'] ?? '';
          matiere = responseData['data'][0]['matiere']['name'] ?? '';
        });
      } else {
        // Gérer les erreurs de requête ici
        // Gestion des erreurs de requête
        print('Erreur de requête: ${response.statusCode}');
      }
    } catch (e) {
      // Gestion des erreurs
      print('Erreur: $e');
    }
  }

  Future<void> sendEvaluations(double rating) async {
    final userId = GetStorage().read("userId");
    final userToken = GetStorage().read("token");
    try {
      final response = await http.post(
          Uri.parse(
              'http://apirepetiteur.sevenservicesplus.com/api/evaluations'),
          body: {
            "repetiteur_id": widget.repetiteurId,
            "niveauEvaluation": rating.toString(),
            "user_id": userId,
          },
          headers: {
            'Authorization': 'Bearer $userToken'
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Succès", "Évaluation envoyée avec succès", backgroundColor: kWhite, colorText: Colors.green);
      } else {
        print('Erreur d\'envoi: ${response.statusCode}');
        Get.snackbar('Erreur', 'Échec de l\'envoi de l\'évaluation');
      }
    } catch (e) {
      print('Erreur: $e');
      Get.snackbar('Erreur', 'Une erreur inattendue s\'est produite');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TeacherDetailsArgument? arguments =
        ModalRoute.of(context)?.settings.arguments as TeacherDetailsArgument?;

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments!.teachers.user.name.toString()),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                arguments.teachers.profilImageUrl,
              ),
              radius: 20,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Matricule",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.matricule,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Classe",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                classe,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Matière",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                matiere,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              verticalSpaceTiny,
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Status",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.status,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.description,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Adresse",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.adresse,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Disponibilité",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.heureDisponibilite,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              const Center(
                child: Text(
                  "Autres Informations",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              const Text(
                "Situation Matrimoniale",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.situationMatrimoniale,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Ecole de provenance",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.ecole,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Cycle",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.cycle,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Grade",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.grade,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Niveau d'étude",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.niveauEtude,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Statut de l'enseignent",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.etats,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Evaluer par DIGITALIS SARL",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.evaluation,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              const Text(
                "Experience Professionnelle",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              verticalSpaceTiny,
              Text(
                arguments.teachers.experience,
                maxLines: 4,
                style: const TextStyle(
                    fontSize: 15.0, fontWeight: FontWeight.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              if ((GetStorage().read("token")) != null &&
                  (GetStorage().read("token")).isNotEmpty)
                Center(
                  child: RatingBar(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    onRatingChanged: (value) {
                      sendEvaluations(value);
                      debugPrint('$value');
                    },
                    initialRating: 0,
                    alignment: Alignment.center,
                  ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
          onPressed: (GetStorage().read("token") != null &&
                  GetStorage().read("token").isNotEmpty)
              ? () {
                  GetStorage()
                      .write("teacher_matricule", arguments.teachers.matricule);
                  GetStorage().write("teacher_classe", classe);
                  GetStorage().write("teacher_matiere", matiere);
                  GetStorage().write("teacher_id", widget.repetiteurId);
                  Navigator.pushNamed(context, TeacherQuickAskScreen.routeName);
                }
              : null, // Désactive le bouton si la condition n'est pas remplie
          child: const Text(
            "Demander ce répétiteur",
            style: TextStyle(color: kWhite),
          ),
        ),
      ),
    );
  }
}

/* class MoreDetailsPage extends StatefulWidget {
  const MoreDetailsPage({super.key});

  static String routeName = '/more_details_page';

  @override
  State<MoreDetailsPage> createState() => _MoreDetailsPageState();
}

class _MoreDetailsPageState extends State<MoreDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Plus de details"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: ListView(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: SizeConfig.screenHeight * 0.15,
                        decoration: BoxDecoration(
                            color: kWhite,
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3))
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.screenWidth * 0.03),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "N°",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.028,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "1",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.023),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.08,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.028,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "12-12-2023",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.023),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.08,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Objet",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.028,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Appreciation",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.023),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.08,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Message(Observation)",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.028,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Bon",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.023),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth * 0.08,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Réponse de l'Admin",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.028,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Bien",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight * 0.023),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
} */
