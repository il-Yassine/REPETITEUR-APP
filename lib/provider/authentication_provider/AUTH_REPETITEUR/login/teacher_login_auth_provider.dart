import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/authentication/info_adding/teacher_adding_infos_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/fetch_all_users_role.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/routers.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';
import 'package:http/http.dart' as http;

class TeacherLoginingProvider extends ChangeNotifier {
  //Le stockage de get
  final userData = GetStorage();

  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;

  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  String? _userId;

  String? _token;

  final userToken = '';

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<List<Map<String, dynamic>>> fetchAllRepetiteurs() async {
    var client = http.Client();
    var repetiteursUrl = Uri.https(requestBaseUrl, 'api/repetiteurs');
    try {
      final response = await client.get(repetiteursUrl);
      debugPrint("etape 1");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        debugPrint("response data : $responseData");
        debugPrint("response body : ${response.body}");
        if (responseData != null && responseData['data'] != null) {
          return List<Map<String, dynamic>>.from(responseData['data']);
        } // userId == responseData['data']['user']['id']
      }
      return [];
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  Future<bool> checkUser(String userId) async {
    try {
      final request = await http.get(
        Uri.parse(
            'http://apirepetiteur.wadounnou.com/api/repetiteurs?user_id=$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (request.statusCode == 200 || request.statusCode == 201) {
        final res = jsonDecode(request.body)['data'];
        if (!res.isEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (erreur) {
      throw Exception("Erreur lors de la vérification, l'erreur est : $erreur");
    }
  }

  void loginTeacher({
    String? email,
    String? phone,
    required String password,
    BuildContext? context,
  }) async {
    _token = await DatabaseProvider().getToken();

    debugPrint('user token :::: $_token');
    _isLoading = true;
    notifyListeners();

    var teacherLoginUrl = Uri.https(requestBaseUrl, 'api/auth/login');

    var client = http.Client();
    final body = {"email": email, "phone": phone, "password": password};
    debugPrint('réponse du body ::: $body');

    try {
      var request = await client.post(teacherLoginUrl, body: body);

      debugPrint(request.body.toString());

      if (request.statusCode == 200 || request.statusCode == 201) {
        final Map<String, dynamic> res = jsonDecode(request.body);
        await usersProfile();
        _token = res['access_token'];
        debugPrint('token utilisateur ::: $_token');

        bool valid = await checkUserRoleId(_token!);

        debugPrint(res.toString());

        if (valid) {
          DatabaseProvider().saveToken(_token!);
          _isLoading = false;
          _resMessage = "Connexion Réussie!";
          String userId = GetStorage().read('teacherUserId').toString();
          bool isValidated = await checkUser(userId);
          if (isValidated == false) {
            PageNavigator(ctx: context)
                .nextPage(page: const TeacherAddingInformationScreen());
          } else if (isValidated == true) {
            PageNavigator(ctx: context)
                .nextPageOnly(page: const TeacherHomeScreen());
            notifyListeners();
          }
        } else {
          _resMessage =
              "Ces identifiants n'existent pas pour ce type de compte. Veuillez créer un compte ou choisir le type approprié";
          notifyListeners();
        }
        notifyListeners();
      } else {
        final Map<String, dynamic> res = json.decode(request.body);

        _resMessage = res['message'] as String;

        debugPrint(res.toString());
        _isLoading = false;
        _resMessage = "Email ou mot de passe incorrect !";
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Aucune connexion internet";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Veuillez rééssayer";
      notifyListeners();

      debugPrint(":::: $e");
    }
  }

  Future<String> usersProfile() async {
    _token = await DatabaseProvider().getToken();
    var client = http.Client();
    var profileUrl = Uri.https(requestBaseUrl, '/api/profile');
    try {
      final response = await client
          .get(profileUrl, headers: {'Authorization': 'Bearer $_token'});
      debugPrint("etape 1");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        debugPrint("response data : $responseData");
        debugPrint("response body : ${response.body}");
        if (responseData != null) {
          _userId = responseData['id'];
          userData.write('teacherUserId', _userId);
          userData.write('teacherUserName', responseData['name']);
          userData.write('teacherUserEmail', responseData['email']);
          userData.write('teacherUserPhone', responseData['phone']);
          userData.write('userProfileImage', responseData['profile_photo_url']);
          userData.write('token', _token);
          debugPrint('id : $_userId');
        }
      }
      return '';
    } catch (e) {
      debugPrint('$e');
      return '';
    }
  }

  String? getUserId() {
    return _userId;
  }

  final profilUrl = "http://apirepetiteur.wadounnou.com/api/profile";

  Future<bool> checkUserRoleId(String token) async {
    try {
      final teacherRoleId = await fetchRepetiteurRoleId();
      final requestForUserData = await http.get(
        Uri.parse(profilUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      if (requestForUserData.statusCode == 200 ||
          requestForUserData.statusCode == 201) {
        final res = jsonDecode(requestForUserData.body);
        debugPrint('La reponse est: $res');
        final roleId = res['role_id'];
        if (roleId == teacherRoleId) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      throw Exception('Error to load user data: $error');
    }
  }

  void clear() {
    _resMessage = "";
    notifyListeners();
  }
}
