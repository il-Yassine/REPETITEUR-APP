import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ParentPaymentProvider extends ChangeNotifier {
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

  Future<void> sendNotification(String paiementId) async {
    String? adminUserId = await getUserIdByName("Supper Admin");

    // final teacherUserId = GetStorage().read("teacherUserId");
    final parentToken = GetStorage().read("token");

    if (adminUserId != null) {
      final notificationUrl = Uri.parse(
          'http://apirepetiteur.wadounnou.com/api/notifications');

      var client = http.Client();

      final body = {
        "demande_id": paiementId,
        "type": "payer",
        "user_id": adminUserId,
        "message": "Paiement éffectué",
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

  void makePayment({
    String? paymentId,
    String? reference,
    String? status,
    BuildContext? context,
  }) async {
    var putPayementUrl = Uri.parse(
        "http://apirepetiteur.wadounnou.com/api/payements/$paymentId");

    String token = GetStorage().read("token");

    final body = {
      "payements_id": paymentId,
      "reference": reference,
      "status": status,
    };
    debugPrint('$body');
    debugPrint(token);

    try {
      var response = await http.put(putPayementUrl, body: body, headers: {
        'Authorization': 'Bearer $token',
      });
      debugPrint('${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);

        String paiementId = res['data']['id'].toString();

        await sendNotification(paiementId);

        _isLoading = false;
        _resMessage = "Payement éffectué !";

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
