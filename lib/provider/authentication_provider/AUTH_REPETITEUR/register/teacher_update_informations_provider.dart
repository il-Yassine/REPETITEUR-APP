import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_REPETITEURS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';

class TeacherUpdateInformationsProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void updateTeacherInformations({
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

    final teacherToken = GetStorage().read("token");
    final teacherId = GetStorage().read("teacherId");

    var uploadInformationsUrl =
        Uri.https(requestBaseUrl, '/api/repetiteurs/$teacherId');

    debugPrint('ID DU REPETITEUR::::: $teacherId');

    var client = http.Client();

    final body = {
      "commune_id": commune_id,
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
      var request = await client.put(
        uploadInformationsUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer $teacherToken',
        },
      );
      debugPrint(teacherToken);
      debugPrint('${request.statusCode}');
      debugPrint(request.body);

      if (request.statusCode == 200 || request.statusCode == 201) {
        final response = jsonDecode(request.body);

        showMessage(
          message: "Vos informations ont été mises à jour avec succès !",
          backgroundColor: Colors.green,
        );
        Navigator.pushNamed(context!, TeacherHomeScreen.routeName);
        notifyListeners();

        return response;
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
