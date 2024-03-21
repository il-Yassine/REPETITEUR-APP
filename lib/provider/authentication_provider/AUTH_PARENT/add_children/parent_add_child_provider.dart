import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';

class ParentAddChildProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void parentAddChilds({
    required String lname,
    required String fname,
    required String phone,
    required String sexe,
    required String adresse,
    required String parents_id,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var addChildsUrl = Uri.https(requestBaseUrl, '/api/enfants');

    var client = http.Client();

    final body = jsonEncode({
      "lname": lname,
      "fname": fname,
      "phone": phone,
      "adresse": adresse,
      "parents_id": parents_id,
      "sexe": sexe,
    });

    print(body);

    try {
      final token = GetStorage().read('token');
      if (token == null) {
        _isLoading = false;
        _resMessage = "Token non trouvé";
        notifyListeners();
        return;
      }
      var response = await client.post(
        addChildsUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        final res = jsonDecode(response.body);
        _isLoading = false;
        if (res.containsKey('success') && res['success'] == true) {
          _resMessage = "Votre enfant a été ajouté avec succès !";
          notifyListeners();
        } else if (res.containsKey('message')) {
          _resMessage = res['message'];
          print(res);
          _isLoading = false;
          notifyListeners();
        }
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
