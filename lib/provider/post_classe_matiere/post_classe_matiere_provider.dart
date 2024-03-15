import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:http/http.dart' as http;

class AddClasseAndCoursesProvider extends ChangeNotifier {
  // Base URL
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';

  ///Setter
  bool _isLoading = false;

  // Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void addClasseAndCourses(
      {required String matiereId,
      required String classeId,
      BuildContext? context}) async {
    _isLoading = true;
    notifyListeners();

    var classeMatiereUrl = Uri.https(requestBaseUrl, '/api/repetiteurmcs');

    var client = http.Client();

    final teacherId = GetStorage().read('teacherId');
    final token = GetStorage().read('token');

    final body = {
      'repetiteur_id': teacherId,
      'matiere_id': matiereId,
      'classe_id': classeId
    };
    debugPrint('$body');
    debugPrint(teacherId);
    debugPrint(token);

    try {
      var response = await client.post(classeMatiereUrl, body: body, headers: {
        'Authorization': 'Bearer $token',
      });
      debugPrint('${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);

        _isLoading = false;

        if (res['success'] == true) {
          _resMessage = "Opération éffectuée avec succès !";
          notifyListeners();
          /* PageNavigator(ctx: context).nextPage(page: const ParentLoginScreen()); */
        } else if (res['success'] == false &&
            res['message'] == 'Validation errors') {
          _resMessage = "Quelque chose s'est mal passée !";
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
}
