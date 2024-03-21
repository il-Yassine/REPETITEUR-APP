import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({super.key});

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(12)),
      height: 30,
      width: 30,
      child: PopupMenuButton<String>(
        iconSize: 25,
        onSelected: (String choice) {
          if (choice == 'Quitter l\'application') {
            SystemNavigator.pop();
          }
        }, itemBuilder: (BuildContext context) {
          return [
            'Quitter l\'application',
          ].map((String choice) {
            return PopupMenuItem(value: choice, child: Text(choice));
          }).toList();
      },
      ),
    );
  }
}
