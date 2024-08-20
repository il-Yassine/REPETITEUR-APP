import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/repetiteur_model.dart';

class RepetiteurController extends GetxController {
  String? prix;
  List<Repetiteur> repetiteurs = [];
  Future<Map<String, dynamic>> getPrixAndRepetiteurFromAPI(
      String idMatiere, String idClasse) async {
    const String apiUrl =
        "http://apirepetiteur.wadounnou.com/api/repetiteurmcs";
    try {
      final response = await http.post(Uri.parse(apiUrl));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> apiData = jsonDecode(response.body);
        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(apiData['data']);
        for (Map<String, dynamic> element in dataList) {
          if (element.containsKey('classe') && element.containsKey('matiere')) {
            if (element['classe']['id'] == idClasse &&
                element['matiere']['id'] == idMatiere) {
              prix = element["prix"];
            }
            if (element.containsKey('repetiteur') &&
                element['repetiteur'] != null) {
              repetiteurs.add(Repetiteur.fromJson({
                "nom": element['repetiteur']['user']['name'].split(' ')[0],
                'prenom': element['repetiteur']['user']['name'].split(' ')[1]
              }));
            }
          }
        }
        return {'prix': prix, 'repetiteur': repetiteurs};
      } else {
        return {};
      }
    } catch (error) {
      throw Exception('Error lors du chargement de la donnee !');
    }
  }
}
