import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/teachers/widgets/teachers_screen_body.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_list_class.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';

class ParentTeachersScreen extends StatefulWidget {
  const ParentTeachersScreen({super.key});

  static String routeName = "/teachers_screen";

  @override
  State<ParentTeachersScreen> createState() => _ParentTeachersScreenState();
}

class _ParentTeachersScreenState extends State<ParentTeachersScreen> {
  String searchTeacherQuery = '';
  String? selectedCommune;

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
      List<Teachers> teachers = await TeacherList.getAllTeacher(communeName: selectedCommune);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La page a été mis à jour'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Erreur lors de l'actualisation de la page. Vérifier votre connexion internet..."),
        ),
      );
      print(("Erreur: ${e}"));
    } finally {
      setState(() {
        isRefresh = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Nos Répétiteurs", style: TextStyle(color: kWhite),),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        color: kPrimaryColor,
        onRefresh: _onRefresh,
        child: TeachersScreenBody(
          press: () {},
          searchTeacherQuery: searchTeacherQuery,
        ),
      ),
    );
  }
}
