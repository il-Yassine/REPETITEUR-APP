import 'package:flutter/material.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget(
      {super.key,
      required this.text,
      required this.iconData,
      required this.iconColor,});

  final String text;
  final IconData iconData;
  final Color iconColor;
  final double iconsSize = 15;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: iconColor,
        size: iconsSize,
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
      ),
    );
  }
}
