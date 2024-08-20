import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';

class TeacherPostAppreciationProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void sendTeacherAppreciation({
    required String demandeId,
    required String teacherId,
    required String appreciation_repetiteur,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var postAppreciationUrl = Uri.https(requestBaseUrl, '/api/postes');

    var client = http.Client();

    final token = GetStorage().read('token');

    final body = {
      "demande_id": demandeId,
      "repetiteur_id": teacherId,
      "appreciation_repetiteur": appreciation_repetiteur,
    };
    debugPrint('$body');
    debugPrint(token);

    try {
      var response =
          await client.post(postAppreciationUrl, body: body, headers: {
        'Authorization': 'Bearer $token',
      });
      debugPrint('${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);

        _isLoading = false;

        if (res['success'] == true) {
          _resMessage = "Envoyée avec succès !";
          notifyListeners();
        } else if (res['success'] == false &&
            res['message'] == 'Validation errors') {
          _resMessage = "Echec lors de l'envoie de l'appreciation !";
          notifyListeners();
          // Ajoutez ici le code pour traiter l'échec de validation
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
