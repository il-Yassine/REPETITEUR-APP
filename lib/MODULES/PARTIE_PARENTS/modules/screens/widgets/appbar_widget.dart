import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:repetiteur_mobile_app_definitive/core/utils/size_config.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.038,),
              Container(
                margin: const EdgeInsets.only(right: 8,),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 0)
                    ),
                  ]
                ),
                child: const Icon(LineIcons.bars),
              ),
            ],
          ),
        )
      ],
    );
  }
}
