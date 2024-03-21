
import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/REPETITEURS/constants.dart';

void showMessage({String? message, Color? backgroundColor, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
      content: Text(
        message!,
        style: TextStyle(color: kWhite),
      ),
      backgroundColor: backgroundColor));
}