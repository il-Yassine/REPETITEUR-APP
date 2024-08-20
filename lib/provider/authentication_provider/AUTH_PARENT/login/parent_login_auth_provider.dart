import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/MODEL/role/fetch_all_users_role.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/routers.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';

class ParentLoginProvider extends ChangeNotifier {
  //Le stockage de get
  final userData = GetStorage();
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  String? _userId;

  String? _token;

  //Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<void> usersProfile() async {
    _token = await DatabaseProvider().getToken();
    //final userId = await DatabaseProvider().getUserId();
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
          userData.write('userName', responseData['name']);
          userData.write('userMail', responseData['email']);
          userData.write('userPhone', responseData['phone']);
          userData.write('userId', _userId);
          userData.write('token', _token);
          debugPrint('id : $_userId');
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void loginParent({
    String? email,
    String? phone,
    required String password,
    BuildContext? context,
  }) async {
    _token = await DatabaseProvider().getToken();

    await usersProfile();

    debugPrint('user token :::: $_token');
    _isLoading = true;
    notifyListeners();

    var parentLoginUrl = Uri.https(requestBaseUrl, 'api/auth/login');

    var client = http.Client();
    final body = {"email": email, "phone": phone, "password": password};
    debugPrint('réponse du body ::: $body');

    try {
      var request = await client.post(parentLoginUrl, body: body);
      debugPrint(request.body.toString());

      if (request.statusCode == 200 || request.statusCode == 201) {
        final Map<String, dynamic> res = jsonDecode(request.body);

        _token = res['access_token'] as String?;
        debugPrint('token utilisateur ::: $_token');

        bool valid = await checkUserRoleId(_token!);

        userData.write('token', _token);

        debugPrint(res.toString());
        if (valid) {
          // Reste du code...
          DatabaseProvider().saveToken(_token!);
          _isLoading = false;
          _resMessage = "Connexion Réussie!";

/******************************************** ENVOIE DE L'ID DU PARENT DANS LA TABLE PARENTS ***************************************************************** */
          String userId = GetStorage().read("userId");

          var sendToParentTableUrl = Uri.https(requestBaseUrl, '/api/parents');

          var response = await client.get(sendToParentTableUrl, headers: {
            'Authorization': 'Bearer ${GetStorage().read("token")}',
            'Content-Type': 'application/json'
          });
          var jsonResponse = jsonDecode(response.body);

          // Parcourir les données pour vérifier si l'ID de l'utilisateur existe
          bool userExists = false;
          for (var item in jsonResponse['data']) {
            if (item['user']['id'] == userId) {
              userExists = true;
              break;
            }
          }

          if (!userExists) {
            final parentBody = jsonEncode({"user_id": userId});
            debugPrint("reponse du parent body : $parentBody");
            await client.post(sendToParentTableUrl, body: parentBody, headers: {
              'Authorization': 'Bearer ${GetStorage().read("token")}',
              'Content-Type': 'application/json'
            });
          }

/******************************************************************************************************************************************** */

          PageNavigator(ctx: context)
              .nextPageOnly(page: const ParentHomeScreen());
          notifyListeners();
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

  final profilUrl = "http://apirepetiteur.wadounnou.com/api/profile";
  Future<bool> checkUserRoleId(String token) async {
    try {
      final parentRoleId = await fetchParentsRoleId();
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
        if (roleId == parentRoleId) {
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
