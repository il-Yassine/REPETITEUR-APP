import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchRolesIds() async {
  final response = await http.get(Uri.parse('http://apirepetiteur.sevenservicesplus.com/api/roles'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map<String>((role) => role['id']).toList();
  } else {
    throw Exception('Failed to load roles');
  }
}