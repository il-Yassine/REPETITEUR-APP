// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';

class TeacherAddingInformationProvider extends ChangeNotifier {
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
        'http://apirepetiteur.wadounnou.com/api/users?name=$name');

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

  Future<void> sendNotification(String teacherId) async {
    String? adminUserId = await getUserIdByName("Supper Admin");

    final teacherToken = GetStorage().read("token");

    if (adminUserId != null) {
      final notificationUrl = Uri.parse(
          'http://apirepetiteur.wadounnou.com/api/notifications');

      var client = http.Client();

      final body = {
        "repetiteur_id": teacherId,
        "type": "repetiteur",
        "user_id": adminUserId,
        "message": "Nouveau répétiteur",
      };
      debugPrint('$body');

      try {
        var notificationRequest = await client.post(
          notificationUrl,
          body: body,
          headers: {
            'Authorization': 'Bearer $teacherToken',
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

  void addTeacherInformations({
    required String matricule,
    required String adresse,
    required String cycle,
    required String commune_id,
    required String phone,
    String? profil_imageUrl,
    String? diplome_imageUrl,
    String? casierJudiciaire,
    String? attestationResidence,
    String? identite,
    required String description,
    required String ecole,
    required String heureDisponibilite,
    required String grade,
    required String dateLieuNaissance,
    required String situationMatrimoniale,
    required String niveauEtude,
    required String sexe,
    required String experience,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final teacherUserId = GetStorage().read("teacherUserId");
    final teacherToken = GetStorage().read("token");

    var uploadInformationsUrl = Uri.https(requestBaseUrl, '/api/repetiteurs');

    var client = http.Client();

    final body = {
      "user_id": teacherUserId,
      "commune_id": commune_id,
      "matricule": matricule,
      "cycle": cycle,
      "diplome_imageUrl": diplome_imageUrl,
      "profil_imageUrl": profil_imageUrl,
      "phone": phone,
      "adresse": adresse,
      "description": description,
      "dateLieuNaissance": dateLieuNaissance,
      "situationMatrimoniale": situationMatrimoniale,
      "niveauEtude": niveauEtude,
      "heureDisponibilite": heureDisponibilite,
      "identite": identite,
      "casierJudiciaire": casierJudiciaire,
      "attestationResidence": attestationResidence,
      "sexe": sexe,
      "grade": grade,
      "ecole": ecole,
      "experience": experience,
    };

    debugPrint('réponse du body ::: $body');

    try {
      var request = await client.post(
        uploadInformationsUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer $teacherToken',
        },
      );
      print(teacherToken);
      print(request.statusCode);
      print(request.body);

      if (request.statusCode == 200 || request.statusCode == 201) {
        final res = jsonDecode(request.body);
        final teacherId = res['data']['id'];

        GetStorage().write('teacherId', teacherId);

        debugPrint("repetiteur_id ::: $teacherId");

         // Nouvelle requête POST pour les notifications
          await sendNotification(teacherId);
          
        _isLoading = false;
        notifyListeners();

        if (res['success'] == true) {
          /* _resMessage = "Vos informations ont été mises à jour avec succès !"; */
          showMessage(
            message: "Vos informations ont été mises à jour avec succès !",
            backgroundColor: Colors.green,
          );

          Navigator.pushNamed(context!, TeacherHomeScreen.routeName);

          notifyListeners();
          /* PageNavigator(ctx: context)
              .nextPageOnly(page: const AddingInfoSuccessScreen()); */
        } else if (res['success'] == false &&
            res['message'] == 'Validation errors') {
          _resMessage = "Quelque chose s'est mal passée !";
          notifyListeners();
        }
      } else {
        final res = jsonDecode(request.body);
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
    notifyListeners();
  }
}
