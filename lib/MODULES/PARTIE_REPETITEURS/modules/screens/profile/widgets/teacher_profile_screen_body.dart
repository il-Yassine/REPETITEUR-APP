import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/teacher_adding_infos_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_updating/teacher_updating_infos_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class TeacherProfileScreenBody extends StatefulWidget {
  const TeacherProfileScreenBody({Key? key}) : super(key: key);

  @override
  State<TeacherProfileScreenBody> createState() =>
      _TeacherProfileScreenBodyState();
}

class _TeacherProfileScreenBodyState extends State<TeacherProfileScreenBody> {
  @override
  void initState() {
    super.initState();
    fetchTeacherDatas();
    fetchData();
  }

  Future<Map<String, dynamic>> fetchTeacherDatas() async {
    final teacherUserId = GetStorage().read("teacherUserId");

    final url =
        "http://apirepetiteur.wadounnou.com/api/repetiteurs?user_id=$teacherUserId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final res = json.decode(response.body)['data'][0];
      return res;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<int> fetchData() async {
    final teacherUserId = GetStorage().read("teacherUserId");

    final url =
        "http://apirepetiteur.wadounnou.com/api/demandes?user_id=$teacherUserId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      // Compter le nombre de demandes avec le statut "Validé"
      int validRequestsCount = 0;
      for (var request in responseData) {
        if (request['status'] == 'Validé') {
          validRequestsCount++;
        }
      }

      return validRequestsCount;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchTeacherDatas(),
      builder: (context, teacherDataSnapshot) {
        return FutureBuilder<int>(
          future: fetchData(),
          builder: (context, validRequestsCountSnapshot) {
            if (teacherDataSnapshot.connectionState ==
                    ConnectionState.waiting ||
                validRequestsCountSnapshot.connectionState ==
                    ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (teacherDataSnapshot.hasError ||
                validRequestsCountSnapshot.hasError) {
              return Text('Error: ${teacherDataSnapshot.error}');
            } else {
              final teacherData = teacherDataSnapshot.data!;
              final validRequestsCount = validRequestsCountSnapshot.data!;

              final profilPicture = teacherData['profil_imageUrl'];
              final phoneNumber = teacherData['phone'];
              final commune = teacherData['commune']['name'];
              final address = teacherData['adresse'];
              final description = teacherData['description'];
              final ecole = teacherData['ecole'];
              final disponibilite = teacherData['heureDisponibilite'];
              final grade = teacherData['grade'];
              final dateLieuNaissance = teacherData['dateLieuNaissance'];
              final maritalStatus = teacherData['situationMatrimoniale'];
              final studyLevel = teacherData['niveauEtude'];
              final sexe = teacherData['sexe'];
              final experience = teacherData['experience'];
              final teacherId = teacherData['id'];

              GetStorage().write('teacherId', teacherId);

              return Scaffold(
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.03,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: AppFilledButton(
                            text: "Modifier",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, TeacherUpdatingInfoScreen.routeName);
                            },
                            color: Colors.green,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.03,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Padding(
                            padding:
                                EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                            child: ListView(
                              children: [
                                const Text(
                                  "Photo de profil",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.2,
                                  child: teacherData['profil_imageUrl'] == null
                                      ? Image.network(
                                          'https://apibackout.s3.amazonaws.com/images/1713947852vectoriel.jpg')
                                      : Image.network(
                                          '$profilPicture',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Numéro de téléphone",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$phoneNumber",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Commune",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$commune",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Adresse du domicile",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$address",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Nombre d'enfants encadré",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$validRequestsCount enfant(s)",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Ecole de provenance",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$ecole",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Mon emploie du temps",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$disponibilite",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Date et lieu de naissance",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$dateLieuNaissance",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Niveau d'etude",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$studyLevel",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.03,
                                ),
                                const Text(
                                  "Mon expérience :",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "$experience",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenHeight * 0.02),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
