import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchRepetiteurRoleId() async {
  final response = await http.get(Uri.parse('http://apirepetiteur.sevenservicesplus.com/api/roles'));

  if (response.statusCode == 200) {
    final List<dynamic> roles = jsonDecode(response.body)['data'];

    for (var role in roles) {
      if (role['name'] == 'Repetiteur') {
        return role['id'];
      }
    }

    throw Exception('ID du rôle "Repetiteur" non trouvé dans la réponse de l\'API');
  } else {
    throw Exception('Échec du chargement des rôles depuis l\'API');
  }
}

Future<String> fetchParentsRoleId() async {
  final response = await http.get(Uri.parse('http://apirepetiteur.sevenservicesplus.com/api/roles'));

  if (response.statusCode == 200) {
    final List<dynamic> roles = jsonDecode(response.body)['data'];

    for (var role in roles) {
      if (role['name'] == 'Parents') {
        return role['id'];
      }
    }

    throw Exception('ID du rôle "Repetiteur" non trouvé dans la réponse de l\'API');
  } else {
    throw Exception('Échec du chargement des rôles depuis l\'API');
  }
}


