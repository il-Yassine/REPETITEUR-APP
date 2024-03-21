import 'package:flutter/material.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/widgets/appbar_widget.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/widgets/popup_menu.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8), child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppBarWidget(),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: PopUpMenu(),
        ),
      ],
    ),);
  }
}
