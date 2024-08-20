import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/ecole/school_model.dart';

class SchoolList {

  Future<List<School>> ecoles = getAllSchool();

  static Future<List<School>> getAllSchool() async {
    
    const allSchoolUrl = 'http://apirepetiteur.wadounnou.com/api/ecoles';

    final response = await http.get(Uri.parse(allSchoolUrl));

    final body = jsonDecode(response.body);

    return body['data'].map<School>((e) => School.fromJson(e)).toList();
  }
}