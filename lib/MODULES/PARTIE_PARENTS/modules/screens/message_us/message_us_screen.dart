import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/message_us/widgets/message_us_body.dart';

class MessageUsScreen extends StatelessWidget {
  const MessageUsScreen({super.key});

  static String routeName = '/parent_message_us_page';

  @override
  Widget build(BuildContext context) {
    return MessageUsBody();
  }
}