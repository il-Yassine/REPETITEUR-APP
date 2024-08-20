import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ParentAnswerProvider extends ChangeNotifier {
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void sendAnswer({
    required String appreciationId,
    required String reponseParents,
    BuildContext? context,
  }) async {
    var putAnswerUrl = Uri.parse(
        "http://apirepetiteur.wadounnou.com/api/postes/$appreciationId");

    String token = GetStorage().read("token");

    final body = {
      "appreciation_id": appreciationId,
      "reponse_parents": reponseParents
    };
    debugPrint('$body');
    debugPrint(token);

    try {
      var response = await http.put(putAnswerUrl, body: body, headers: {
        'Authorization': 'Bearer $token',
      });
      debugPrint('${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _resMessage = "Message envoyée !";
        notifyListeners();
      } else {
        _resMessage = "Echecs !";
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
