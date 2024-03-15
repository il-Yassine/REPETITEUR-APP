import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/login/login_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/routers.dart';

class TeacherRegisteringProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerTeacher({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String role_id,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var teacherRegisterUrl = Uri.https(requestBaseUrl, 'api/auth/register');

    var client = http.Client();

    final body = {
      "role_id": role_id,
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
    };
    print(body);

    try {
      var response = await client.post(teacherRegisterUrl, body: body);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        _isLoading = false;
        if (res['success'] == true) {
          _resMessage = "Compte Créer avec succès !";
          notifyListeners();
          PageNavigator(ctx: context)
              .nextPage(page: const TeacherLoginScreen());
        } else if (res['success'] == false &&
            res['message'] == 'Validation errors') {
          _resMessage = 'L\'email est déjà en cours d\'utilistion';
          notifyListeners();
        }
      } else {
        final res = jsonDecode(response.body);
        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune Connexion Internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Rééssayez encore";
      notifyListeners();

      print("::::: $e");
    }
  }

  /* Future<void> registerTeacher(
      {required String email,
      required String name,
      required String password,
      required String role_id,
      BuildContext? context}) async {
    try {
      String registerTeacherUrl = 'https://' + requestBaseUrl + '/api/auth/register';
      final body = jsonEncode({
        'role_id': role_id,
        'email': email,
        'name': name,
        'password': password
      });

      final response = await http.post(
        Uri.parse(registerTeacherUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print('Le body est: $body');

      if (response.statusCode == 200) {
        print('E marché');
        _isLoading = false;
        final res = jsonDecode(response.body);
        if(res['success'] == true && res['message'] == 'Opération effectuée avec succès'){         
         Navigator.push(context!, MaterialPageRoute(builder: (context) => TeacherLoginScreen()));
         notifyListeners();
        }else if(res['success'] == false && res['message'] == 'Validation errors' ){
          _resMessage = 'L\'email existe';
          notifyListeners();
        }
      } else {
        print('Egbè biii :)');
        final res = jsonDecode(response.body);
        _resMessage = res['message'];
        print(res);
        _isLoading = false; 
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Erreur lors du register $e');
    }
  }

   */
  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
