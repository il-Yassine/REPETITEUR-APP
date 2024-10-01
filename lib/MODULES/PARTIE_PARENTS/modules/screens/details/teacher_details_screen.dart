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



  const TeacherDetailsScreen({
    Key? key,
    required this.teachers,
    required this.repetiteurId,
  }) : super(key: key);

  final Teachers teachers; // Assurez-vous que la classe Teachers est correcte
  final String repetiteurId;

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
            'http://api-mon-encadreur.com/api/repetiteurmcs?repetiteur_id=${widget.repetiteurId}'),
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
              'https://api-mon-encadreur.com/api/evaluations'),
          body: {
            "repetiteur_id": widget.repetiteurId,
            "niveauEvaluation": rating.toString(),
            "user_id": userId,
          },
          headers: {
            'Authorization': 'Bearer $userToken'
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
         print('status code : ${response.statusCode}');
        Get.snackbar("Succès", "Évaluation envoyée avec succès",
            backgroundColor: kWhite, colorText: Colors.green);
      } else {
        print('body: ${response.body}');
        print('Erreur d\'envoi: ${response.statusCode}');
        Get.snackbar('Erreur', 'Vous avez déjà évaluer ce encadreur',backgroundColor: kWhite, colorText: Colors.red);
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kWhite),
          backgroundColor: kPrimaryColor,
          title: Text(arguments!.teachers.user.name.toString(), style: const TextStyle(color: kWhite),),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: CircleAvatar(
                backgroundImage: widget.teachers.profilImageUrl.toString() != 'null' ? NetworkImage(
                  widget.teachers.profilImageUrl.toString(),
                ) : const NetworkImage('https://apibackout.s3.amazonaws.com/images/1713947852vectoriel.jpg'),
                radius: 20,
              ),
            )
          ],
          bottom: const TabBar(
              indicatorColor: kWhite,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: kPrimaryColor,
              dividerColor: kWhite,
              tabs: [
                Tab(
                  child: Text(
                    "Profil",
                    style: TextStyle(color: kWhite, fontSize: 18.0),
                  ),
                ),
                Tab(
                  child: Text(
                    "Autres Informations",
                    style: TextStyle(color: kWhite, fontSize: 18.0),
                  ),
                )
              ]),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
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
                    arguments.teachers.matricule.toString(),
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
                  verticalSpaceTiny,
                  const Text(
                    "Cycle d'enseignement",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  verticalSpaceTiny,
                  Text(
                    arguments.teachers.cycle.toString(),
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
                    arguments.teachers.etats.toString(),
                    maxLines: 4,
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  const Text(
                    "Emploie du temps",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  verticalSpaceTiny,
                  Text(
                    arguments.teachers.heureDisponibilite.toString(),
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
                    arguments.teachers.niveauEtude.toString(),
                    maxLines: 4,
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Status",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceTiny,
                    Text(
                      arguments.teachers.status.toString(),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceTiny,
                    Text(
                      arguments.teachers.description.toString(),
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.03,
                    ),
                    const Text(
                      "Détail sur l'adresse",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceTiny,
                    Text(
                      arguments.teachers.adresse.toString(),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceTiny,
                    Text(
                      arguments.teachers.ecole.toString(),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceTiny,
                    Text(
                      arguments.teachers.grade.toString(),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceTiny,
                    Text(
                      arguments.teachers.evaluation.toString(),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceTiny,
                    Text(
                      arguments.teachers.experience.toString(),
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                    const Text(
                      "Situation Matrimoniale",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceTiny,
                    Text(
                      arguments.teachers.situationMatrimoniale.toString(),
                      maxLines: 4,
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.02,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

        /*SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [



                const Center(
                  child: Text(
                    "Autres Informations",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
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
        ),*/
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
            onPressed: (GetStorage().read("token") != null &&
                    GetStorage().read("token").isNotEmpty)
                ? () {
                    GetStorage().write(
                        "teacher_matricule", arguments.teachers.matricule);
                    GetStorage().write("teacher_classe", classe);
                    GetStorage().write("teacher_matiere", matiere);
                    GetStorage().write("teacher_id", widget.repetiteurId);
                    Navigator.pushNamed(
                        context, TeacherQuickAskScreen.routeName);
                  }
                : null, // Désactive le bouton si la condition n'est pas remplie
            child: const Text(
              "Demander ce répétiteur",
              style: TextStyle(color: kWhite),
            ),
          ),
        ),
      ),
    );
  }
}
