import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/home_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/common_api_url.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/widgets/snack_message.dart';

class ParentSentMessageProvider extends ChangeNotifier {
  final requestBaseUrl = AppUrl.baseUrl;
  String _resMessage = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<String?> getUserIdByName(String name) async {
    final usersUrl = Uri.parse(
        'http://apirepetiteur.sevenservicesplus.com/api/users?name=$name');

    try {
      var response = await http.get(usersUrl);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('data')) {
          final List<dynamic> users = responseData['data'];

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

  Future<void> sendNotification(String messageId) async {
    String? adminUserId = await getUserIdByName("Supper Admin");

    final parentToken = GetStorage().read("token");

    if (adminUserId != null) {
      final notificationUrl = Uri.parse(
          'http://apirepetiteur.sevenservicesplus.com/api/notifications');

      try {
        var notificationRequest = await http.post(
          notificationUrl,
          body: {
            "message_id": messageId,
            "type": "message",
            "user_id": adminUserId,
            "message": "Nouveau message",
          },
          headers: {
            'Authorization': 'Bearer $parentToken',
          },
        );

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

  void parentSentMessage({
    required String fullName,
    required String phoneNumber,
    required String emailAddress,
    String? messageObject,
    required String userMessage,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    var messageUrl = Uri.https(requestBaseUrl, '/api/messages');

    final userId = GetStorage().read('userId');
    final token = GetStorage().read('token');

    final body = {
      'user_id': userId,
      'name': fullName,
      'phone': phoneNumber,
      'objet':
          messageObject ?? '', // Assurez-vous d'avoir une valeur par défaut
      'email': emailAddress,
      'message': userMessage,
    };

    try {
      var response = await http.post(messageUrl, body: body, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);

        String messageId = res['data']['id'].toString();

        await sendNotification(messageId);

        showMessage(
          message: 'Message envoyé avec succès !',
          backgroundColor: Colors.green,
          context: context,
        );

        Get.defaultDialog(
          barrierDismissible: false,
          backgroundColor: kWhite,
          title: "Succès",
          content: Column(
            children: [
              Lottie.asset(
                "assets/lotties/Animation - 1707306278755.json",
                height: SizeConfig.screenHeight * 0.1,
                width: SizeConfig.screenWidth * 1.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context!, ParentHomeScreen.routeName);
                },
                child: const Text("OK"),
              )
            ],
          ),
        );

        _resMessage = "Message envoyé !";
      } else {
        final res = jsonDecode(response.body);
        _resMessage = res['message'];
      }
    } on SocketException catch (_) {
      _resMessage = "Aucune Connexion Internet";
    } catch (e) {
      _resMessage = "Réessayez encore";
      print("::::: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _resMessage = '';
    notifyListeners();
  }
}
