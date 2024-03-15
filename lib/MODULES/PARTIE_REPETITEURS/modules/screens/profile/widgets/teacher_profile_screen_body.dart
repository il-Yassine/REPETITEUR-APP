import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/teacher_adding_infos_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/shared/ui/widgets/buttons/app_fill_button.dart';

class TeacherProfileScreenBody extends StatefulWidget {
  const TeacherProfileScreenBody({super.key});

  @override
  State<TeacherProfileScreenBody> createState() =>
      _TeacherProfileScreenBodyState();
}

class _TeacherProfileScreenBodyState extends State<TeacherProfileScreenBody> {
  Future<Map<String, dynamic>> fetchTeacherDatas() async {

    final teacherUserId = GetStorage().read("teacherUserId");

    final url =
        "http://apirepetiteur.sevenservicesplus.com/api/repetiteurs?user_id=$teacherUserId";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final res = json.decode(response.body)['data'][0];
        return res;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTeacherDatas();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchTeacherDatas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final teacherData = snapshot.data;
          final profilPicture = teacherData!['profil_imageUrl'];
          final phoneNumber = teacherData['phone'];
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      text: "Modifier",
                      onPressed: () {
                        Navigator.pushNamed(context, TeacherAddingInformationScreen.routeName);
                      },
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                      child: ListView(
                        children: [
                          const Text(
                            "Photo de profil",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                              height: SizeConfig.screenHeight * 0.2,
                              child: Image.network(
                                '$profilPicture',
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),
                          const Text(
                            "Numéro de téléphone",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
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
                            "Adresse de domicile",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
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
                            "Description",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "$description",
                            style: TextStyle(
                                fontSize: SizeConfig.screenHeight * 0.02),
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),
                          const Text(
                            "Ecole",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
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
                            "Disponiblité",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
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
                            "Grade",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "$grade",
                            style: TextStyle(
                                fontSize: SizeConfig.screenHeight * 0.02),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),
                          const Text(
                            "Date et lieu de naissance",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
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
                            "Situation matrimoniale",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "$maritalStatus",
                            style: TextStyle(
                                fontSize: SizeConfig.screenHeight * 0.02),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),
                          const Text(
                            "Niveau d'etude",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
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
                            "Sexe",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "$sexe",
                            style: TextStyle(
                                fontSize: SizeConfig.screenHeight * 0.02),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.03,
                          ),
                          const Text(
                            "Experience :",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w700),
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
            )),
          );
        }
      },
    );
  }
}
