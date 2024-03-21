import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/examList/widgets/exam_list_screen_body.dart';

class ExamListScreen extends StatelessWidget {
  const ExamListScreen({super.key});

  static String routeName = '/exam_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des epreuves'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ExamListScreenBody(),
    );
  }
}
