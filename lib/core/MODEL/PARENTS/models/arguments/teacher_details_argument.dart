import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/repetiteurs.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';

class TeacherDetailsArgument {
  final Teachers teachers;
  final String repetiteurId;
  /* final String selectedCommune; */

  TeacherDetailsArgument({
    required this.teachers,
    required this.repetiteurId,
    /* required this.selectedCommune, */
  });
}
