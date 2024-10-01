import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/select_role_page/selected_role_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  String _token = "";

  String _userId = "";

  String get token => _token;

  String get userId => _userId;

  void saveToken(String token) async {
    SharedPreferences value = await _preferences;
    value.setString('token', token);
  }

  void saveUserId(String id) async {
    SharedPreferences value = await _preferences;
    value.setString('id', id);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _preferences;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _preferences;

    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

  Future<void> getUserInfo() async {
    final token = await getToken();
    if (token.isNotEmpty) {
      final profileUrl =
          Uri.parse('http://www.api-mon-encadreur.com/api/users');
      final response = await http
          .get(profileUrl, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _userId = responseData['id'];
        // Ajoutez d'autres informations utilisateur selon votre structure JSON
        notifyListeners();
      } else {
        // Gérer les erreurs éventuelles lors de la récupération des informations utilisateur
        print('Erreur lors de la récupération des informations utilisateur');
      }
    } else {
      // Gérer le cas où le token est vide
      print('Token vide');
    }
  }

  void logOut(BuildContext context) async {
    final value = await _preferences;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const SelectedRoleScreen());
  }
}
