import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/classes_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/communes/commune__model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/matieres/matieres_model.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/REPETITEURS/models/repetiteurs/teacher_model.dart';

class TeacherList {

  static Future<List<Teachers>> getAllTeacher({String? communeName, String? cycle, String? disponibilite}) async {

    const allTeachersUrl = 'http://apirepetiteur.wadounnou.com/api/repetiteurs?traitementDossiers=Validé';

    final response = await http.get(Uri.parse(allTeachersUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<Teachers>((e) => Teachers.fromJson(e)).toList();

  }

  static Future<List<Teachers>> getAllTeacherWithoutEvaluation({String? communeName, String? cycle, String? disponibilite}) async {

    const allTeachersUrl = 'http://apirepetiteur.wadounnou.com/api/repetiteurs';

    final response = await http.get(Uri.parse(allTeachersUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<Teachers>((e) => Teachers.fromJson(e)).toList();

  }

  static Future<List<Teachers>> getTeachersByCommune({String? communeName, String? cycle, String? disponibilite}) async {
    try {
      // Utilisez votre logique pour effectuer la requête réseau avec la route spécifique
      final response = await http.get(Uri.parse('http://apirepetiteur.wadounnou.com/api/repetiteurs?name=$communeName'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final List<Teachers> teachers = data.map((item) => Teachers.fromJson(item)).toList();
        return teachers;
      } else {
        throw Exception('Erreur lors de la récupération des répétiteurs par commune');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des répétiteurs par commune : $e');
    }
  }

  static Future<List<Communes>> getAllCommunes() async {
    const allCommunesUrl = 'http://apirepetiteur.wadounnou.com/api/communes';

    final response = await http.get(Uri.parse(allCommunesUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<Communes>((e) => Communes.fromJson(e)).toList();
  }

  static Future<List<Classes>> getAllClasses() async {
    const allClassesUrl = 'http://apirepetiteur.wadounnou.com/api/classes';

    final response = await http.get(Uri.parse(allClassesUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<Classes>((e) => Classes.fromJson(e)).toList();
  }

  static Future<List<Matieres>> getAllMatieres() async {
    const allMatieresUrl = 'http://apirepetiteur.wadounnou.com/api/matieres';

    final response = await http.get(Uri.parse(allMatieresUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<Matieres>((e) => Matieres.fromJson(e)).toList();
  }
}