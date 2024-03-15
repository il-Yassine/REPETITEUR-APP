import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/popUpMenuScreens/askTeacher/widgets/add_teacher_success_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/routers.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';

class PostDemandProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<String?> getUserIdByName(String name) async {
    final usersUrl = Uri.parse(
        'http://apirepetiteur.sevenservicesplus.com/api/users?name=$name');

    var client = http.Client();

    try {
      var response = await client.get(
        usersUrl,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Assurez-vous que la clé "data" existe dans la réponse
        if (responseData.containsKey('data')) {
          final List<dynamic> users = responseData['data'];

          // Si au moins un utilisateur est trouvé, retournez l'ID du premier utilisateur
          if (users.isNotEmpty) {
            return users[0]['id'].toString();
          } else {
            print('Utilisateur avec le nom $name non trouvé');
            return null;
          }
        } else {
          print('Clé "data" manquante dans la réponse');
          return null;
        }
      } else {
        print(
            'Erreur lors de la récupération de l\'utilisateur: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération de l\'utilisateur: $e');
      return null;
    }
  }

  Future<void> sendNotification(String demandeId) async {
    String? adminUserId = await getUserIdByName("Supper Admin");

    // final teacherUserId = GetStorage().read("teacherUserId");
    final parentToken = GetStorage().read("token");

    if (adminUserId != null) {
      final notificationUrl = Uri.parse(
          'http://apirepetiteur.sevenservicesplus.com/api/notifications');

      var client = http.Client();

      final body = {
        "demande_id": demandeId,
        "type": "demande",
        "user_id": adminUserId,
        "message": "Nouvelle demande",
      };
      debugPrint('$body');

      try {
        var notificationRequest = await client.post(
          notificationUrl,
          body: body,
          headers: {
            'Authorization': 'Bearer $parentToken',
          },
        );
        print(notificationRequest.statusCode);
        print(notificationRequest.body);

        if (notificationRequest.statusCode == 200 ||
            notificationRequest.statusCode == 201) {
          print('Notification envoyée avec succès');
        } else {
          print('Échec de l\'envoi de la notification');
        }
      } catch (e) {
        print('Erreur lors de l\'envoi de la notification : $e');
      }
    } else {
      print('Impossible de trouver l\'ID de l\'utilisateur "Supper Admin"');
    }
  }

  void sendDemand({
    required String tarification_id,
    required String enfants_id,
    required String repetiteur_id,
    String? description,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var postDemandUrl = Uri.https(requestBaseUrl, 'api/demandes');

    var client = http.Client();

    /* final userId = GetStorage().read('userId'); */
    final token = GetStorage().read('token');

    final body = {
      'tarification_id': tarification_id,
      'enfants_id': enfants_id,
      'repetiteur_id': repetiteur_id,
      'description': description,
    };
    debugPrint('$body');
    debugPrint(token);

    try {
      var response = await client.post(postDemandUrl, body: body, headers: {
        'Authorization': 'Bearer $token',
      });
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);

        // Récupérez l'id de la demande depuis le corps de la réponse
        String demandeId = res['data']['id'].toString();
        // Utilisez l'id dans la fonction sendNotification
        await sendNotification(demandeId);

        showMessage(
          message: 'Demande envoyée avec succès !',
          backgroundColor: Colors.green,
          context: context,
        );

        PageNavigator(ctx: context)
            .nextPage(page: const AddTeacherSuccessScreen());

        notifyListeners();

        _isLoading = false;
        if (res['success'] == true) {
          _resMessage = "Demande envoyée !";
          /* notifyListeners();
          PageNavigator(ctx: context)
              .nextPage(page: const AddTeacherSuccessScreen()); */
        } else if (res['success'] == false &&
            res['message'] == 'Validation errors') {
          _resMessage = "Votre demande n'a pas été envoyée !";
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

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
