import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/teachers/widgets/single_teacher_card_widget.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen(
      {super.key,
      required this.searchTeacherQuery,
      required this.press});
      
  final String searchTeacherQuery;
  final VoidCallback press;

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  bool isRefresh = false;

  Future<void> _onRefresh() async {
    try {
      setState(() {
        isRefresh = true;
      });
      List<Teachers> teachers = await TeacherList.getAllTeacher();
    } catch (e) {
      print(("Erreur: ${e}"));
    } finally {
      setState(() {
        isRefresh = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: _onRefresh,
      child: FutureBuilder<List<Teachers>>(
        future: TeacherList.getAllTeacher(),
        builder: (context, AsyncSnapshot snapshot) {
          List<Teachers> filteredTeachers =
              (snapshot.data as List<Teachers>?)?.where((teacher) {
                    String teacherName = teacher.user.name.toLowerCase();
                    return teacherName
                        .contains(widget.searchTeacherQuery.toLowerCase());
                  }).toList() ??
                  [];
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
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  //Product Single Card
                  ...List.generate(
                      3,
                      (index) => SingleTeacherCardWidget(
                          teachers: filteredTeachers[index],
                          press: () {
                            /*Navigator.pushNamed(context, TeacherDetailsScreen.routeName,
                            arguments: TeacherDetailsArgument(
                                teacher: demoTeacher[index]));*/
                          })),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
