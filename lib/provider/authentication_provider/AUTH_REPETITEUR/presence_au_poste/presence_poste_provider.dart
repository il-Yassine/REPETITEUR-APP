import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';

class PresenceAuPosteProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  void postPresenceAuPoste({
    String? presencePosteId,
    required String poste,
    required String message,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var postPresencePosteUrl =
        Uri.https(requestBaseUrl, '/api/presenceaupostes/$presencePosteId');

    var client = http.Client();

    final token = GetStorage().read('token');

    final body = {
      "poste": poste,
      "message": message,
    };
    debugPrint('$body');
    debugPrint(token);

    try {
      var response =
          await client.put(postPresencePosteUrl, body: body, headers: {
        'Authorization': 'Bearer $token',
      });
      debugPrint('${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);

        _isLoading = false;

        if (res['success'] == true) {
          _resMessage = "Présence au poste marqué avec succès !";
          notifyListeners();
        } else if (res['success'] == false &&
            res['message'] == 'Validation errors') {
          _resMessage = "Echec lors de l'envoie de la présence au poste !";
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
